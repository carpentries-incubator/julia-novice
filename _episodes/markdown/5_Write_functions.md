```@meta
EditURL = "https://gitlab.uni-hannover.de/comp-bio/julia-trebuchet/blob/master/5_Write_functions.jl"
```

!!! carp
    ---
    title: "Write functions!"
    teaching: 15
    exercises: 5
    ---

    :::::: questions
    - "How do I call a function?"
    - "Where can I find help about using a function?"
    - "What are methods?"
    ::::::

    :::::: objectives
    - "usage of positional and keyword arguments"
    - "defining named and anonymous functions"
    - "reading error messages"
    ::::::

# <div align="center"> Write functions! </div>

## Working with functions
-----------------

Now that Melissa successfully installed the package she wants to figure out
what she can do with it.

Julia's `Base` module offers a handy function for inspecting other modules
called `names`.
Let's look at its docstring; remember that pressing <kbd>?</kbd>
opens the __help?>__ prompt:

````julia
help?> names
````

````julia
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

!!! mc
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

    !!! solution
        1. Both arguments are present, but `true` is presented without a keyword.
           This throws a `MethodError: no method matching names(::Module, ::Bool)`
        2. This is a __correct__ call.
        3. This is also __correct__: you _can_ specify where the positional arguments
           end with the `;`, but you do not have to.
        4. Two arguments are present, but the keyword `all` is not assigned a
           value. This throws a
          `MethodError: no method matching names(::Module, ::typeof(all))`
        5. This is the __most correct__ answer.

Before starting to work in a new document, Melissa has to:

Activate her environment

````julia
using Pkg
Pkg.activate("projects/trebuchet")
Pkg.instantiate()
````

````
  Activating project at `/builds/comp-bio/julia-trebuchet/output/markdown/projects/trebuchet`

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

````
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

```julia
  shoot(ws, angle, w)
  shoot((ws, angle, w))

  Shoots a Trebuchet with weight w in kg. Releases the weight at the release
  angle angle in radians. The current wind speed is ws in m/s.
  Returns (t, dist), with travel time t in s and travelled distance dist in m.
```

!!! note "Methods"
    Here we see that the `shoot` function has two different _methods_.
    The first one takes three arguments, while the second takes a `Tuple` with
    three elements.

Now she is ready to fire the first shot.

````julia
Trebuchets.shoot(5, 0.25pi, 500)
````

````
(Trebuchet.TrebuchetState(Trebuchet.Lengths{Float64}(1.524, 2.0702016, 0.5334, 0.6096, 2.0826984, 0.8311896, 0.037947600000000005), Trebuchet.Masses{Float64}(226.796185, 0.14877829736, 4.8307587405), Trebuchet.Angles{Float64}(-0.5033953025972442, 1.3226432002827844, 1.4614900249109943), Trebuchet.AnglularVelocities{Float64}(-5.571655186015107, 7.720538762011026, -25.384361188794127), Trebuchet.Constants{Float64}(5.0, 1.0, 1.0, 9.80665, 0.7853981633974482), Trebuchet.Inertias{Float64}(0.042140110093804806, 2.7288719786342384), Val{:End}(), 60.0, Trebuchet.Vec(117.84686747261964, -1.5239999999999878), Trebuchet.Vec(10.790333612654141, -21.453794942312413), Solution(393)
, 0, Val{:Released}()), 117.84686747261964)
````

That is a lot of output, but Melissa is actually only interested in the
distance, which is the second element of the tuple that was returned.
So she tries again and grabs the second element this time:

````julia
Trebuchets.shoot(5, 0.25pi, 500)[2]
````

````
117.84686747261964
````

which means the shot traveled approximately 118 m.

### Defining functions

Melissa wants to make her future work easier and she fears she might forget to
take the second element.
That's why she puts it together in a _function_ like this:

````julia
function shoot_distance(windspeed, angle, weight)
       Trebuchets.shoot(windspeed, angle, weight)[2]
end ;
````

!!! note "Implicit return"
    Note that Melissa didn't have to use the `return` keyword, since in Julia the
    value of the last line will be returned by default.
    But she could have used an explicit return and the function would behave the
    same.

Now Melissa can just call her wrapper function:

````julia
shoot_distance(5, 0.25pi, 500)
````

````
117.84686747261964
````

### Adding methods

Since Melissa wants to work with the structs `Trebuchet` and `Environment`, she
adds another convenience method for those:

````julia
function shoot_distance(trebuchet::Trebuchet, env::Environment)
     shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end ;
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
end ;
````

### Anonymous functions

Sometimes it is useful to have a new function and not have to come up with a
new name.
These are _anonymous functions_.
They can be defined with either the so-called stabby lambda notation,

````julia
(windspeed, angle, weight) -> Trebuchets.shoot(windspeed, angle, weight)[2] ;
````

or in long form, by omitting the name:

````julia
function (windspeed, angle, weight)
      Trebuchets.shoot(windspeed, angle, weight)[2]
end ;
````

### Errors and macros

Melissa would like to set the fields of a `Trebuchet` using an index.
She writes

```julia
Trebuchets[1] = 2
```

```julia
ERROR: MethodError: no method matching setindex!(::Trebuchet, ::Int64, ::Int64)
Stacktrace:
 [1] top-level scope
   @ REPL[4]:1
```

The error tells her two things:

1. a function named `setindex!` was called
2. it didn't have a method for `Trebuchet`

Melissa wants to add the missing method to `setindex!` but she doesn't know
where it is defined.
There is a handy _macro_ named `@which` that obtains the module where the
function is defined.

!!! note "Macros"
    Macro names begin with `@` and they don't need parentheses or commas to
    delimit their arguments.
    Macros can transform any valid Julia expression and are quite powerful.
    They can be expanded by prepending `@macroexpand` to the macro call of
    interest.

```julia
@which setindex!
```

```julia
Base
```

Now Melissa knows she needs to add a method to `Base.setindex!` with the
signature `(::Trebuchet, ::Int64, ::Int64)`.

!!! carp
    :::::: keypoints
    - "You can think of functions being a collection of methods"
    - "Keep the number of positional arguments low"
    - "Macros transform Julia expressions"
    ::::::

