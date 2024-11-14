# !!! yaml
#     ---
#     title: "Write functions!"
#     teaching: 15
#     exercises: 5
#     ---
#
# !!! questions
#     - "How do I call a function?"
#     - "Where can I find help about using a function?"
#     - "What are methods?"
#
# !!! objectives
#     - "usage of positional and keyword arguments"
#     - "defining named and anonymous functions"
#     - "reading error messages"

# ## Working with functions

# Now that Melissa successfully installed the package she wants to figure out
# what she can do with it.

# Julia's `Base` module offers a handy function for inspecting other modules
# called `names`.
# Let's look at its docstring; remember that pressing <kbd>?</kbd>
# opens the __help?>__ prompt:

#md # ````julia-repl
#md # help?> names
#md # ````

#md # ````output
#md #    names(x::Module; all::Bool = false, imported::Bool = false)
#md #
#md #     Get an array of the names exported by a Module, excluding deprecated names.
#md #     If all is true, then the list also includes non-exported names defined in
#md #     the module, deprecated names, and compiler-generated names. If imported is
#md #     true, then names explicitly imported from other modules are also included.
#md #
#md #     As a special case, all names defined in Main are considered "exported",
#md #     since it is not idiomatic to explicitly export names from Main.
#md # ````

#nb ?names

# In Julia we have two types of arguments: _positional_ and _keyword_, separated
# by a semi-colon.

# 1. _Positional arguments_ are determined by their position and thus the order
#    in which arguments are given to the function matters.
# 2. _Keyword arguments_ are passed as a combination of the keyword and the
#    value to the function. They can be given in any order, but they need to
#    have a default value.

# !!! mc
#     Let's take a closer look at the signature of the `names` function:
#
#     ```julia
#     names(x::Module; all::Bool = false, imported::Bool = false)
#     ```
#
#     It takes three arguments:
#
#     1. `x`, a positional argument of type `Module`,
#       followed by a __`;`__ <!-- note: trailing spaces are deliberate-->
#     2. `all`, a keyword argument of type `Bool` with a default value of
#       `false`
#     3. `imported`, another `Bool` keyword argument that defaults
#       to `false`
#
#     Suppose Melissa wanted to get all names of the `Trebuchets` module, including
#     those that are not exported. What would the function call look like?
#
#     1. `names(Trebuchets, true)`
#     2. `names(Trebuchets, all = true)` <!---correct-->
#     3. `names(Trebuchets, all)`
#     4. `names(Trebuchets; all = true)` <!---correct-->
#     5. Answer 2 and 4 <!---correct-->
#
#     !!! solution
#         1. Both arguments are present, but `true` is presented without a keyword.
#            This throws a `MethodError: no method matching names(::Module, ::Bool)`
#         2. This is a __correct__ call.
#         3. Two arguments are present, but the keyword `all` is not assigned a
#            value. This throws a
#           `MethodError: no method matching names(::Module, ::typeof(all))`
#         4. This is also __correct__: you _can_ specify where the positional arguments
#            end with the `;`, but you do not have to.
#         5. This is the __most correct__ answer.


include("definition.jl")

# Now she can execute

names(Trebuchets)

# which yields the exported names of the `Trebuchets` module.
# By convention types are named with _CamelCase_ while functions typically have
# *snake_case*.
# Since Melissa is interested in simulating shots, she looks at the
# `shoot` function from `Trebuchets` (again, using <kbd>?</kbd>):

#md # ```julia-repl
#md # help?> Trebuchets.shoot
#md # ```

#md # ```output
#md #   shoot(ws, angle, w)
#md #   shoot((ws, angle, w))
#md #
#md #   Shoots a Trebuchet with weight w in kg. Releases the weight at the release
#md #   angle angle in radians. The current wind speed is ws in m/s.
#md #   Returns (t, dist), with travel time t in s and travelled distance dist in m.
#md # ```

#nb ?Trebuchets.shoot

# !!! note "Generic functions and methods"
#     In the output we see that `shoot` has two different argument signatures: one with
#     three arguments and one with a `Tuple` of three elements as its single
#     argument. These two signatures correspond to two different implementations.
#     In our case one is calling the other.
#
#     Functions of the same name with different argument signatures are called
#     *methods* of a *generic function* of that name. In our example we have
#     two methods of the `shoot` generic function.
#
#     Almost all function in Julia are generic functions and in particular all user defined functions. An example with
#     particularly many methods is `+`. You can list its methods by executing
#     `methods(+)`, for example.
#
#     Julia determines which method to apply to a tuple of arguments according
#     to set of rules, which are documented in the [Julia Manual’s Methods
#     section](https://docs.julialang.org/en/v1/manual/methods/).

# Now she is ready to fire the first shot.

Trebuchets.shoot(5, 0.25pi, 500)

# That is a lot of output, but Melissa is actually only interested in the
# distance, which is the second element of the tuple that was returned.
# So she tries again and grabs the second element this time:

Trebuchets.shoot(5, 0.25pi, 500)[2]

# which means the shot traveled approximately 118 m.

# ### Defining functions

# Melissa wants to make her future work easier and she fears she might forget to
# take the second element.
# That's why she puts it together in a _function_ like this:

function shoot_distance(windspeed, angle, weight)
       Trebuchets.shoot(windspeed, angle, weight)[2]
end

# !!! note "Implicit return"
#     Note that Melissa didn't have to use the `return` keyword, since in Julia the
#     value of the last line will be returned by default.
#     But she could have used an explicit return and the function would behave the
#     same.

# Now Melissa can just call her wrapper function:

shoot_distance(5, 0.25pi, 500)

# ### Adding methods

# Since Melissa wants to work with the structs `Trebuchet` and `Environment`, she
# adds another convenience method for those:

function shoot_distance(trebuchet::Trebuchet, env::Environment)
     shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end

# This method will call the former method and pass the correct fields from the
# `Trebuchet` and `Environment` structures.

# ### Slurping and splatting

# By peeking into the [documentation](https://docs.julialang.org/en/v1/manual/faq/#The-two-uses-of-the-...-operator:-slurping-and-splatting), Melissa discovers that she
# doesn't need to explicitly declare all the input arguments.
# Instead she can _slurp_ the arguments in the function definition and _splat_
# them in the function body using three dots (`...`) like this:

function shoot_distance(args...) # slurping
     Trebuchets.shoot(args...)[2] # splatting
end

# ### Anonymous functions

# Sometimes it is useful to have a new function and not have to come up with a
# new name.
# These are _anonymous functions_.
# They can be defined with either the so-called stabby lambda notation,

(windspeed, angle, weight) -> Trebuchets.shoot(windspeed, angle, weight)[2]

# or in long form, by omitting the name:

function (windspeed, angle, weight)
      Trebuchets.shoot(windspeed, angle, weight)[2]
end

# ### Calling methods
#
# Now, that she defined all these methods she tests calling a few

shoot_distance(5, 0.25pi, 500)

#

shoot_distance([5, 0.25pi, 500])

# For the other method she needs to construct `Trebuchet` and `Environment` objects first

env = Environment(5, 100)

#

trebuchet = Trebuchet(500, 0.25pi)

# ### Errors and finding documentation

# This error tells her two things:

# 1. a function named `size` was called
# 2. it didn't have a method for `Trebuchet`

# Melissa wants to add the missing method to `size` but she doesn't know
# where it is defined.
# There is a handy _macro_ named `@which` that obtains the module where the
# function is defined.

# !!! note "Macros"
#     Macro names begin with `@` and they don't need parentheses or commas to
#     delimit their arguments.
#     Macros can transform any valid Julia expression and are quite powerful.
#     They can be expanded by prepending `@macroexpand` to the macro call of
#     interest.
using InteractiveUtils #hide

@which size

# Now Melissa knows she needs to add a method to `Base.size` with the
# signature `(::Trebuchet)`.
 
# She can also lookup the docstring using the `@doc` macro

@doc size

# With that information she can now implement this method:

function Base.size(::Trebuchet)
     return tuple(2)
end

# But that is a 3 lines of text for a very short definition.
# Melissa can also using the short form notation to fit this in a single line:

Base.size(::Trebuchet) = tuple(2)

# !!! note Omitting unneeded arguments
#     Melissa could also name the argument in the signature.
#     Like this: `(trebuchet::Trebuchet)`, but since the argument is not needed to compute
#     the output of the function she can omit it.
#     The argument is in this case only used to dispatch to the correct method.

# Now she can try again

trebuchet = Trebuchet(500, 0.25pi)

# Again, there is an error but this time the error message is different:
# It's no longer a method for `size` that is missing but for `getindex`.
# She looks up the documentation for that function

@doc getindex

# Note that the documentation for all methods gets shown and Melissa needs to look for the relevant method first.
# In this case its the paragraph starting with
# ````
# getindex(A, inds...)
# ````
# After a bit of pondering the figures it should be enough to add a method for `getindex` with a single number.
# ````
# getindex(trebuchet::Trebuchet, i::Int)
# ````
#
# !!! note "Syntactic sugar"
#     In Julia `a[1]` is equivalent to `getindex(a, 1)`
#     and `a[2] = 3` to `setindex!(a, 3, 2)`
#     Likewise `a.b` is equivalent to `getproperty(a, :b)`
#     and `a.b = 4` to `setproperty!(a, :b, 4)`.



# !!! keypoints
#     - "You can think of functions being a collection of methods"
#     - "Methods are defined by their signature"
#     - "The signature is defined by the number of arguments, their order and their type"
#     - "Keep the number of positional arguments low"
#     - "Macros transform Julia expressions"
