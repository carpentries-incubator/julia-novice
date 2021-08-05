---
title: "Julia type system"
teaching: 58
exercises: 2
questions:
- "What is the use of types?"
- "How are types organized in julia?"
objectives:
- "Understand the structure of the type tree."
- "Know how to traverse the type tree."
- "Know how to build mutable and immutable types."
keypoints:
- "In julia types have only one direct supertype."
---

## Structuring variables

Melissa wants to keep the variables corresponding to the trebuchet (`counterweight`, `release_angle`) separate from the variables coming from the environment (`wind`, `target_distance`).
That is why she chooses to group them together using _structures_.
There are two type structures:
 - immutable structures, whose fields can not be changed after creation
   - keyword: `struct`
 - mutable structures, whose fields can change after creation
   - keyword: `mutable struct`

Since Melissa wants to change the parameters of the trebuchet and uses a `mutable struct` for this.
But she cannot influence the environment and thus uses a `struct` for it.
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

All the other types are _abstract_ types that are used to address groups of types.
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

> ## Is it `Real`?
> What do you think `1.0 isa Real`?
> > ## Solution
> > Since `Float64` is a subtype of `Real` `1.0` is also a `Real`.
>{: .solution}
{: .challenge}


## Creating a subtype

A concrete type can be made a subtype of an abstract type  with the subtype operator `<:`.
Since `Trebuchet` contains several fields that are mutable Melissa thinks it is a good idea to make it a subtype of `AbstractVector`.
~~~
mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end
~~~
{: .language-julia}

> ## Caveat: redefining `struct`s
> In julia it is not very easy to redefine `struct`s.
> It is necessary to restart the REPL to define the new definition of `Trebuchet`
> or take a different name.
{: .callout}

{% include links.md %}
