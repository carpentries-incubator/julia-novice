---
title: "Julia type system"
teaching: 60
exercises: 0
questions:
- "What is the use of types?"
- "How are types organized in julia?"
objectives:
- "Understand the structure of the type tree."
- "Know how to traverse the type tree."
- "Know how to build abstract, mutable and immutable types."
- "Know how to use type parameters."
keypoints:
- "Types enable the compiler to optimize code."
- "In julia types have only one direct supertype."
- "Types increase security, Type annotations are mainly used for dispatch."
- "Parametric types are useful for flexible yet performant code."
---

## Structuring variables

Melissa wants to keep the variables corresponding to the trebuchet (`counterweight`, `release_angle`) separate from the variables coming from the environment (`wind`, `target_distance`).
That is why she choses to group them together using `struct`s:

~~~
mutable struct Trebuchet
  counterweight::Float64
  release_angle::Float64
end

struct Environment
  wind::Float64
  target_distance::Float64
end
~~~
{: .language-julia}

`struct`s can be either immutable or mutable.
The fields of a mutable `struct` can be altered after an instance of this `struct` was created while this is impossible for an immutable `struct`.

### Types and hierarchy

Here `::Float64` is a type specification, indicating that this variable should be a 64-bit floating point number.
If Melissa hadn't specified the type, the variables would have the type `Any` by default.

In julia every type can have only one supertype, so lets check how many types are between `Float64` and `Any`

~~~
julia> supertype(Float64)
AbstractFloat
julia> supertype(AbstractFloat)
Real
julia> supertype(Real)
Number
julia> supertype(Number)
Any
~~~
{: .language-julia}

So we have the relationship `Float64 <: AbstractFloat <: Real <: Number <: Any`, where `<:` means "subtype of".

`Float64` is a _concrete_ type, which means that you can actually create objects of this type.
For example `1.0` is a object of type `Float64`.
We can check this at the REPL:
~~~
julia> 1.0 isa Float64
true
~~~
{: .language-julia}

All the other types are _abstract_ types that are used to adress groups of types.
For example, if we declare a variable as `a::Real` then it can be bound to any value that is a subtype of `Real`.

Let's quickly check what are all the subtypes of `Real`:
~~~
julia> subtypes(Real)
4-element Array{Any,1}:
 AbstractFloat
 AbstractIrrational
 Integer
 Rational
~~~
{: .language-julia}

## Creating a subtype

A subtype is created with the subtype operator `<:`, since `Trebuchet` contains several fields Melissa thinks it is a good idea to make it a subtype of `AbstractArray`.
~~~
mutable struct Trebuchet <: AbstractArray
  counterweight::Float64
  release_angle::Float64
end
~~~
{: .language-julia}

{% include links.md %}
