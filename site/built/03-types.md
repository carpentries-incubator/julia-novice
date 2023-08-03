---
title: Julia type system
teaching: 15
exercises: 5
---

::::::::::::::::::::::::::::::::::::::: objectives

- Understand the structure of the type tree.
- Know how to traverse the type tree.
- Know how to build mutable and immutable types.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What is the use of types?
- How are types organized in Julia?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Structuring variables

Melissa wants to keep the variables corresponding to the trebuchet
(`counterweight`, `release_angle`) separate from the variables coming from the
environment (`wind`, `target_distance`).
That is why she chooses to group them together using *structures*.
There are two structure types:

- immutable structures, whose fields can not be changed after creation
  - keyword: `struct`
- mutable structures, whose fields can change after creation
  - keyword: `mutable struct`

Since Melissa wants to change the parameters of the trebuchet, she uses a
`mutable struct` for it.
But she cannot influence the environment and thus uses a `struct` for those
values.

```julia
mutable struct Trebuchet
  counterweight::Float64
  release_angle::Float64
end

struct Environment
  wind::Float64
  target_distance::Float64
end
```

### Types and hierarchy

Here `::Float64` is a type specification, indicating that this variable should
be a 64-bit floating point number, and **`::`** is an ***operator*** that
is read "is an instance of."
If Melissa hadn't specified the type, the variables would have the type `Any`
by default.

In Julia every type can have only one supertype, so let's count how many types
are between `Float64` and `Any`:

1. ```julia
  supertype(Float64)
  ```
  ```output
  AbstractFloat
  ```
2. ```julia
  supertype(AbstractFloat)
  ```
  ```output
  Real
  ```
3. ```julia
  supertype(Real)
  ```
  ```output
  Number
  ```
4. ```julia
  supertype(Number)
  ```
  ```output
  Any
  ```

So we have the relationship `Float64 <: AbstractFloat <: Real <: Number <: Any`
where [**`<:`** is the ***subtype operator***][subtype], used here to mean the item
on the left "is a subtype of" the item on the right.

`Float64` is a *concrete* type, which means that you can actually create
objects of this type.
For example `1.0` is an object of type `Float64`.
We can check this at the REPL using either (or both) the
`typeof` function or the [`isa` operator][isa]:

```julia
typeof(1.0)
1.0 isa Float64
```

```output
Float64
true
```

All the other types are *abstract* types that are used to address groups of
types.
For example, if we declare a variable as `a::Real` then it can be bound to any
value that is a subtype of `Real`.

Let's quickly check what are all the subtypes of `Real`:

```julia
subtypes(Real)
```

```output
4-element Array{Any,1}:
 AbstractFloat
 AbstractIrrational
 Integer
 Rational
```

This way the types form a tree with abstract types on the nodes and concrete
types as leaves.
Have a look at this visualization of all subtypes of `Number`:
![][hierarchy]{alt='Type\_tree-Number'}

:::::::::::::::::::::::::::::::::::::::  challenge

## Is it **Real**?

For which of the following types `T` would the following return
`false`?

```julia
1.0 isa T
```

1. Real
2. Number
3. Float64
4. Integer

:::::::::::::::  solution

## Solution

The correct answer is 4:
while `1` is an integer, `1.0` is a floating-point value.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Creating a subtype

A concrete type can be made a subtype of an abstract type with the
subtype operator **`<:`**.
Since `Trebuchet` contains several fields that are mutable Melissa thinks it is
a good idea to make it a subtype of `AbstractVector`.

:::::::::::::::::::::::::::::::::::::::::  callout

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
using a name that's already in use.

::::::::::::::::::::::::::::::::::::::  discussion

## Restart the REPL

In Julia it is not very easy to redefine `struct`s.
It is necessary to restart the REPL to define the new definition of
`Trebuchet`, or take a different name instead.



::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

***Melissa decides to keep going and come back to this later.***



[subtype]: https://docs.julialang.org/en/v1/base/base/#Core.:%3C:
[isa]: https://docs.julialang.org/en/v1/base/base/#Core.isa
[hierarchy]: https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Type-hierarchy-for-julia-numbers.png/1200px-Type-hierarchy-for-julia-numbers.png


:::::::::::::::::::::::::::::::::::::::: keypoints

- In Julia types have only one direct supertype.

::::::::::::::::::::::::::::::::::::::::::::::::::


