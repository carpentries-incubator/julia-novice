---
title: Using the REPL
teaching: 18
exercises: 2
---

::::::::::::::::::::::::::::::::::::::: objectives

- Explore basic functionality of input.
- Learn how to declare variables.
- Learn about REPL modes.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How to use the REPL?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Entering the REPL

Melissa and her classmates open a terminal and launch `julia`:

```bash
julia
```

```output
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.0 (2021-11-30)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```

This is the so-called REPL, which stands for
**r**ead-**e**valuate-**p**rint-**l**oop. The interactive command-line REPL
allows quick and easy execution of Julia statements.

Like the terminal, the Julia REPL has a prompt, where it awaits input:

```julia
julia>
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Implicit prompt

Most of the code boxes that follow *do not show the `julia>` prompt*, even
though it's there in the REPL. Why?

It's important to delineate input (what you type) and output (how the
machine responds). The prompt can be confusing, so it is excluded. You may
assume that any **Julia** box prepends the prompt on each line of input.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Variables

The first thing they try is to perform basic arithmetic operations:

```julia
1 + 4 * 7.3
```

```output
30.2
```

That works as expected.
It is also possible to bind a name to a value via the assignment operator `=`,
which makes it easier to refer to the value later on.
These names are called *variables*.

```julia
distance = 30.2
distance_x_2 = 2 * distance
```

```output
60.4
```

Melissa notices that assignment also returns the value.
She can also check which variables are defined in the current session by
running

```julia
varinfo()
```

```output
  name                    size summary
  –––––––––––––––– ––––––––––– –––––––
  Base                         Module
  Core                         Module
  InteractiveUtils 270.164 KiB Module
  Main                         Module
  ans                  8 bytes Float64
  distance             8 bytes Float64
  distance_x_2         8 bytes Float64
```

## Unicode

In Julia, Unicode characters are also allowed as variables like `α = 2`.
Unicode characters can be entered by a backslash followed by their [LaTeX
name][latex] and then pressing <kbd>tab</kbd> (in this case
`\alpha`<kbd>tab</kbd>).

## REPL-modes

Unfortunately Melissa can't remember the LaTeX name of ∂ so she copies the
character, presses <kbd>?</kbd> for help mode,

```julia
?
```

pastes the ∂ character, then presses enter:

```julia
help?> ∂
```

```output
"∂" can be typed by \partial<tab>
```

Great! This way she can easily look up the names she needs.
She gets back to normal mode by pressing <kbd>backspace</kbd>.

Another useful mode is the ***shell mode*** that can be entered by pressing
<kbd>;</kbd>. The prompt has now changed:

```julia
;
```

```julia
shell>
```

Shell mode can be used to issue commands to the underlying shell, but don't
confuse it with an actual shell: special shell syntax like piping won't work.
Like before, hit <kbd>backspace</kbd> to get back to the Julia prompt.

:::::::::::::::::::::::::::::::::::::::  challenge

## Hello, **`shell>`**!

Use the shell mode to create a file called `hello.jl` with the nano terminal text editor.
Inside that file write the simple hello world program `print("Hello World")`.

Check the content of the file using `cat hello.jl` and then run the program using `julia hello.jl`.

:::::::::::::::  solution

## Solution

```julia
;
```

```julia
shell> nano hello.jl
shell> cat hello.jl
```

```output
print("Hello World")
```

```julia
shell> julia hello.jl
```

```output
Hello World
```

<kbd>backspace</kbd>



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

Finally there is ***package mode*** that is entered with <kbd>]</kbd> which is
used for package management, which will be covered later on:

```julia
]
```

```julia
pkg>
```

To exit ***shell***, ***help*** or ***pkg*** mode, hit <kbd>backspace</kbd>.



[latex]: https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols


:::::::::::::::::::::::::::::::::::::::: keypoints

- The REPL reads the given input, evaluates the given expression and prints the resulting output to the user.
- Pressing <kbd>?</kbd> enters help mode.
- Pressing <kbd>;</kbd> enters shell mode.
- Pressing <kbd>\]</kbd> enters pkg mode.

::::::::::::::::::::::::::::::::::::::::::::::::::


