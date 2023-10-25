---
title: "Introduction"
teaching: 5
exercises: 0
---

:::::: questions

## Questions

  - "What is Julia?"
  - "Why use Julia?"

::::::

:::::: objectives

## Objectives

  - "Explain the difference between interpreted and compiled programming languages"
  - "Compare how composing works in Julia and some common programming languages"

::::::

## What is a programming language?

A programming language mediates between the natural language of humans and the
machine instructions of a computer.
The human specifies what the computer should compute on a high level using the
programming language.
This specification will be translated to machine instructions, the so called
assembly code, which will be executed by the processor (CPU, GPU, ...).

### Interpreting and compiling

This translation happens differently depending on the programming language you
use.
There are mainly two different techniques: *compiling* and *interpreting*.
Interpreted languages such as Python and R translate instructions one at a
time, while compiled languages like C and Fortran take whole documents, analyze
the structure of the code, and perform optimizations before translating it to
machine code.

This leads to more efficient machine instructions of the compiled code at the
cost of less flexibility and more verbose code.
Most prominently, compiled languages need an explicit type declaration for each
variable.

## Why Julia?

Julia is a programming language that superficially looks like an interpreted
language and mostly behaves like one.
But before each function is executed it will be compiled *just in time*.

Thus you get the flexibility of an interpreted language and the execution speed
of a compiled language at the cost of waiting a bit longer for the first
execution of any function.

There is another aspect of Julia that makes it interesting and that is the way
packages compose.
This is captured the best by an analogy from [Sam Urmy](https://github.com/ElOceanografo):

> Say you want a toy truck.
>
> The Python/R solution is to look for the appropriate package–like buying a
> Playmobil truck. It comes pre-manufactured, well-engineered and tested, and
> does 95% of what you would ever want a toy truck to do.
>
> The Fortran/C solution is to build the truck from scratch. This allows total
> customization and you can optimize the features and performance however you
> want. The downside is that it takes more time, you need woodworking skills,
> and might hurt yourself with the power tools.
>
> The Julia solution is like Legos. You can get the truck kit if you want–which
> will require a bit more assembly than the Playmobil, but way less than
> building it from scratch. Or, you can get the component pieces and assemble
> the truck to your own specs. There’s no limit to what you can put together,
> and because the pieces all have the same system of bumps, everything snaps
> together quickly and easily.
>
> <p align="center">
> ![](https://global.discourse-cdn.com/julialang/original/3X/5/2/52e63856ad9e23876cda4297a04171879fa625b4.jpeg){width="600" height="400" alt=""}
> </p>
>
> OK, sure. Toy trucks are like linear algebra, though, a common request, and
> every “toy system” will have an implementation that works basically fine. But
> what if you want a time-traveling sailing/space ship with lasers AND dragon
> wings? And it should be as easy to build and use as a basic dump truck?
>
> <p align="center">
> ![](https://global.discourse-cdn.com/julialang/original/3X/2/8/2865d34fb35c181dc3c5c0f0b71915f31310269c.jpeg){ width="600" height="400" alt=""}
> </p>
>
> There’s a reason that only Lego ever made anything like Dr. Cyber’s Flying
> Time Vessel!

Originally posted on [Discourse](https://discourse.julialang.org/t/what-is-the-advantage-of-julia-over-fortran/65964/101).

:::::: keypoints

## Keypoints

  - "Julia is a just-in-time compiled language"
  - "Julia packages compose well"

::::::

