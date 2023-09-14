---
title: "Interfaces & conditionals"
teaching: 30
exercises: 30
---

:::::: questions

## Questions

  - "How to use conditionals?"
  - "What is an interface?"

::::::

:::::: objectives

## Objectives


::::::

## Conditionals

Before starting to work in a new document, Melissa has to:

Activate her environment

````julia
using Pkg
Pkg.activate(joinpath(@__DIR__, "projects", "trebuchet"))
Pkg.instantiate()
````

````
  Activating project at `~/projects/trebuchet`

````

Importing the package under its modified name

````julia
import Trebuchet as Trebuchets
````

Defining the structures

````julia
mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end

struct Environment
  wind::Float64
  target_distance::Float64
end

Base.size(::Trebuchet) = tuple(2)
````

Now that Melissa knows that she has to add a method for
````
getindex(trebuchet::Trebuchet, i::Int)
````
she thinks about the implementation.

If the index is `1` she wants to get the `counterweight` field and if the index is `2`
she wants to get `release_angle` and since these are the only two fields she
wants to return an error if anything else comes in.
In Julia the keywords to specify conditions are `if`, `elseif` and `else`,
closed with an `end`.
Thus she writes

````julia
function Base.getindex(trebuchet::Trebuchet, i::Int)
    if i === 1
        return trebuchet.counterweight
    elseif i === 2
        return trebuchet.release_angle
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end
````

And tries again:

````julia
trebuchet = Trebuchet(500, 0.25pi)
````

````output
2-element Trebuchet:
 500.0
   0.7853981633974483
````

Notice, that the printing is different from our `trebuchet` in [the former episode](03_Julia_type_system.md).

### Interfaces

Why is that?
By subtyping `Trebuchet` as `AbstractVector` we implicitly opted into
a widespread _interface_ in the Julia
language: `AbstractArray`s.
An interface is a collection of methods that should be implemented by all subtypes of the interface type in order for generic code to work.
For example, the [Julia manual](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array) lists all methods that a subtype of
`AbstractArray` need to implement to adhere to the `AbstractArray` interface:

- `size(A)` returns a tuple containing the dimensions of `A`
- `getindex(A, i::Int)` returns the value associated with index `i`
- `setindex!(A, v, i::Int)` writes a new value `v` at the index `i` (optional)

Now, that Melissa implemented the mandatory methods for this interface for the `Trebuchet` type, it will work
with every function in `Base` that accepts an `AbstractArray`.
She tries a few things that now work without her writing explicit code for it:

````julia
trebuchet + trebuchet
````

````output
2-element Vector{Float64}:
 1000.0
    1.5707963267948966
````

````julia
using LinearAlgebra
dot(trebuchet, trebuchet)
````

````output
250000.61685027508
````

````julia
trebuchet * transpose(trebuchet)
````

````output
2×2 Matrix{Float64}:
 250000.0    392.699
    392.699    0.61685
````

That is, it now behaves like you would expect from an ordinary matrix.

Now she goes about implementing the missing optional method for `setindex!` of the `AbstractArray` interface.

:::::: challenge

## Implement `setindex!`

Write the missing method for `setindex(trebuchet::Trebuchet, v, i::Int)` similar to Melissas `getindex` function.

:::::: solution

## Solution

```julia
function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
     if i === 1
         trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end
```

::::::


::::::


With the new `Trebuchet` defined with a complete `AbstractArray` interface,
Melissa tries her new method to modify a counterweight by index:

````julia
trebuchet[1] = 2
````

````output
2
````

````julia
trebuchet
````

````output
2-element Trebuchet:
 2.0
 0.7853981633974483
````

:::::: keypoints

## Keypoints

  - "Interfaces are informal"
  - "Interfaces facilitate code reuse"
  - "Conditions use `if`, `elseif`, `else` and `end`"

::::::

