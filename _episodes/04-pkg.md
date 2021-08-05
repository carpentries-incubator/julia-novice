---
title: "Using the package manager"
teaching: 20
exercises: 0
questions:
- "Where do I find packages?"
- "How do I add packages?"
- "How can I use packages?"
objectives:
- "Learn to add packages using pkg-mode"
- "Learn to resolve name conflicts"
- "Learn to activate environments"
keypoints:
- "Find packages on juliahub"
- "add packages using `pkg> add`"
- "use many small environments rather than one big environment"
---

## The package manager

Now it is time for Melissa and their mates to simulate the launch of the trebuchet.
The necessary equations are really complicated, but an investigation on [juliahub](https://juliahub.com/) revealed that someone already implemented these and published it as the julia package `Trebuchet.jl`.
That spares some real work.

Melissa enters the package mode by pressing <kbd>]</kbd>.
The `julia>` prompt becomes a blue prompt that reads the julia version that Melissa is running.
After consulting the [documentation](https://julialang.github.io/Pkg.jl/v1/) she knows that the prompt is showing the currently activated environment and that this is the global environment that is activated by default.

However, she doesn't want to clutter the global environment when working on her project, so she creates a new environment via
~~~
(v1.x) pkg> activate projects/trebuchet
~~~
{: .language-julia}

In this environment she adds the `Trebuchet` package by typing
~~~
(trebuchet) pkg> add Trebuchet
~~~
{: .language-julia}

Melissa quickly recognizes that far more packages are being installed than just `Trebuchet`.
These are the dependencies of `Trebuchet`.

From the output
~~~
[...]
Updating `[...]/projects/trebuchet/Project.toml`
  [98b73d46] + Trebuchet v0.2.1
  Updating `[...]/projects/trebuchet/Manifest.toml`
  [1520ce14] + AbstractTrees v0.3.3
  [79e6a3ab] + Adapt v1.1.0
  [...]

~~~
{: .output}

she sees that two files were created: `Project.toml` and `Manifest.toml`.

The project file `Project.toml` only contains the packages needed for her project, while the manifest file `Manifest.toml` records the direct and indirect dependencies as well as their current version, thus providing a fully reproducible record of the code that is actually executed.
"That is really handy when I want to share my work with the others." thinks Melissa.

## Using and importing packages

Now that Melissa added the package to her environment, she needs to load it.
Julia provides two keywords for loading packages `using` and `import`.

The difference is that `import` brings only the name of the package into the namespace and then all functions in that package needs the name in front.
But packages can also define an export list for function names that should be brought into the users namespace when he loads the package with `using`.
This makes working at the REPL often more convenient.

### Name conflicts

It may happen that name conflicts arise.
For example defined Melissa a structure named `Trebuchet`, but the package she added to the environment is also named `Trebuchet`.
Now she would get an error if she tried to `import`/`using` it directly.
One solution is to rename the package upon `import` with `as`.
~~~
import Trebuchet as Trebuchets
~~~
{: .language-julia}

{% include links.md %}
