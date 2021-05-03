---
title: "Using the package manager"
teaching: 30
exercises: 0
questions:
- 
objectives:
- 
keypoints:
- 
- 
---

## The package manager

Now it is time for Melissa and their mates to simulate the launch of the trebuchet.
The necessary equations are really complicated, but an investigation on https://juliahub.com/ revealed that someone already implemented these and published it as the julia package `Trebuchet.jl`.
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
{% include links.md %}
