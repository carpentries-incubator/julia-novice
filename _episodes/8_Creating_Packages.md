```@meta
EditURL = "https://gitlab.uni-hannover.de/comp-bio/julia-trebuchet/blob/master/8_Creating_Packages.jl"
```

!!! carp
    ---
    title: "Creating Packages"
    teaching: 15
    exercises: 15
    ---

    :::::: questions
    - "How to create a package?"
    ::::::

     ::::::objectives
    - "Learn setting up a project using modules."
    - "Learn common package structure."
    - "Learn to browse GitHub or juliahub for packages and find documentation."
    ::::::

# <div align="center"> Creating Packages </div>

Melissa is now confident that her module is fine and she wants to make it
available for the rest of her physics club.
She decides to put it in a package.
This way she can also locally use Julia's package manager for managing her
module.

## From project to package
-----------------

The path from having a module to having a package is actually very short:
Packages need a `name` and a `uuid` field in their `Project.toml`.

A UUID is a **u**niversally **u**nique **id**entifier.
Thankfully Julia comes with the `UUIDs` package, that can generate `uuid`s for
Melissa via `UUIDs.uuid4()`.

In addition Melissa needs to have a specific directory structure.
She looks at the example package [`Example.jl`](https://github.com/JuliaLang/Example.jl) which has the following
structure:

```julia
├── docs
│   ├── make.jl
│   ├── Project.toml
│   └── src
│       └── index.md
├── LICENSE.md
├── Project.toml
├── README.md
├── src
│   └── Example.jl
└── test
    └── runtests.jl
```

!!! note "Make it a package"
    Open your `Project.toml` and add `name = <your name>`, `uuid = <your uuid>`
    and optionally an `authors` field, each on a separate line.

Now Melissa can use

```julia
pkg> dev . # or path to package instead of `.`
```

instead of needing to `includet MelissasModule.jl`, and she can write
`using MelissasModule` instead of `.using MelissasModule`.

## Register a package
-----------------

In order for her friends to be able to get the package, Melissa registers the
package in the _general registry_.
This can be done either via [JuliaHub](https://juliahub.com/ui/Registrator) or by making a pull request on
[GitHub](https://github.com/JuliaRegistries/General/pulls) which can also be automated by the [Julia Registrator](https://github.com/JuliaRegistries/Registrator.jl).

## Creating a new package
-----------------

Melissa thinks next time she will start with a package right away.

Browsing the packages she found [PkgTemplates.jl](https://invenia.github.io/PkgTemplates.jl/stable/) and [PkgSkeleton.jl](https://github.com/tpapp/PkgSkeleton.jl)
which makes setting up the typical folder structure very easy.

!!! note "Create your own package"
    Look at the documentation of the package creation helper packages and create
    a new package using `generate`.

!!! carp
    :::::: keypoints
    - "The general registry is hosted on GitHub."
    - "Packaging is easy"
    ::::::

