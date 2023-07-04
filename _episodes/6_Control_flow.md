```@meta
EditURL = "https://gitlab.uni-hannover.de/comp-bio/julia-trebuchet/blob/master/6_Control_flow.jl"
```

!!! carp
    ---
    title: "Control flow"
    teaching: 60
    exercises: 60
    ---

    :::::: questions:
    - "What are for and while loops?"
    - "How to use conditionals?"
    - "What is an interface?"
    ::::::

    :::::: objectives:
    ::::::

# <div align="center"> Control flow </div>

## Conditionals
-----------------

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

Now that Melissa knows which method to add she thinks about the implementation.

If the index is `1` she wants to set `counterweight` while if the index is `2`
she wants to set `release_angle` and since these are the only two fields she
wants to return an error if anything else comes in.
In Julia the keywords to specify conditions are `if`, `elseif` and `else`,
closed with an `end`.
Thus she writes

````julia
function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
    if i === 1
        trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end
````

### Interfaces

`setindex!` is actually one function of a widespread _interface_ in the Julia
language: `AbstractArray`s.
An interface is a collection of methods that are all implemented by a certain
type.
For example, the [Julia manual](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array) lists all methods that a subtype of
`AbstractArray` need to implement to adhere to the `AbstractArray` interface:

- `size(A)` returns a tuple containing the dimensions of `A`
- `getindex(A, i::Int)` returns the value associated with index `i`
- `setindex!(A, v, i::Int)` writes a new value `v` at the index `i`

If Melissa implements this interface for the `Trebuchet` type, it will work
with every function in `Base` that accepts an `AbstractArray`.

She also needs to make `Trebuchet` a proper subtype of `AbstractArray` as she
tried in [the types episode](3_Julia_type_system.md).
Therefore she _restarts her REPL_ and redefines `Trebuchet` and `Environment`,
as well as the slurp-and-splat `shoot_distance` function:

````julia
using Pkg
Pkg.activate("projects/trebuchet")

import Trebuchet as Trebuchets

mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end

struct Environment
    wind::Float64
    target_distance::Float64
end

function shoot_distance(args...)
    Trebuchets.shoot(args...)[2]
end

function shoot_distance(trebuchet::Trebuchet, env::Environment)
     shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end
````

````
shoot_distance (generic function with 2 methods)
````

Then she goes about implementing the `AbstractArray` interface.

!!! freecode
    Implement the `AbstractArray` interface for `Trebuchet`

    Now we know enough to actually implement the `AbstractArray` interface.
    You don't need to implement the optional methods.

    Hint: Take a look at the docstrings of `getfield` and `tuple`.

    !!! solution

        ```julia
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
        ```


With the new `Trebuchet` defined with a complete `AbstractArray` interface,
Melissa tries again to modify a counterweight by index:

````julia
trebuchet = Trebuchet(500, 0.25pi)
````

````
2-element Main.##292.Trebuchet:
 500.0
   0.7853981633974483
````

````julia
trebuchet[1] = 2
````

````
2
````

````julia
trebuchet
````

````
2-element Main.##292.Trebuchet:
 2.0
 0.7853981633974483
````

## Loops
-----------------

Now Melissa knows how to shoot the virtual trebuchet and get the distance of
the projectile, but in order to aim she needs to take a lot of trial shots in a
row.
She wants her trebuchet to only shoot a hundred meters.

She could execute the function several times on the REPL with different
parameters, but that gets tiresome quickly.
A better way to do this is to use loops.

But first Melissa needs a way to improve her parameters.

!!! note "Digression: Gradients"
    The `shoot_distance` function takes three input parameters and returns one
    value (the distance).
    Whenever we change one of the input parameters, we will get a different
    distance.

    The [_gradient_](https://en.wikipedia.org/wiki/Gradient) of a function gives the direction in which the return
    value will change when each input value changes.

    Since the `shoot_distance` function has three input parameters, the gradient
    of `shoot_distance` will return a 3-element `Array`:
    one direction for each input parameter.

    Thanks to [automatic differentiation](https://en.wikipedia.org/wiki/Automatic_differentiation) and the Julia package
    `ForwardDiff.jl` gradients can be calculated easily.

Melissa uses the `gradient` function of `ForwardDiff.jl` to get the direction
in which she needs to change the parameters to make the largest difference.

!!! sc
    Do you remember?

    What does Melissa need to write into the REPL to install the package
    `ForwardDiff`?

    1. `] install ForwardDiff`
    2. `add ForwardDiff`
    3. `] add ForwardDiff.jl`
    4. `] add ForwardDiff` <!---correct-->

    !!! solution
        The correct solution is 4:
        <kbd>]</kbd> to enter pkg mode, then

        ````julia
        pkg> add ForwardDiff
        ````

````julia
using ForwardDiff: gradient


imprecise_trebuchet = Trebuchet(500.0, 0.25pi);
environment = Environment(5.0, 100.0);

grad = gradient(x ->(shoot_distance([environment.wind, x[2], x[1]])
                      - environment.target_distance),
                imprecise_trebuchet)
````

````
2-element Vector{Float64}:
  -0.022101014146393254
 -47.19173788019795
````

Melissa now changes her arguments a little bit in the direction of the gradient
and checks the new distance.

````julia
better_trebuchet = imprecise_trebuchet - 0.05 * grad;

shoot_distance([5, better_trebuchet[2], better_trebuchet[1]])
````

````
58.871526222895426
````

Great! That didn't shoot past the target, but instead it landed a bit too short.

!!! note "Experiment"
    How far can you change the parameters in the direction of the gradient, such
    that it still improves the distance?

    !!! solution "Try a bunch of values!"
        ````julia
        better_trebuchet = imprecise_trebuchet - 0.04 * grad
        shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
        120.48753521261001
        ````

        ````julia
        better_trebuchet = imprecise_trebuchet - 0.03 * grad
        shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
        107.80646596787481
        ````

        ````julia
        better_trebuchet = imprecise_trebuchet - 0.02 * grad
        shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
        33.90699307740854
        ````

        ````julia
        better_trebuchet = imprecise_trebuchet - 0.025 * grad
        shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
        75.87613276409223
        ````

        Looks like the "best" trebuchet for a target 100 m away will be between
        2.5% and 3% down the gradient from the imprecise trebuchet.

### For loops

Now that Melissa knows it is going in the right direction she wants to automate
the additional iterations.
She writes a new function `aim`, that performs the application of the gradient
`N` times.

````julia
function aim(trebuchet, environment; N = 5, η = 0.05)
           better_trebuchet = copy(trebuchet)
           for _ in 1:N
               grad = gradient(x -> (shoot_distance([environment.wind, x[2], x[1]])
                                     - environment.target_distance),
                               better_trebuchet)
               better_trebuchet -= η * grad
           end
           return Trebuchet(better_trebuchet[1], better_trebuchet[2])
       end

better_trebuchet  = aim(imprecise_trebuchet, environment);

shoot_distance(environment.wind, better_trebuchet[2], better_trebuchet[1])
````

````
104.99997122509406
````

!!! note "Explore"
    Play around with different inputs of `N` and `η`.
    How close can you come?

    !!! solution
        This is a highly non-linear system and thus very sensitive.
        The distances across different values for the counterweight and the release
        angle α look like this:
        <img src="https://raw.githubusercontent.com/carpentries-incubator/julia-novice/f5431d8b6645a7083755879cf28c862e9e4115e9/fig/shoot_surface.png" width="600" height="400">

!!! tip "Aborting programs"
    If a call takes too long, you can abort it with `Ctrl-c`

### While loops

Melissa finds the output of the above `aim` function too unpredictable to be
useful.
That's why she decides to change it a bit.
This time she uses a `while`-loop to run the iterations until she is
sufficiently near her target.

(_Hint:_ __ε__ is `\epsilon`<kbd>tab</kbd>, and __η__ is `\eta`<kbd>tab</kbd>.)

````julia
function aim(trebuchet, environment; ε = 0.1, η = 0.05)
    better_trebuchet = copy(trebuchet)
    hit = x -> (shoot_distance([environment.wind, x[2], x[1]])
                          - environment.target_distance)
            while abs(hit(better_trebuchet)) > ε
                grad = gradient(hit, better_trebuchet)
                better_trebuchet -= η * grad
            end
            return Trebuchet(better_trebuchet[1], better_trebuchet[2])
        end

better_trebuchet = aim(imprecise_trebuchet, environment);

shoot_distance(better_trebuchet, environment)
````

````
100.00434124725943
````

That is more what she had in mind. Your trebuchet may be tuned differently,
but it should hit just as close as hers.

!!! carp
    :::::: keypoints
    - "Interfaces are informal"
    - "Use for loops for a known number of iterations and while loops for an unknown number of iterations."
    - "Julia packages compose nicely."
    ::::::

