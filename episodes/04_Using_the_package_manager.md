---
title: "Using the package manager"
teaching: 20
exercises: 0
---

:::::: questions

## Questions

  - "Where do I find packages?"
  - "How do I add packages?"
  - "How can I use packages?"

::::::

:::::: objectives

## Objectives

  - "Learn to add packages using pkg-mode"
  - "Learn to resolve name conflicts"
  - "Learn to activate environments"

::::::

## The package manager

:::::: callout

## The package Manager

This chapter focuses on the package mode available within the REPL.

A different aproach would be using the <kbd>Pkg</kbd> notation.

```julia
using Pkg
Pkg.add("Example")
```

If you prefer to use that method and want to know more, remember how to get [help](02_Getting_started.md).

_(for exp. <kbd>?Pkg.add</kbd>)_

::::::

Now it is time for Melissa and their mates to simulate the launch of the
trebuchet.
The necessary equations are really complicated, but an investigation on
[JuliaHub](https://juliahub.com/) revealed that someone already implemented
these and published it as the Julia package [`Trebuchet.jl`](https://juliahub.com/ui/Search?q=trebuchet&type=packages).
That saves some real work.

Melissa enters package mode by pressing <kbd>]</kbd>:

```julia
]
```

The `julia>` prompt becomes a blue `pkg>` prompt that shows the Julia version
that Melissa is running.

After consulting the [documentation](https://julialang.github.io/Pkg.jl/v1/)
she knows that the prompt is showing the _currently activated environment_ and
that this is the global environment that is activated by default.

However, she doesn't want to clutter the global environment when working on her
project.
The default global environment is indicated with `(@v1.x)` before the `pkg>` prompt, where `x` is the minor version number of julia, so on julia 1.7 it will look like `(@v1.7)`.
To create a new environment she uses the `activate` function of the package manager:

```julia
(@v1.x) pkg> activate projects/trebuchet
```


````
  Activating project at `~/projects/trebuchet`
````

In this environment she adds the `Trebuchet` package from its
open source code [repository on GitHub](https://github.com/FluxML/Trebuchet.jl) by typing

```julia
(trebuchet) pkg> add Trebuchet
```

Melissa quickly recognizes that far more packages are being installed than just
`Trebuchet`.
These are the dependencies of `Trebuchet`.
From the output

```output
[...]
Updating `[...]/projects/trebuchet/Project.toml`
  [98b73d46] + Trebuchet v0.2.1
  Updating `[...]/projects/trebuchet/Manifest.toml`
  [1520ce14] + AbstractTrees v0.3.3
  [79e6a3ab] + Adapt v1.1.0
  [...]
```

she sees that two files were created: `Project.toml` and `Manifest.toml`.

The project file `Project.toml` only contains the packages needed for her
project, while the manifest file `Manifest.toml` records the direct and
indirect dependencies as well as their current version, thus providing a fully
reproducible record of the code that is actually executed.
"That is really handy when I want to share my work with the others," thinks
Melissa.

After the installation finished she can check the packages present in her
environment.

```julia
(trebuchet) pkg> status
```


````
Status `~/projects/trebuchet/Project.toml`
  [f6369f11] ForwardDiff v0.10.36
  [295af30f] Revise v3.5.7
  [98b73d46] Trebuchet v0.2.2

````

:::::: callout

## Why use GitHub?

Melissa could have added the GitHub version of Trebuchet.jl by typing

```julia
(trebuchet) pkg> add Trebuchet#master
```

In this case the JuliaHub version is the same as the GitHub version,
so Melissa does not need to specify the installation.

If you know a package is stable, go ahead and install the default version registered on JuliaHub.
Otherwise, it’s good to check how different that version is from the current state of the software project.
Click through the link under “Repository” on the JuliaHub package page.

::::::

### `deactivate` does not exist, instead ...

Melissa can get back to the global environment using `activate` without any parameters.
Note, that any packages that were loaded in the old environment are still loaded in the new environment.

```julia
(trebuchet) pkg> activate
```

### Environments stack

What is installed in the default environment can also be loaded in other environments.
That is useful for development time convenience packages like `BenchmarkTools` or `JuliaFormatter`.

Melissa now returns to her project environment.

```julia
(trebuchet) pkg> activate projects/trebuchet
```

## Using and importing packages

Now that Melissa added the package to her environment, she needs to load it.
Julia provides two keywords for loading packages: `using` and `import`.

The difference is that `import` brings only the name of the package into the
namespace and then all functions in that package need the name in front
(prefixed).
But packages can define a list of function names to export, which means the
functions should be brought into the user's namespace when he loads the package
with `using`.
This makes working at the REPL more convenient.

### Name conflicts

It may happen that name conflicts arise.
For example Melissa defined a structure named `Trebuchet`, but the package she
added to the environment is also named `Trebuchet`.
Now she would get an error if she tried to `import`/`using` it directly.
One solution is to assign a nickname or alias to the package upon `import`
using the keyword *`as`*:

````julia
import Trebuchet as Trebuchets
````

:::::: keypoints

## Keypoints

  - "Find packages on JuliaHub"
  - "add packages using `pkg> add`"
  - "use many small environments rather than one big environment"

::::::

