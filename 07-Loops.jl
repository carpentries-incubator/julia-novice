# !!! yaml
#     ---
#     title: "Loops"
#     teaching: 30
#     exercises: 30
#     ---
#
# !!! questions
#       - "What are for and while loops?"
#
# !!! objectives
#

# Now Melissa knows how to shoot the virtual trebuchet and get the distance of
# the projectile, but in order to aim she needs to take a lot of trial shots in a
# row.
# She wants her trebuchet to only shoot a hundred meters.

# She could execute the function several times on the REPL with different
# parameters, but that gets tiresome quickly.
# A better way to do this is to use loops.

# But first Melissa needs a way to improve her parameters.

# !!! note "Digression: Gradients"
#     The `shoot_distance` function takes three input parameters and returns one
#     value (the distance).
#     Whenever we change one of the input parameters, we will get a different
#     distance.
#
#     The [_gradient_](https://en.wikipedia.org/wiki/Gradient) of a function gives the direction in which the return
#     value will change when each input value changes.
#
#     Since the `shoot_distance` function has three input parameters, the gradient
#     of `shoot_distance` will return a 3-element `Array`:
#     one direction for each input parameter.
#
#     Thanks to [automatic differentiation](https://en.wikipedia.org/wiki/Automatic_differentiation) and the Julia package
#     `ForwardDiff.jl` gradients can be calculated easily.


# Melissa uses the `gradient` function of `ForwardDiff.jl` to get the direction
# in which she needs to change the parameters to make the largest difference.

# !!! sc "Do you remember?"
#
#     What does Melissa need to write into the REPL to install the package
#     `ForwardDiff`?
#
#     1. `] install ForwardDiff`
#     2. `add ForwardDiff`
#     3. `] add ForwardDiff.jl`
#     4. `] add ForwardDiff` <!---correct-->
#
#     !!! solution
#         The correct solution is 4:
#         <kbd>]</kbd> to enter pkg mode, then
#
#         ````julia
#         pkg> add ForwardDiff
#         ````

using ForwardDiff: gradient


imprecise_trebuchet = Trebuchet(500.0, 0.25pi);
environment = Environment(5.0, 100.0);

grad = gradient(x ->(shoot_distance([environment.wind, x[2], x[1]])
                      - environment.target_distance),
                imprecise_trebuchet)


# Melissa now changes her arguments a little bit in the direction of the gradient
# and checks the new distance.


better_trebuchet = imprecise_trebuchet - 0.05 * grad;

shoot_distance([5, better_trebuchet[2], better_trebuchet[1]])

# Great! That didn't shoot past the target, but instead it landed a bit too short.

# !!! challenge "Experiment"
#     How far can you change the parameters in the direction of the gradient, such
#     that it still improves the distance?
#
#     !!! solution "Try a bunch of values!"
#         ````julia
#         better_trebuchet = imprecise_trebuchet - 0.04 * grad
#         shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
#         120.48753521261001
#         ````
#
#         ````julia
#         better_trebuchet = imprecise_trebuchet - 0.03 * grad
#         shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
#         107.80646596787481
#         ````
#
#         ````julia
#         better_trebuchet = imprecise_trebuchet - 0.02 * grad
#         shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
#         33.90699307740854
#         ````
#
#         ````julia
#         better_trebuchet = imprecise_trebuchet - 0.025 * grad
#         shoot_distance([environment.wind, better_trebuchet[2], better_trebuchet[1]])
#         75.87613276409223
#         ````
#
#         Looks like the "best" trebuchet for a target 100 m away will be between
#         2.5% and 3% down the gradient from the imprecise trebuchet.

# ### For loops

# Now that Melissa knows it is going in the right direction she wants to automate
# the additional iterations.
# She writes a new function `aim`, that performs the application of the gradient
# `N` times.

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

# !!! challenge "Explore"
#     Play around with different inputs of `N` and `η`.
#     How close can you come?
#
#     !!! solution
#         This is a highly non-linear system and thus very sensitive.
#         The distances across different values for the counterweight and the release
#         angle α look like this:
#         ![](fig/shoot_surface.png){width="600" height="400" alt=""}

# !!! tip "Aborting programs"
#     If a call takes too long, you can abort it with `Ctrl-c`

# ### While loops

# Melissa finds the output of the above `aim` function too unpredictable to be
# useful.
# That's why she decides to change it a bit.
# This time she uses a `while`-loop to run the iterations until she is
# sufficiently near her target.

# (_Hint:_ __ε__ is `\epsilon`<kbd>tab</kbd>, and __η__ is `\eta`<kbd>tab</kbd>.)

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


# That is more what she had in mind. Your trebuchet may be tuned differently,
# but it should hit just as close as hers.
# !!! keypoints
#     - "Use for loops for a known number of iterations and while loops for an unknown number of iterations."
