using Distributed
while nprocs() < min(4, length(Sys.cpu_info()))
    addprocs(1)
end
@everywhere using Pkg
@everywhere Pkg.activate(@__DIR__)
Pkg.instantiate()
Pkg.precompile()
# Defining a function that will replace "import("...")" with the content of the imported file

@everywhere function replace_includes(str)

    included = ["definition.jl"]

    # Here the path loads the files from their proper directory,
    # which may not be the directory of the `examples.jl` file!
    path=string(@__DIR__,"/")

    for ex in included
        content = read(path*ex, String)
        str = replace(str, "include(\"$(ex)\")" => content)
    end
    return str
end

# Defining a funtion that will replace "print(io, raw""" " with empty space
@everywhere function md_print(str)
    str = replace(str, "print(io, raw\"\"\"" => "")
    return str
end

# Defining a funtion that will replace ".ipynb" with ".md"
@everywhere function setup_link_replace(str)
    str = replace(str, ".ipynb" => ".md")
    return str
end

@everywhere function handle_repl(str)
    str = replace(str, "```julia-repl" => "```julia")
    return str
end

@everywhere function carpentries_div_names(str)
    str = replace(str, r"!!! (sc|mc|freecode)" => "!!! challenge",
        r"!!! (tip|info|note)" => "!!! callout",
        )
    return str
end

@everywhere function remove_sandbox_output(str)
    str = replace(str, r"Main\.var\".*\"\." => "")
    return str
end

@everywhere function fix_activation_output(str)
    str = replace(str, r"~/.*/projects/trebuchet" => "~/projects/trebuchet")
    str = replace(str, r".*Updating registry ((?:\n|.)*?)````" => "````")
    return str
end

function copy_project(output)
    out_proj = joinpath(@__DIR__, "output", output, "projects", "trebuchet")
    mkpath(out_proj)

cp(joinpath(@__DIR__, "projects", "trebuchet", "Project.toml"), string(out_proj, "/Project.toml"), force=true)
cp(joinpath(@__DIR__, "projects", "trebuchet", "Project.toml"), string(out_proj, "/Project.toml"), force=true)
end
# Copying the manifest.toml and project.toml into the output directories

copy_project("markdown")
copy_project("notebooks")
copy_project("carpentries")

# Defining the functions to automatically generate the notebooks and markdowns with literate.jl
@everywhere begin
using Literate

files = filter(contains(r"[0-9]{1,2}\w*.jl"), readdir(@__DIR__, join=true))
notebook_out = joinpath(@__DIR__, "output", "notebooks")
markdown_out = joinpath(@__DIR__, "output", "markdown")
lesson_out = joinpath(@__DIR__, "output", "carpentries")
end

pmap(files) do file
    # Literate.notebook(file, notebook_out; execute=false, preprocess = replace_includes)
    # Literate.markdown(file, markdown_out; credit = false, execute=true, preprocess = replace_includes, postprocess = md_print∘setup_link_replace)
    if contains(file, "Overview") || contains(file, "Creating_Packages") return end
    Literate.markdown(file, lesson_out; credit = false, execute=true, flavor=Literate.CarpentriesFlavor(), preprocess = replace_includes∘carpentries_div_names, postprocess = setup_link_replace∘remove_sandbox_output∘handle_repl∘fix_activation_output)
end
Literate.markdown(only(filter(contains("Creating_Packages"), files)), lesson_out; credit = false, execute=true, flavor=Literate.CarpentriesFlavor(), preprocess = replace_includes∘carpentries_div_names, postprocess = setup_link_replace∘remove_sandbox_output∘handle_repl∘fix_activation_output)
@everywhere Pkg.activate(@__DIR__)
