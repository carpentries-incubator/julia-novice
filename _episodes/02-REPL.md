---
title: "Using the REPL"
teaching: 18
exercises: 2
questions:
- "How to use the REPL?"
objectives:
- "Explore basic functionality of input."
- "Learn how to declare variables."
- "Learn about REPL modes."
keypoints:
- "The REPL reads the given input, evaluates the given expression and prints the resulting output to the user."
- "Pressing `?` enters help mode."
- "Pressing `;` enters shell mode."
- "Pressing `]` enters pkg mode."

---

# Entering the REPL

## Variables

After downloading and executing a Julia binary from
[julialang.org](https://julialang.org), Melissa and her classmates face the so
called REPL, which stands for **r**ead-**e**valuate-**p**rint-**l**oop. The
interactive command-line REPL allows quick and easy execution of Julia
statements.
The first thing they try is to perform basic arithmetic operations:

~~~
1 + 4 * 7.3
~~~
{: .language-julia}
~~~
30.2
~~~
{: .output}

That works as expected.
It is also possible to bind a name to a value via the assignment operator `=`,
which makes it easier to refer to the value later on.
These names are called _variables_.

~~~
distance = 30.2
distance_x_2 = 2 * distance
~~~
{: .language-julia}
~~~
60.4
~~~
{: .output}

Melissa notices that assignment also returns the value.
She can also check which variables are defined in the current session by
running

~~~
julia> varinfo()
  name                    size summary
  –––––––––––––––– ––––––––––– –––––––
  Base                         Module
  Core                         Module
  InteractiveUtils 270.164 KiB Module
  Main                         Module
  ans                  8 bytes Float64
  distance             8 bytes Float64
  distance_x_2         8 bytes Float64
~~~
{: .language-julia}

## Unicode

In Julia, Unicode characters are also allowed as variables like `α = 2`.
Unicode characters can be entered by a backslash followed by their LaTeX-name
and then pressing `tab` (in this case `\alpha``tab`).

## REPL-modes

Unfortunately Melissa can't remember the LaTeX name of ∂ so she copies the
character, presses `?` to enter the help mode, pastes the character and gets

~~~
help?> ∂
"∂" can be typed by \partial<tab>
~~~
{: .output}

Great! This way she can easily look up the names she needs.
She gets back to normal mode by pressing backspace.

Another useful mode is the shell mode that can be entered by pressing `;`.
The prompt has now changed to shell.
It can be used to issue commands of the underlying shell, but don't confuse it
with an actual shell: Special shell syntax like piping won't work.

> ## Hello shell mode
>
> Use the shell mode to start nano and save your first `.jl` file
{: .challenge}

Finally there is the package mode that is entered with `]` which is used for
package management, which will be covered later on.
To exit the shell or pkg mode use `backspace`.

{% include links.md %}
