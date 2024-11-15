# !!! yaml
#     ---
#     title: "Using the REPL"
#     teaching: 18
#     exercises: 2
#     ---
#
# !!! questions
#      - "How to use the REPL?"
#
# !!! objectives
#     - "Explore basic functionality of input."
#     - "Learn how to declare variables."
#     - "Learn about REPL modes."


#md # ## Entering the REPL
#md # Melissa and her classmates open a terminal and launch `julia`:

#nb # # <div align="center"> Getting started with IJulia </div>
#nb # ## Installing IJulia

#nb # Before Melissa and her classmates are able to use Julia within a Jupyter Notebook
#nb # they need to install the `IJulia` Kernel.
#nb # A Kernel is the "computational engine" of the Notebook and executes the code cells.
#nb #
#nb # To get started with the installation, they open a terminal and launch `julia`:

# ```bash
# julia
# ```


# ```julia-repl
#                _
#    _       _ _(_)_     |  Documentation: https://docs.julialang.org
#   (_)     | (_) (_)    |
#    _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
#   | | | | | | |/ _` |  |
#   | | |_| | | | (_| |  |  Version 1.7.2 (2022-02-06)
#  _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
# |__/                   |
# julia>
# ```


# This is the so-called REPL, which stands for
# **r**ead-**e**valuate-**p**rint-**l**oop. The interactive command-line REPL
# allows quick and easy execution of Julia statements.

# Like the terminal, the Julia REPL has a prompt, where it awaits input:

# ```julia-repl
# julia>
# ```

#md # !!! note "implicit promt"
#md #     Most of the code boxes that follow *do not show the `julia>` prompt*, even
#md #     though it's there in the REPL. Why?
#md #
#md #     It's important to delineate input (what you type) and output (how the
#md #     machine responds). The prompt can be confusing, so it is excluded. You may
#md #     assume that any **Julia** box prepends the prompt on each line of input.


#nb # To now install the needed `IJulia` Kernel for a Jupyter Notebook, they type:
#-

#nb # ```bash
#nb # julia> using Pkg
#nb # julia> Pkg.add("IJulia")
#nb # julia> Pkg.build("IJulia")
#nb # ```
#-

#nb # <kbd>Pkg</kbd> helps install remote or local packages.
#nb # More to <kbd>Pkg</kbd> in Chapter 4.
#nb #
#nb # When they open a new Notebook `IJulia` is a selectable Kernel.

# !!! tip "Visual Studio Code"
#md #     An alternative to using the REPL through a terminal is
#nb #     An alternative to using `IJulia` within a notebook is
#     to work with <b>V</b>isual <b>S</b>tudio <b>C</b>ode or its open source altenative VSCodium.
#     VSC is a source code editor for which a `julia` extension is available.
#     After installing the application, simply click on the <kbd>"Extension"</kbd> symbol on the left side and
#     search for `julia`.
#     Once installt `julia` remains usable and can be selected as a programming language in new documents.
#
#     For further guidance and visual aid, check out the provided [video](https://av.tib.eu/media/62060)!


# ### Variables
#
# The first thing they try is to perform basic arithmetic operations:

1 + 4 * 7.3


# That works as expected.
# It is also possible to bind a name to a value via the assignment operator `=`,
# which makes it easier to refer to the value later on.
# These names are called *variables*.

distance = 30.2
distance_x_2 = 2 * distance

# Melissa notices that assignment also returns the value.
# She can also check which variables are defined in the current session by
# running

#nb varinfo()

#md # ```julia
#md # varinfo()
#md # ```

#md # ```output
#md #  name                    size summary
#md #  –––––––––––––––– ––––––––––– –––––––
#md #  Base                         Module
#md #  Core                         Module
#md #  InteractiveUtils 270.164 KiB Module
#md #  Main                         Module
#md #  ans                  8 bytes Float64
#md #  distance             8 bytes Float64
#md #  distance_x_2         8 bytes Float64
#md # ```

# ### Unicode
#
# In Julia, Unicode characters are also allowed as variables like `α = 2`.
# Unicode characters can be entered by a backslash followed by their [LaTeX
# name](https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols) and then pressing <kbd>tab</kbd> (in this case
# `\alpha`<kbd>tab</kbd>).

#md # ### REPL-modes
#nb # ### Different prefacing modes
#
# Unfortunately Melissa can't remember the LaTeX name of ∂ so she copies the character
#md # , presses <kbd>?</kbd> for help mode,
#nb # and adds a <kbd>?</kbd> in front of it.
#
#md # ```julia-repl
#md # ?
#md # ```

#md # pastes the ∂ character, then presses enter:

#md # ```julia-repl
#md # help?> ∂
#md # ```

#md # ```output
#md # "∂" can be typed by \partial<tab>
#md # ```

#nb  ?∂

# Great! This way she can easily look up the names she needs.
#md # She gets back to normal mode by pressing <kbd>backspace</kbd>.

# !!! challenge "Exploring Julia's Help Mode"
#      Help mode can also be used to look up the documentation for Julia functions.
#      Use Julia's help mode to read the documentation for the `varinfo()` function.
#
#     !!! solution
#md #      If you are not already in help mode, type `?` to enter it. Then write `varinfo` and press enter.
#md #
#md #         ```julia-repl
#md #         ?varinfo
#md #         ```
#nb #         ```julia
#nb #         ?varinfo
#nb #         ```

# Another useful mode is the *shell mode* that can be
#md # entered by pressing <kbd>;</kbd>. The prompt has now changed:
#nb # used by prefacing a shell command with a <kbd>;</kbd>.

#md # ```julia-repl
#md # shell>
#md # ```

#nb ; echo "print(\"Hello World\")"

# Shell mode can be used to issue commands to the underlying shell, but don't
# confuse it with an actual shell: special shell syntax like piping won't work.
#md # Like before, hit <kbd>backspace</kbd> to get back to the Julia prompt.

# !!! challenge "Hello, `shell>` (`pwd` and `cd`) !"
#md #      Two commonly used shell commands are `pwd` (**p**rint **w**orking **d**irectory) and `cd` (**c**hange **d**irectory).
#md #      1. Use `pwd` to find out what is your current working directory.
#md #      2. Type the command `cd` in shell mode, which by default will bring you to your "home directory".
#md #      3. Use `pwd` again. Did you get a different result from before? Why or why not?
#     !!! solution
#md #         ```julia-repl
#md #         shell> pwd
#md #         ```
#md #
#md #         ```julia-repl
#md #         shell> cd
#md #         ```
#md #
#md #         ```julia-repl
#md #         shell> pwd
#md #         ```
#md #
#md #      The working directory is the location from which you launched Julia.
#md #      To navigate to a different directory, you can use the `cd` command by entering: `cd <directory>`. By default, this command will return you to your home directory if a specific directory is not given.
#md #      If you initially launched Julia from your home directory, the working directory remains unchanged, so the output of the second `pwd` command will be identical to the first.
#md #      Conversely, if you were in a different directory when you started Julia, the results of the two `pwd` commands will differ.
#md #      You can use `cd -` to go back to your previous location.

# !!! challenge "Hello, `shell>` (`ls`)!"
#md #      Another useful shell command is `ls` (*list files*).
#md #      Use it to show the contents of your home directory.
#     !!! solution
#md #         ```julia-repl
#md #         shell> cd
#md #         ```
#md #
#md #         ```julia-repl
#md #         shell> ls
#md #         ```
#md #
#md #      The first `cd` command will bring you to your home directory.
#md #      `ls` will print a list of the files and directorys in your current location.

# !!! challenge "Hello, `shell>` (`nano` and `cat`)!"
#md #      Use the shell mode to create a file called `hello.jl` with the nano terminal text editor.
#md #      Inside that file write the simple hello world program `print("Hello World!")`.
#md #
#md #      Check the content of the file using `cat hello.jl` and then run the program using `julia hello.jl`.
#md #
#nb #      The standard shell operator <kbd>|</kbd>, <kbd> > </kbd> and <kbd>&</kbd> do not work within IJulia notebooks.
#nb #      Try using the pipeline command to achieve:
#nb #      - write `print("Hello World!")` into a file called `hello.jl` (For help, remember `?pipeline`)
#nb #      - check the content of that file with `cat hello.jl`
#nb #      - run the program with `julia hello.jl`
#     !!! solution
#md #         ```julia-repl
#md #         ;
#md #         ```
#md #
#md #         ```julia-repl
#md #         shell> nano hello.jl
#md #         shell> cat hello.jl
#md #         ```
#md #
#md #         ```output
#md #         print("Hello World!")
#md #         ```
#md #
#md #         ```julia-repl
#md #         shell> julia hello.jl
#md #         ```
#md #
#md #         ```output
#md #         Hello World!
#md #         ```
#md #
#md #         <kbd>backspace</kbd>
#md #
#nb #         ```julia
#nb #         run(pipeline(`echo "print(\"Hello World!\")"`, stdout="hello.jl"))
#nb #         ```
#nb #
#nb #         ```julia
#nb #         ; cat hello.jl
#nb #         ```
#nb #
#nb #         > ```julia
#nb #         > print("Hello World!")
#nb #         > ```
#nb #
#nb #         ```julia
#nb #         ; julia hello.jl
#nb #         ```
#nb #         > ```julia
#nb #         > Hello World!
#nb #         > ```
#nb #


#md # Finally there is *package mode* that is entered with <kbd>]</kbd> which is
#md # used for package management, which will be covered later on:

#nb # Finally there is *package mode* that is prefaced with <kbd>]</kbd> which is
#nb # used for package management, which will be covered later on:

#md # ```julia-repl
#md # ]
#md # ```
#md #
#md # ```julia-repl
#md # pkg>
#md # ```

#nb # ```julia
#nb # ]
#nb # ```

#md # To exit *shell*, *help* or *pkg* mode, hit <kbd>backspace</kbd>.

# !!! keypoints
#     - "The REPL reads the given input, evaluates the given expression and prints the resulting output to the user."
#     - "Pressing <kbd>?</kbd> enters help mode."
#     - "Pressing <kbd>;</kbd> enters shell mode."
#     - "Pressing <kbd>]</kbd> enters pkg mode."
