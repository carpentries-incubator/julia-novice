---
title: "Julia type system"
teaching: 15
exercises: 5
---

:::::: questions

## Questions

  - "What is the use of types?"
  - "How are types organized in Julia?"

::::::

:::::: objectives

## Objectives

  - "Understand the structure of the type tree."
  - "Know how to traverse the type tree."
  - "Know how to build mutable and immutable types."

::::::


## Types and hierarchy

In the [previous episode](02_Getting_started.jl) we observed that `varinfo` does not only shows the names of bindings,
but also the types of the bounded values.
```julia
 name                    size summary
 –––––––––––––––– ––––––––––– –––––––
 ...
 distance             8 bytes Float64
 distance_x_2         8 bytes Float64
```
We could have specified the type we wanted by writing

````julia
distance::Float64 = 30.2
````

````output
30.2
````

or for example

````julia
distance_f::Float32 = 30.2
````

````output
30.2
````

to get the same number with a less precise number type, which saves memory at the cost of less precise results.

Here `::Float64` is a type specification, indicating that this variable should
be a 64-bit floating point number, and __`::`__ is an *operator* that
is read "is an instance of."

In Julia every type can only have one supertype, so let's count how many types
are between `Float64` and `Any`:

**1.**

````julia
supertype(Float64)
````

````output
AbstractFloat
````

**2.**

````julia
supertype(AbstractFloat)
````

````output
Real
````

**3.**

````julia
supertype(Real)
````

````output
Number
````

**4.**

````julia
supertype(Number)
````

````output
Any
````

So we have the relationship `Float64 <: AbstractFloat <: Real <: Number <: Any`
where [__`<:`__ is the *subtype operator*](https://docs.julialang.org/en/v1/base/base/#Core.:%3C:), used here to mean the item
on the left "is a subtype of" the item on the right.

`Float64` is a _concrete_ type, which means that you can actually create
objects of this type.
For example `1.0` is an object of type `Float64`.
We can check this at the REPL using either (or both) the
`typeof` function or the [`isa` operator](https://docs.julialang.org/en/v1/base/base/#Core.isa):

````julia
typeof(1.0)
````

````output
Float64
````

or

````julia
1.0 isa Float64
````

````output
true
````

In general, it is necessary to call **the constructor** of a type to create an instance of a type, like so:

````julia
Float32(1)
````

````output
1.0f0
````

For certain literal values that is not the case, since they are the default like `1.0 == Float64(1)`, but that is an exception.

All the other types are _abstract_ types that are used to address groups of
types.
For example, if we declare a variable as `a::Real` then it can be bound to any
value that is a subtype of `Real`.

Let's quickly check what are all the subtypes of `Real`:

````julia
subtypes(Real)
````

````output
4-element Vector{Any}:
 AbstractFloat
 AbstractIrrational
 Integer
 Rational
````

This way the types form a tree with abstract types on the nodes and concrete
types as leaves.
Have a look at this visualization of all subtypes of `Number`:
![Type_tree-Number](https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Type-hierarchy-for-julia-numbers.png/1200px-Type-hierarchy-for-julia-numbers.png){alt=""}

:::::: challenge

## Is it Real?

For which of the following types `T` would the following return
`false`?

```julia
1.0 isa T
```

 1. Real
 2. Number
 3. Float64
 4. Integer <!---correct-->

:::::: solution

## Solution

The correct answer is 4:
while `1` is an integer, `1.0` is a floating-point value.

::::::


::::::

## Structuring variables
In addition to basic types like numbers and strings, there are also composite types, which are used to group variables that belong together.

Melissa wants to keep the variables corresponding to the trebuchet
(`counterweight`, `release_angle`) separate from the variables coming from the
environment (`wind`, `target_distance`).
That is why she chooses to group them together using _structures_.
There are two structure types:

- immutable structures, whose fields can not be changed after creation
 - keyword: `struct`
- mutable structures, whose fields can change after creation
 - keyword: `mutable struct`

Since Melissa wants to change the parameters of the trebuchet, she uses a
`mutable struct` for it.
But she cannot influence the environment and thus uses a `struct` for those
values.

````julia
mutable struct Trebuchet
  counterweight::Float64
  release_angle::Float64
end

struct Environment
  wind::Float64
  target_distance::Float64
end
````

:::::: caution

## Caution

```julia
 struct Environment
   wind
   target_distance
 end
```

is equivaelnt to

```julia
 struct Environment
   wind::Any
   target_distance::Any
 end
```

which is a common performance trap.

::::::

## Instances
So far Melissa only defined the layout of her new types `Trebuchet` and `Environment`.
To actually create a value of this type she has to call the so called _constructor_, which is a function with the same name as the corresponding type and as many arguments as there are fields.

````julia
trebuchet = Trebuchet(500, 0.25pi)
````

````output
Trebuchet(500.0, 0.7853981633974483)
````

Note, how the values will get converted to the specified field type.

````julia
environment = Environment(5, 100)
````

````output
Environment(5.0, 100.0)
````

`trebuchet` is being called an _instance_ or _object_ of the type `Trebuchet`.
There can only ever be one definition of the type `Trebuchet` but you can create many instances of that type with different values for its fields.

Once an object has been created, you can access the values stored in its
fields using a dot (`.`) followed by the field name.
This lets us inspect the data stored in a particular instance.

````julia
trebuchet.counterweight
trebuchet.release_angle
````

````output
0.7853981633974483
````

## Creating a subtype

A concrete type can be made a subtype of an abstract type with the
subtype operator __`<:`__.
Because Melissa thinks `Trebuchet` should be used essentially like a `Vector` it would be
a good idea to make it a subtype of `AbstractVector`.

:::::: callout

## Caveat: Redefining Structs

```julia
mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end
```

```error
ERROR: invalid redefinition of constant Trebuchet
Stacktrace:
[1] top-level scope
   @ REPL[9]:1
```

This error message is clear: you're not allowed to define a `struct`
using a name that's already in use prior to Julia 1.12.
For Julia versions 1.12 or greater it is possible, but any objects defined before the redefinition still are objects of the old type until you reassign them.

:::::: caution

## Restart the REPL

In Julia it is not very easy to redefine `struct`s.
It is necessary to restart the REPL to define the new definition of
`Trebuchet`, or take a different name instead.

::::::


::::::

*Melissa decides to keep going and come back to this later.*

:::::: spoiler

## `UnionAll` types

There is at least one type we did not cover here, which is the `UnionAll` type.
For example `Vector{<:Number}` is the type fo the union of all vectors whose elements have a common type which is a subtype of `Number`.
This is different from `Vector{Number}` which is a concrete type of a vector whose elements have a potentially different subtype of `Number`, e.g. `[1, 2.0, 3f0]`.
Notably, since it is a concrete type, it cannot have subtypes, so `Vector{Float64} <: Vector{<:Number}` is `true`, but `Vector{Float64} <: Vector{Number}` is `false`.
That is a common source of confusion.

::::::

:::::: keypoints

## Keypoints

  - "In Julia types have only one direct supertype."

::::::

