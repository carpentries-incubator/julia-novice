---
title: "Using Modules"
teaching: 15
exercises: 0
---

:::::: questions

## Questions

  - "What's the purpose of modules?"

::::::

:::::: objectives

## Objectives

  - "Structure your code using modules"
  - "Use Revise.jl to track changes"

::::::

## Modules

Melissa now has a bunch of definitions in her running Julia session and using
the REPL for interactive exploration is great, but it is more and more taxing
to keep in mind what is defined, and all the definitions are lost once she
closes the REPL.

That is why she decides to put her code in a file.
She opens up her text editor and creates a file called `aim_trebuchet.jl` in
the current working directory and pastes the code she got so far in there.
This is what it looks like:

````julia
using Pkg
Pkg.activate("projects/trebuchet")
import Trebuchet as Trebuchets
using ForwardDiff: gradient

mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end

Base.copy(trebuchet::Trebuchet) = Trebuchet(trebuchet.counterweight, trebuchet.release_angle)

Base.size(trebuchet::Trebuchet) = tuple(2)

Base.getindex(trebuchet::Trebuchet, i::Int) = getfield(trebuchet, i)

function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
    if i === 1
        trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end

struct Environment
  wind::Float64
  target_distance::Float64
end

function shoot_distance(windspeed, angle, weight)
    Trebuchets.shoot(windspeed, angle, weight)[2]
end

function shoot_distance(args...)
    Trebuchets.shoot(args...)[2]
end

function shoot_distance(trebuchet::Trebuchet, env::Environment)
    shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end

function aim(trebuchet::Trebuchet, environment::Environment; ε = 1e-1, η = 0.05)
    better_trebuchet = copy(trebuchet)
    hit = x -> (shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance)
    while abs(hit(better_trebuchet)) > ε
        grad = gradient(hit, better_trebuchet)
        better_trebuchet -= η * grad
    end
    return Trebuchet(better_trebuchet[1], better_trebuchet[2])
end

imprecise_trebuchet = Trebuchet(500.0, 0.25pi)

environment = Environment(5, 100)

precise_trebuchet = aim(imprecise_trebuchet, environment)

shoot_distance(precise_trebuchet, environment)

````

Now Melissa can run `include("aim_trebuchet.jl")` in the REPL to execute her code.

She also recognizes that she has a bunch of definitions at the beginning that
she doesn't need to execute more than once in a session and some lines at the
end that use these definitions which she might run more often.
She will split these in two separate files and put the definitions into a
_module_.
The module will put the definitions into their own namespace which is the
module name.
This means Melissa would need to put the module name before each definition if
she uses it outside of the module.
But she remembers from the
[Using the package manager Episode](04_Using_the_package_manager.md)
that she can export names that
don't need to be prefixed.

She names her module `MelissasModule` and accordingly the file
`MelissasModule.jl`.
From this module she exports the names `aim`, `shoot_distance`, `Trebuchet` and
`Environment`.
This way she can leave her other code unchanged.

````julia
module MelissasModule

using Pkg
Pkg.activate("projects/trebuchet")
import Trebuchet as Trebuchets
using ForwardDiff: gradient

export aim, shoot_distance, Trebuchet, Environment

mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end

Base.copy(trebuchet::Trebuchet) = Trebuchet(trebuchet.counterweight, trebuchet.release_angle)

Base.size(trebuchet::Trebuchet) = tuple(2)

Base.getindex(trebuchet::Trebuchet, i::Int) = getfield(trebuchet, i)

function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
    if i === 1
        trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end

struct Environment
  wind::Float64
  target_distance::Float64
end

function shoot_distance(windspeed, angle, weight)
    Trebuchets.shoot(windspeed, angle, weight)[2]
end

function shoot_distance(args...)
    Trebuchets.shoot(args...)[2]
end

function shoot_distance(trebuchet::Trebuchet, env::Environment)
    shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end

function aim(trebuchet::Trebuchet, environment::Environment; ε = 1e-1, η = 0.05)
    better_trebuchet = copy(trebuchet)
    hit = x -> (shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance)
    while abs(hit(better_trebuchet)) > ε
        grad = gradient(hit, better_trebuchet)
        better_trebuchet -= η * grad
    end
    return Trebuchet(better_trebuchet[1], better_trebuchet[2])
end
end # MelissasModule

````

The rest of the code goes to a file she calls `MelissasCode.jl`.

````julia
using .MelissasModule

imprecise_trebuchet = Trebuchet(500.0, 0.25pi)
environment = Environment(5, 100)
precise_trebuchet = aim(imprecise_trebuchet, environment)
shoot_distance(precise_trebuchet, environment)

````

Now she can include `MelissasModule.jl` once, and change and include
`MelissasCode.jl` as often as she wants.
But what if she wants to make changes to the module?
If she changes the code in the module, re-includes the module and runs her code
again, she only gets a bunch of warnings, but her changes are not applied.

## Revise.jl

`Revise.jl` is a package that can keep track of changes in your files and load
these in a running Julia session.

Melissa needs to take two things into account:

- `using Revise` must come before `using` any Package that she wants to be
  tracked
- she should use `includet` instead of `include` for included files (`t` for
  "tracking")

Thus she now runs

````julia
using Revise


includet(joinpath(@__DIR__,"MelissasModule.jl"))
include(joinpath(@__DIR__,"MelissasCode.jl"))
````

````output
100.05601729579894
````

and any change she makes in `MelissasModule.jl` will be visible in the next run
of her code.

:::::: callout

## Did I say any changes?

Well, almost any. Revise can't track changes to structures.

::::::

:::::: keypoints

## Keypoints

  - "Modules introduce namespaces"
  - "Public API has to be documented and can be exported"

::::::

