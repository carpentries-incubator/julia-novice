---
title: "Write functions!"
teaching: 35
exercises: 5
questions:
- "How do I call a function?"
- "Where can I find help about using a function?"
- "What are methods?"
objectives:
- "usage of positional and keyword arguments"
- "defining named and anonymous functions"
- "reading error messages"
keypoints:
- "You can think of functions being a collection of methods"
- "Keep the number of positional arguments low"
- "Macros transform julia expressions"
---

## Working with functions

Now that Melissa successfully installed the package she wants to figure out what she can do with it.

Julias `Base` module offers a handy function for inspecting other modules called `names`.
Let's look at its docstring:
~~~
help?> names

    names(x::Module; all::Bool = false, imported::Bool = false)

    Get an array of the names exported by a Module, excluding deprecated names. If all is true, then the list also includes non-exported names defined in the module, deprecated names, and compiler-generated names. If imported
    is true, then names explicitly imported from other modules are also included.

    As a special case, all names defined in Main are considered "exported", since it is not idiomatic to explicitly export names from Main.
~~~
{: .language-julia}
> ## Positional and keyword arguments
> Let's take a closer look at the signature of the `names` function.
> In julia we have two types of arguments:
> 1. _Positional arguments_ are determined by their position and thus the order in which arguments are given to the function matters.
>  The `names` function has one positional argument `x` of type `Module`.
> 2. _Keyword arguments_ are passed as a combination of the keyword and the value to the function.
> They can be given in any order, but they need to have a default value.
> The `names` function has two keyword arguments `all` and `imported` which are both of type `Bool` and default to `false`.
> Positional and keyword arguments are separated by a semi-colon.
>
{: .callout}

> ## Calling with keyword arguments
> Suppose Melissa wanted to get `all` names of the `Trebuchets` module, what would the call look like?
> >## Solution
> >`names(Trebuchets, all = true)`
> {: .solution}
{: .challenge}


Thus Melissa executes
~~~
julia> names(Trebuchets)
6-element Vector{Symbol}:
 :Trebuchet
 :TrebuchetState
 :run
 :shoot
 :simulate
 :visualise
~~~
{: .language-julia}

which yields the exported names of the `Trebuchets` module.
By convention types are named with _CamelCase_ while functions typically have _snake_case_.
Since Melissa is interested in simulating shots, she looks at the `Trebuchets.shoot` function
~~~
help?> Trebuchets.shoot

  shoot(ws, angle, w)
  shoot((ws, angle, w))

  Shoots a Trebuchet with weight w. Releases the weight at the release angle angle in radians. The current wind speed is ws. Returns (t, dist), with travel time t and traveled distance dist.
~~~
{: .language-julia}
> ## Methods
> Here we see, that the `shoot` function has two different _methods_.
> The first one takes three arguments, while the second takes a `Tuple` with three elements.
{: .callout}

Now she is ready to fire the first shot
~~~
julia> Trebuchets.shoot(5, 0.25pi, 500)
(TrebuchetState(Trebuchet.Lengths{Float64}(1.524, 2.0702016, 0.5334, 0.6096, 2.0826984, 0.8311896, 0.037947600000000005), Trebuchet.Masses{Float64}(226.796185, 0.14877829736, 4.8307587405), Trebuchet.Angles{Float64}(-0.5033953025972455, 1.322643200282786, 1.4614900249109948), Trebuchet.AnglularVelocities{Float64}(-5.571655186015145, 7.720538762011071, -25.384361188794127), Trebuchet.Constants{Float64}(5.0, 1.0, 1.0, 9.80665, 0.7853981633974482), Trebuchet.Inertias{Float64}(0.042140110093804806, 2.7288719786342384), Val{:End}(), 60.0, Trebuchet.Vec(117.8468674726198, -1.5239999999999974), Trebuchet.Vec(10.790333612654146, -21.45379494231241), Solution(394)
, 0, Val{:Released}()), 117.8468674726198)
~~~
{: .language-julia}

That is a lot of output, but Melissa is actually only interested in the distance, which is the second element of the tuple that was returned.
So she tries again and grabs the second element this time
~~~
julia> Trebuchets.shoot(5, 0.25pi, 500)[2]
117.8468674726198
~~~
{: .language-julia}

which means the shot traveled approximately 118m.

### Defining functions

Melissa wants to make her future work easier and she fears she might forget to take the second element.
That's why she puts it together in a _function_ like this:
~~~
julia> function shoot_distance(windspeed, angle, weight)
           Trebuchets.shoot(windspeed, angle, weight)[2]
       end
~~~
{: .language-julia}

> ## Implicit return
> Note that Melissa didn't have to use the `return` keyword, since in julia the value of the last line will be returned by default.
> But she could have used an explicit return and the function would behave the same.
{: .callout}

### Adding methods

Since Melissa wants to work with the structs `Trebuchet` and `Environment` she adds another convenience method for those
~~~
julia> function shoot_distance(trebuchet::Trebuchet, env::Environment)
           shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
       end
~~~
{: .language-julia}

This method will call the former method and pass the correct fields from the `Trebuchet` and `Environment` structures.

### Slurping and splatting

By peeking into the [documentation](https://docs.julialang.org/en/v1/manual/faq/#The-two-uses-of-the-...-operator:-slurping-and-splatting) Melissa discovers that she doesn't need to explicitly declare all the input arguments.
Instead she can _slurp_ the arguments in the function definition and _splat_ them in the function body using three dots (`...`) like this
~~~
julia> function shoot_distance(args...) # slurping
           Trebuchets.shoot(args...)[2] # splatting
       end
~~~
{: .language-julia}


### Anonymous functions

Sometimes it is useful to have a new function and not having to come up with a new name.
These are _anonymous functions_.
They can be defined by either with the so called stabby lambda notation

~~~
julia> (windspeed, angle, weight) -> Trebuchets.shoot(windspeed, angle, weight)[2]
~~~
{: .language-julia}

or in the long form, by omitting the name:

~~~
julia> function (windspeed, angle, weight)
           Trebuchets.shoot(windspeed, angle, weight)[2]
       end
~~~
{: .language-julia}

### Errors and macros

Melissa would like to set the fields of a `Trebuchet` using an index.
She writes
~~~
julia> trebuchet[1] = 2
ERROR: MethodError: no method matching setindex!(::Trebuchet{Int64}, ::Int64, ::Int64)
Stacktrace:
 [1] top-level scope
   @ REPL[4]:1
~~~
{: .language-julia}

which tells her two things:

1. a function named `setindex!` was called
2. it didn't have a method for `Trebuchet`s

Melissa wants to add the missing method to `setindex!` but she doesn't know where it is defined.
There is a handy _macro_ named `@which` which can be used to obtain the module where the function is defined.
~~~
julia> @which setindex!
Base
~~~
{: .language-julia}

> ## Macros
> Macro names begin with `@` and they don't need parentheses or commas to delimit their arguments.
> Macros can transform any valid julia expression and are quite powerful.
> They can be expanded using `@macroexpand`.
{: .callout}

Now Melissa knows she needs to add a method to `Base.setindex!` with the signature `(::Trebuchet{Int64}, ::Int64, ::Int64)`.

{% include links.md %}
