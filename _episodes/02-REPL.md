---
title: "Using the REPL"
teaching: 20
exercises: 0
questions:
- "How to use the REPL?"
objectives:
- "Explore basic functionality of input."
- "Learn how to declare variables."
- "Learn about REPL modes."
keypoints:
- "The REPL reads the given input, evaluates the given expression and prints the resulting output to the user."
- "Pressing <kbd>?</kbd> enters help mode."
- "Pressing <kbd>;</kbd> enters shell mode."
- "Pressing <kbd>]</kbd> enters pkg mode."
- "Functions are compiled when first called with a given set of arguments and cached for later reuse."
- "Redefinition of functions is possible with the Revise package."

---

# Entering the REPL

## Variables

After downloading and executing a julia binary from https://julialang.org Melissa and her classmates face the so called REPL, which stands for <u>r</u>ead-<u>e</u>valuate-<u>p</u>rint-<u>l</u>oop.
The first thing they try is to perform basic arithmetic operations
~~~
1 + 4 * 7.3
~~~
{: .language-julia}
~~~
30.2
~~~
{: .output}

That works as expected.
It is also possible to bind names to values via the assignment operator `=`, which makes it easier to refer to them later on.
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

## Unicode

In julia also unicode characters are allowed as variables like `α = 2`.
Where unicode characters can be entered by a backslash followed by their LaTeX-name and then pressing <kbd>tab</kbd> (in this case `\alpha`<kbd>tab</kbd>).

## REPL-modes

Unfortunately Melissa can't remember the LaTeX name of ∂ so she copies the character, presses <kbd>?</kbd> to enter the help mode, pastes the character and gets
~~~
help?> ∂
"∂" can be typed by \partial<tab>
~~~
{: .output}

Great! This way she can easily look up the names she needs.
She gets back to normal mode by pressing backspace.

Another useful mode is the shell mode that can be entered by pressing <kbd>;</kbd>.
It can be used to use commands of the underlying shell, but don't confuse it with an actual shell: Special shell syntax like piping won't work.

Finally there is the package mode that is enetered with <kbd>]</kbd> which is used for package management, which will be covered later on.

{% include links.md %}

