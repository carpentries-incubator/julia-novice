---
title: "Write functions!"
teaching: 15
exercises: 5
---

:::::: questions

## Questions

  - "How do I call a function?"
  - "Where can I find help about using a function?"
  - "What are methods?"

::::::

:::::: objectives

## Objectives

  - "usage of positional and keyword arguments"
  - "defining named and anonymous functions"
  - "reading error messages"

::::::

## Working with functions

Now that Melissa successfully installed the package she wants to figure out
what she can do with it.

Julia's `Base` module offers a handy function for inspecting other modules
called `names`.
Let's look at its docstring; remember that pressing <kbd>?</kbd>
opens the __help?>__ prompt:

````julia
help?> names
````

````output
   names(x::Module; all::Bool = false, imported::Bool = false)

    Get an array of the names exported by a Module, excluding deprecated names.
    If all is true, then the list also includes non-exported names defined in
    the module, deprecated names, and compiler-generated names. If imported is
    true, then names explicitly imported from other modules are also included.

    As a special case, all names defined in Main are considered "exported",
    since it is not idiomatic to explicitly export names from Main.
````

In Julia we have two types of arguments: _positional_ and _keyword_, separated
by a semi-colon.

1. _Positional arguments_ are determined by their position and thus the order
   in which arguments are given to the function matters.
2. _Keyword arguments_ are passed as a combination of the keyword and the
   value to the function. They can be given in any order, but they need to
   have a default value.

:::::: challenge

## Challenge

Let's take a closer look at the signature of the `names` function:

```julia
names(x::Module; all::Bool = false, imported::Bool = false)
```

It takes three arguments:

 1. `x`, a positional argument of type `Module`,
    followed by a __`;`__ <!-- note: trailing spaces are deliberate-->
 2. `all`, a keyword argument of type `Bool` with a default value of
    `false`
 3. `imported`, another `Bool` keyword argument that defaults
    to `false`

Suppose Melissa wanted to get all names of the `Trebuchets` module, including
those that are not exported. What would the function call look like?

 1. `names(Trebuchets, true)`
 2. `names(Trebuchets, all = true)` <!---correct-->
 3. `names(Trebuchets, all)`
 4. `names(Trebuchets; all = true)` <!---correct-->
 5. Answer 2 and 4 <!---correct-->

:::::: solution

## Solution

 1. Both arguments are present, but `true` is presented without a keyword.
    This throws a `MethodError: no method matching names(::Module, ::Bool)`
 2. This is a __correct__ call.
 3. Two arguments are present, but the keyword `all` is not assigned a
    value. This throws a
    `MethodError: no method matching names(::Module, ::typeof(all))`
 4. This is also __correct__: you _can_ specify where the positional arguments
    end with the `;`, but you do not have to.
 5. This is the __most correct__ answer.

::::::


::::::

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
````

Now she can execute

````julia
names(Trebuchets)
````

````output
6-element Vector{Symbol}:
 :Trebuchet
 :TrebuchetState
 :run
 :shoot
 :simulate
 :visualise
````

which yields the exported names of the `Trebuchets` module.
By convention types are named with _CamelCase_ while functions typically have
*snake_case*.
Since Melissa is interested in simulating shots, she looks at the
`shoot` function from `Trebuchets` (again, using <kbd>?</kbd>):

```julia
help?> Trebuchets.shoot
```

```output
  shoot(ws, angle, w)
  shoot((ws, angle, w))

  Shoots a Trebuchet with weight w in kg. Releases the weight at the release
  angle angle in radians. The current wind speed is ws in m/s.
  Returns (t, dist), with travel time t in s and travelled distance dist in m.
```

:::::: callout

## Generic functions and methods

In the output we see that `shoot` has two different argument signatures: one with
three arguments and one with a `Tuple` of three elements as its single
argument. These two signatures correspond to two different implementations.
In our case one is calling the other.

Functions of the same name with different argument signatures are called
*methods* of a *generic function* of that name. In our example we have
two methods of the `shoot` generic function.

Almost all function in Julia are generic functions and in particular all user defined functions. An example with
particularly many methods is `+`. You can list its methods by executing
`methods(+)`, for example.

Julia determines which method to apply to a tuple of arguments according
to set of rules, which are documented in the [Julia Manual’s Methods
section](https://docs.julialang.org/en/v1/manual/methods/).

::::::

Now she is ready to fire the first shot.

````julia
Trebuchets.shoot(5, 0.25pi, 500)
````

````output
(Trebuchet.TrebuchetState(Trebuchet.Lengths{Float64}(1.524, 2.0702016, 0.5334, 0.6096, 2.0826984, 0.8311896, 0.037947600000000005), Trebuchet.Masses{Float64}(226.796185, 0.14877829736, 4.8307587405), Trebuchet.Angles{Float64}(-0.4328124904398228, 1.1928977546511481, 1.437218009822302), Trebuchet.AnglularVelocities{Float64}(-6.80709816163242, 10.240657933288563, -22.420510883318446), Trebuchet.Constants{Float64}(5.0, 1.0, 1.0, 9.80665, 0.7853981633974482), Trebuchet.Inertias{Float64}(0.042140110093804806, 2.7288719786342384), Val{:End}(), 60.0, Trebuchet.Vec(114.88494815382731, -1.5239999999999991), Trebuchet.Vec(10.886295450427806, -21.290442812748466), Solution(387)
, 3.943408301947865, Val{:Released}()), 114.88494815382731)
````

That is a lot of output, but Melissa is actually only interested in the
distance, which is the second element of the tuple that was returned.
So she tries again and grabs the second element this time:

````julia
Trebuchets.shoot(5, 0.25pi, 500)[2]
````

````output
114.88494815382731
````

which means the shot traveled approximately 118 m.

### Defining functions

Melissa wants to make her future work easier and she fears she might forget to
take the second element.
That's why she puts it together in a _function_ like this:

````julia
function shoot_distance(windspeed, angle, weight)
       Trebuchets.shoot(windspeed, angle, weight)[2]
end
````

````output
shoot_distance (generic function with 1 method)
````

:::::: callout

## Implicit return

Note that Melissa didn't have to use the `return` keyword, since in Julia the
value of the last line will be returned by default.
But she could have used an explicit return and the function would behave the
same.

::::::

Now Melissa can just call her wrapper function:

````julia
shoot_distance(5, 0.25pi, 500)
````

````output
114.88494815382731
````

### Adding methods

Since Melissa wants to work with the structs `Trebuchet` and `Environment`, she
adds another convenience method for those:

````julia
function shoot_distance(trebuchet::Trebuchet, env::Environment)
     shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end
````

````output
shoot_distance (generic function with 2 methods)
````

This method will call the former method and pass the correct fields from the
`Trebuchet` and `Environment` structures.

### Slurping and splatting

By peeking into the [documentation](https://docs.julialang.org/en/v1/manual/faq/#The-two-uses-of-the-...-operator:-slurping-and-splatting), Melissa discovers that she
doesn't need to explicitly declare all the input arguments.
Instead she can _slurp_ the arguments in the function definition and _splat_
them in the function body using three dots (`...`) like this:

````julia
function shoot_distance(args...) # slurping
     Trebuchets.shoot(args...)[2] # splatting
end
````

````output
shoot_distance (generic function with 3 methods)
````

### Anonymous functions

Sometimes it is useful to have a new function and not have to come up with a
new name.
These are _anonymous functions_.
They can be defined with either the so-called stabby lambda notation,

````julia
(windspeed, angle, weight) -> Trebuchets.shoot(windspeed, angle, weight)[2]
````

````output
#1 (generic function with 1 method)
````

or in long form, by omitting the name:

````julia
function (windspeed, angle, weight)
      Trebuchets.shoot(windspeed, angle, weight)[2]
end
````

````output
#3 (generic function with 1 method)
````

### Calling methods

Now, that she defined all these methods she tests calling a few

````julia
shoot_distance(5, 0.25pi, 500)
````

````output
114.88494815382731
````

````julia
shoot_distance([5, 0.25pi, 500])
````

````output
114.88494815382731
````

For the other method she needs to construct `Trebuchet` and `Environment` objects first

````julia
env = Environment(5, 100)
````

````output
Environment(5.0, 100.0)
````

````julia
trebuchet = Trebuchet(500, 0.25pi)
````

````error
MethodError: no method matching size(::Trebuchet)

Closest candidates are:
  size(::AbstractArray{T, N}, !Matched::Any) where {T, N}
   @ Base abstractarray.jl:42
  size(!Matched::Union{LinearAlgebra.QR, LinearAlgebra.QRCompactWY, LinearAlgebra.QRPivoted})
   @ LinearAlgebra /opt/hostedtoolcache/julia/1.9.4/x64/share/julia/stdlib/v1.9/LinearAlgebra/src/qr.jl:582
  size(!Matched::Union{LinearAlgebra.QR, LinearAlgebra.QRCompactWY, LinearAlgebra.QRPivoted}, !Matched::Integer)
   @ LinearAlgebra /opt/hostedtoolcache/julia/1.9.4/x64/share/julia/stdlib/v1.9/LinearAlgebra/src/qr.jl:581
  ...

````

### Errors and finding documentation

This error tells her two things:

1. a function named `size` was called
2. it didn't have a method for `Trebuchet`

Melissa wants to add the missing method to `size` but she doesn't know
where it is defined.
There is a handy _macro_ named `@which` that obtains the module where the
function is defined.

:::::: callout

## Macros

Macro names begin with `@` and they don't need parentheses or commas to
delimit their arguments.
Macros can transform any valid Julia expression and are quite powerful.
They can be expanded by prepending `@macroexpand` to the macro call of
interest.

::::::

````julia

@which size
````

````output
Base
````

Now Melissa knows she needs to add a method to `Base.size` with the
signature `(::Trebuchet)`.

She can also lookup the docstring using the `@doc` macro

````julia
@doc size
````

````output
  size(A::AbstractArray, [dim])

  Return a tuple containing the dimensions of A. Optionally you can specify a
  dimension to just get the length of that dimension.

  Note that size may not be defined for arrays with non-standard indices, in
  which case axes may be useful. See the manual chapter on arrays with custom
  indices.

  See also: length, ndims, eachindex, sizeof.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> A = fill(1, (2,3,4));
  
  julia> size(A)
  (2, 3, 4)
  
  julia> size(A, 2)
  3

  size(cb::CircularBuffer)

  Return a tuple with the size of the buffer.

  size(g, i)

  Return the number of vertices in g if i=1 or i=2, or 1 otherwise.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> using Graphs
  
  julia> g = cycle_graph(4);
  
  julia> size(g, 1)
  4
  
  julia> size(g, 2)
  4
  
  julia> size(g, 3)
  1
````

With that information she can now implement this method:

````julia
function Base.size(::Trebuchet)
     return tuple(2)
end
````

But that is a 3 lines of text for a very short definition.
Melissa can also using the short form notation to fit this in a single line:

````julia
Base.size(::Trebuchet) = tuple(2)
````

!!! callout Omitting unneeded arguments
Melissa could also name the argument in the signature.
Like this: `(trebuchet::Trebuchet)`, but since the argument is not needed to compute
the output of the function she can omit it.
The argument is in this case only used to dispatch to the correct method.
Now she can try again

````julia
trebuchet = Trebuchet(500, 0.25pi)
````

````error
CanonicalIndexError: getindex not defined for Trebuchet
````

Again, there is an error but this time the error message is different:
It's no longer a method for `size` that is missing but for `getindex`.
She looks up the documentation for that function

````julia
@doc getindex
````

````output
  getindex(type[, elements...])

  Construct a 1-d array of the specified type. This is usually called with the
  syntax Type[]. Element values can be specified using Type[a,b,c,...].

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> Int8[1, 2, 3]
  3-element Vector{Int8}:
   1
   2
   3
  
  julia> getindex(Int8, 1, 2, 3)
  3-element Vector{Int8}:
   1
   2
   3

  getindex(collection, key...)

  Retrieve the value(s) stored at the given key or index within a collection.
  The syntax a[i,j,...] is converted by the compiler to getindex(a, i, j,
  ...).

  See also get, keys, eachindex.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> A = Dict("a" => 1, "b" => 2)
  Dict{String, Int64} with 2 entries:
    "b" => 2
    "a" => 1
  
  julia> getindex(A, "a")
  1

  getindex(A, inds...)

  Return a subset of array A as specified by inds, where each ind may be, for
  example, an Int, an AbstractRange, or a Vector. See the manual section on
  array indexing for details.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> A = [1 2; 3 4]
  2×2 Matrix{Int64}:
   1  2
   3  4
  
  julia> getindex(A, 1)
  1
  
  julia> getindex(A, [2, 1])
  2-element Vector{Int64}:
   3
   1
  
  julia> getindex(A, 2:4)
  3-element Vector{Int64}:
   3
   2
   4

  getindex(tree::GitTree, target::AbstractString) -> GitObject

  Look up target path in the tree, returning a GitObject (a GitBlob in the
  case of a file, or another GitTree if looking up a directory).

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  tree = LibGit2.GitTree(repo, "HEAD^{tree}")
  readme = tree["README.md"]
  subtree = tree["test"]
  runtests = subtree["runtests.jl"]

  observable[]

  Returns the current value of observable.

  getindex(A::ArrayPartition, i::Colon, j...)

  Returns the entry at index j... of every partition of A.

  getindex(A::ArrayPartition, ::Colon)

  Returns a vector with all elements of array partition A.

  v = sd[k]

  Argument sd is a SortedDict and k is a key. In an expression, this retrieves
  the value (v) associated with the key (or KeyError if none). On the
  left-hand side of an assignment, this assigns or reassigns the value
  associated with the key. (For assigning and reassigning, see also insert!
  below.) Time: O(c log n)

  cb[i]

  Get the i-th element of CircularBuffer.

    •  cb[1] to get the element at the front

    •  cb[end] to get the element at the back

  getindex(tree, ind)

  Gets the key present at index ind of the tree. Indexing is done in
  increasing order of key.

  g[iter]

  Return the subgraph induced by iter. Equivalent to induced_subgraph(g,
  iter)[1].
````

Note that the documentation for all methods gets shown and Melissa needs to look for the relevant method first.
In this case its the paragraph starting with

````
getindex(A, inds...)
````

After a bit of pondering the figures it should be enough to add a method for `getindex` with a single number.

````
getindex(trebuchet::Trebuchet, i::Int)
````

:::::: callout

## Syntactic sugar

In Julia `a[1]` is equivalent to `getindex(a, 1)`
and `a[2] = 3` to `setindex!(a, 3, 2)`
Likewise `a.b` is equivalent to `getproperty(a, :b)`
and `a.b = 4` to `setproperty!(a, :b, 4)`.

::::::

:::::: keypoints

## Keypoints

  - "You can think of functions being a collection of methods"
  - "Methods are defined by their signature"
  - "The signature is defined by the number of arguments, their order and their type"
  - "Keep the number of positional arguments low"
  - "Macros transform Julia expressions"

::::::

