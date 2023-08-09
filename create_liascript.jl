using Markdown
using Random
# Don't try this at home, unless you _are_ a pirate
function Markdown.plain(io::IO, list::Markdown.List)
    for (i, item) in enumerate(list.items)
        print(io, Markdown.isordered(list) ? "$(i + list.ordered - 1). " : "  - ")
        lines = split(rstrip(sprint(Markdown.plain, item)), "\n")
        for (n, line) in enumerate(lines)
            print(io, (n == 1 || isempty(line)) ? "" : "    ", line)
            n < length(lines) && println(io)
        end
        i == length(list.items) || println(io)
    end
end
lia_path = mkpath(joinpath(pwd(), "output", "liascript"))

md_files = filter(endswith(".md"), readdir(joinpath(pwd(), "output", "markdown"), join = true))

liascript = Markdown.MD()
for (i, file) in enumerate(md_files)
    lines = readlines(file, keep = true)
    local md = Markdown.parse(join(lines))
    md.content = filter(x -> !(x isa Markdown.Code && x.language == "@meta"), md.content)
    # lines = filter(!startswith("<summary>"), lines)
    # lines = replace.(lines, "<b>" => "**", "</b>" => "**")
    for (i, el) in enumerate(md.content)
        md.content[i] = if el isa Markdown.List && Markdown.isordered(el)
            # check for <!-- correct --> tag
            if any(el.items) do item
                content = item[1].content
                str = findfirst(==("–"), content)
                str !== nothing && contains(content[str+1], "correct")
            end
                Markdown.List([
                    Any[Markdown.Paragraph(
                        (content = item[1].content;
                        str = findall(==("–"), content);
                        (!isempty(str) && contains(content[str[1]+1], "correct")) ?
                         (content[str[1]-1] = replace(content[str[1]-1], "<!" => ""); pushfirst!(content, "[[X]] ");content[1:str[1]]) :
                         pushfirst!(content, "[[ ]] ")
                        )
                    )] for item in el.items
                ], -1, el.loose)
            else
                el
            end
        elseif el isa Markdown.Paragraph && el.content[1] isa String && contains(el.content[1], "<details>")
            previous = md.content[i-1]
            if previous isa Markdown.Paragraph
                if startswith(previous.content[1], r"Hint:"i)
                    previous.content[1] = replace(previous.content[1], r"Hint:"i => "\n\n[[$(randstring(10))]]\n[[?]]")
                    push!(previous.content, "\n***********")
                else
                    push!(previous.content, "\n\n[[$(randstring(10))]]\n***********")
                end
                el.content[1] = ""
                el
            else
                el.content[1] = "***********"
                el
            end
        elseif el isa Markdown.Paragraph && el.content[1] isa String && contains(el.content[1],"</details>")
            el.content[1] = replace(el.content[1], "</details>" => "***********\n")
            el
        # elseif el isa Markdown.Paragraph && el.content[1] isa String && startswith(el.content[1],r"Hint:"i)
        #     el.content[1] = replace(el.content[1], r"Hint:"i => "[[?]]")
        #     el
        elseif el isa Markdown.Code && el.language == ""
            el.language = "@output"
            el
        elseif el isa Markdown.Table
            for row in el.rows
                for item in row
                    iitem = !isempty(item) ? only(item) : item
                    if iitem isa Markdown.Link
                        iitem.text = [text isa Markdown.Italic ? "\\_" * only(text.text) * "\\_" : replace(text, "_" => "\\_") for text in iitem.text]
                        iitem.url = replace(iitem.url, "_" => "\\_")
                    elseif iitem isa String
                        item[1] = replace(iitem, r"&#\d+;" => "")
                    end
                end
            end
            el
        else
            el
        end
    end
    if i != 1
        replace!(md.content) do el
            if el isa Markdown.Header
                N = typeof(el).parameters[1]
                return Markdown.Header{N+1}(el.text)
            else
                return el
            end
        end
    end
    append!(liascript.content, md.content)
end
open(joinpath(lia_path, "Programming_in_julia.md"), "w") do io
    println(io,"""
<!--
author: Simon Christ
email:  christ@cell.uni-hannover.de
version: 0.1.0
language: en

logo: https://raw.githubusercontent.com/JuliaLang/julia-logo-graphics/master/images/julia-logo-color.png
icon: https://raw.githubusercontent.com/JuliaLang/julia-logo-graphics/master/images/julia-logo-color.png
-->
    """)
    println(io, liascript)
end
