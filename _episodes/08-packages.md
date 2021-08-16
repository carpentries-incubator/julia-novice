---
title: "Creating Packages"
teaching: 15
exercises: 15
questions:
- "How to create a package?"
objectives:
- "Learn setting up a project using modules."
- "Learn common package structure."
- "Learn to browse github or juliahub for packages and find documentation."
keypoints:
- "The general registry is hosted on github."
- "Packaging is easy"
---

Melissa is now confident that her module fine and she wants to make it available for the rest of her physics club.
She decides to put it in a package.
This way she can also locally use julias package manager for managing her module.

## From project to package

The path from having a module to having a package is actually very short: Packages need a `name` and a `uuid` field in their `Project.toml`.

A `uuid` is a universally unique identifier.
Thankfully julia comes with the `UUIDs` package, that can generate `uuid`s for Melissa via `UUIDs.uuid4()`.

In addition Melissa needs to have a specific directory structure.
She looks at the example package [`Example.jl`](https://github.com/JuliaLang/Example.jl) which has the following structure
~~~
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
~~~
{: .output}

> ## Make it a package
> Open your `Project.toml` and add `name = <your name>`, `uuid = <your uuid>` and optionally an `authors` field.
> Each on a separate line.
{: .challenge}

Now Melissa can use
~~~
pkg> dev . # or path to package instead of `.`
~~~
{: .language-julia}
instead of needing to `includet` `MelissasModule.jl` and use `using MelissasModule` instead of `.using MelissasModule`.

## Register a package

In order for her friends to be able to get the package the registers the package in the _general registry_.
Either via [juliahub](https://juliahub.com/ui/Registrator) or by making a pull request on [github](https://github.com/JuliaRegistries/General/pulls) which can also be automated by the [julia registrator](https://github.com/JuliaRegistries/Registrator.jl).

## Creating a new package

Melissa thinks next time she will start with a package right away.

Browsing the packages she found [PkgTemplates.jl](https://invenia.github.io/PkgTemplates.jl/stable/) and [PkgSkeleton.jl](https://github.com/tpapp/PkgSkeleton.jl) which makes setting up the typical folder structure very easy.

> ## Create your own package
> Look at the documentation of the package creation helper packages and create a new package using `generate`.
{: .challenge}

{% include links.md %}
