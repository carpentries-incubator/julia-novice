# !!! yaml
#     ---
#     title: "Interfaces & conditionals"
#     teaching: 30
#     exercises: 30
#     ---
#
# !!! questions
#       - "How to use conditionals?"
#       - "What is an interface?"
#
# !!! objectives
#

# ## Conditionals

include("definition.jl")
Base.size(::Trebuchet) = tuple(2)

# Now that Melissa knows that she has to add a method for
# ````
# getindex(trebuchet::Trebuchet, i::Int)
# ````
# she thinks about the implementation.

# If the index is `1` she wants to get the `counterweight` field and if the index is `2`
# she wants to get `release_angle` and since these are the only two fields she
# wants to return an error if anything else comes in.
# In Julia the keywords to specify conditions are `if`, `elseif` and `else`,
# closed with an `end`.
# Thus she writes

function Base.getindex(trebuchet::Trebuchet, i::Int)
    if i === 1
        return trebuchet.counterweight
    elseif i === 2
        return trebuchet.release_angle
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end

# And tries again:

trebuchet = Trebuchet(500, 0.25pi)

# Notice, that the printing is different from our `trebuchet` in [the former episode](03_Julia_type_system.ipynb).

# ### Interfaces

# Why is that?
# By subtyping `Trebuchet` as `AbstractVector` we implicitly opted into
# a widespread _interface_ in the Julia
# language: `AbstractArray`s.
# An interface is a collection of methods that should be implemented by all subtypes of the interface type in order for generic code to work.
# For example, the [Julia manual](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array) lists all methods that a subtype of
# `AbstractArray` need to implement to adhere to the `AbstractArray` interface:

# - `size(A)` returns a tuple containing the dimensions of `A`
# - `getindex(A, i::Int)` returns the value associated with index `i`
# - `setindex!(A, v, i::Int)` writes a new value `v` at the index `i` (optional)

# Now, that Melissa implemented the mandatory methods for this interface for the `Trebuchet` type, it will work
# with every function in `Base` that accepts an `AbstractArray`.
# She tries a few things that now work without her writing explicit code for it:

trebuchet + trebuchet

#

using LinearAlgebra
dot(trebuchet, trebuchet)

#

trebuchet * transpose(trebuchet)

# That is, it now behaves like you would expect from an ordinary matrix.

# Now she goes about implementing the missing optional method for `setindex!` of the `AbstractArray` interface.

# !!! freecode "Implement `setindex!`"
#
#     Write the missing method for `setindex(trebuchet::Trebuchet, v, i::Int)` similar to Melissas `getindex` function.
#
#     !!! solution
#
#         ```julia
#         function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
#              if i === 1
#                  trebuchet.counterweight = v
#             elseif i === 2
#                 trebuchet.release_angle = v
#             else
#                 error("Trebuchet only accepts indices 1 and 2, yours is $i")
#             end
#         end
#         ```

#md function Base.setindex!(trebuchet::Trebuchet, v, i::Int) #hide
#md     if i === 1 #hide
#md         trebuchet.counterweight = v #hide
#md     elseif i === 2 #hide
#md         trebuchet.release_angle = v #hide
#md     else #hide
#md        error("Trebuchet only accepts indices 1 and 2, yours is $i") #hide
#md     end #hide
#md end #hide

# With the new `Trebuchet` defined with a complete `AbstractArray` interface,
# Melissa tries her new method to modify a counterweight by index:

trebuchet[1] = 2
#-

trebuchet




# !!! keypoints
#     - "Interfaces are informal"
#     - "Interfaces facilitate code reuse"
#     - "Conditions use `if`, `elseif`, `else` and `end`"
