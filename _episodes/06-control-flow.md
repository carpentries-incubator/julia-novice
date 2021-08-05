---
title: "Control flow"
teaching: 45
exercises: 15
questions:
- "What are for and while loops?"
- "How to use conditionals?"
- "What is an interface?"
objectives:
keypoints:
- "Interfaces are informal"
- "Use for loops for a known number of iterations and while loops for an unknown number of iterations."
---

{% include links.md %}

## Conditionals

Now that Melissa knows which method to add she thinks about the implementation.

If the index is `1` she wants to set `counterweight` while if the index is `2` she wants to set `release_angle` and since these are the only to fields she wants to return an error if anything else comes in.
In julia the keywords to specify conditions are `if`, `elseif` and `else`.
Closed with an `end`.

Thus she writes
~~~
function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
    if i === 1
        trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end
~~~
{: .language-julia}

### Interfaces

`setindex!` is actually one function of a widespread _interface_ in the julia language: `AbstractArray`s.
An interface is a collection of methods that are all implemented by a certain type.
For example lists the [julia manual](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array) all methods that a subtype of `AbstractArray` need to implement to adhere to the `AbstractArray` interface.
If Melissa does this then her `Trebuchet` type will work with every function in `Base` that accepts an `AbstractArray`.

> ## Implement the `AbstractArray` interface for `Trebuchet`
> Now we know enough to actually implement the `AbstractArray` interface.
> You don't need to implement the optional methods.
> We set `IndexStyle(Trebuchet) = IndexLinear()`
>
>> ## Solution
>> ~~~
>> Base.size(trebuchet::Trebuchet) = tuple(2)
>> Base.getindex(trebuchet::Trebuchet, i::Int) = getfield(trebuchet, i)
>> function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
>>     if i === 1
>>         trebuchet.counterweight = v
>>     elseif i === 2
>>         trebuchet.release_angle = v
>>     else
>>         error("Trebuchet only accepts indices 1 and 2, yours is $i")
>>     end
>> end
>> ~~~
>>{: .language-julia}
>{: .solution}
{: .challenge}


## Loops

Now Melissa knows how to shoot the virtual trebuchet and get the distance of the projectile, but in order to aim she needs to make a lot of trial shots in a row.
She wants her trebuchet to only shoot a hundred meters.

She could execute the function several times on the REPL with different parameters, but that gets tiresome quickly.
A better way to do this is to use loops.

But first Melissa needs a way to improve her parameters.

> ## Digression: gradients
> The `shoot_distance` function takes three input parameters and returns one value (the distance).
> Whenever we change one of the input parameters, we will get a different distance.
>
> The [_gradient_](https://en.wikipedia.org/wiki/Gradient) of a function gives the direction in which the return value will change by the largest amount.
>
> Since the `shoot_distance` function has three input parameters, the gradient of `shoot_distance` will return a 3-element `Array`.
> One direction for each input parameter.
>
> Thanks to [automatic differentiation](https://en.wikipedia.org/wiki/Automatic_differentiation) and the julia package `ForwardDiff.jl` gradients can be calculated easily.
{: .quotation}

Melissa uses the `gradient` function of `ForwardDiff.jl` to get the direction in which she needs to change the parameters to make the largest difference.

> ## Do you remember?
> What does Melissa need to write into the REPL to install the package `ForwardDiff`?
>
>> ## Solution
>> <kbd>]</kbd> to enter Pkg-mode.
>> Then
>> ~~~
>> pkg> add ForwardDiff
>> ~~~
>> {: .language-julia}
>{: .solution}
{: .challenge}

<!-- TODO: can we get promotion to Trebuchet here? -->
<!-- so we can write
julia> grad = gradient(x -> (shoot_distance(x, environment) - environment.target_distance), imprecise_trebuchet) -->
~~~
julia> using ForwardDiff: gradient

julia> imprecise_trebuchet = Trebuchet(500.0, 0.25pi);
julia> environment = Environment(5.0, 100.0);

julia> grad = gradient(x -> (shoot_distance([environment.wind, x[2], x[1]] - environment.target_distance), imprecise_trebuchet)
2-element Vector{Float64}:
 -47.1917378801788
  -0.022101014146311698
~~~
{: .language-julia}

Melissa now changes her arguments a little bit in the direction of the gradient and checks the new distance.

<!-- TODO: can we get promotion to Trebuchet here? -->
~~~
julia> better_trebuchet = imprecise_trebuchet - 0.05 * grad;

julia> shoot_distance([5, new_arguments...])
58.871526223121755
~~~
{: .language-julia}

That got shorter, but also a bit too short.

> ## Experiment
> How far can you change the parameters in the direction of the gradient, such that it still improves the distance?
{: .discussion}

### For loops

Now that Melissa knows it is going in the right direction she wants to automate the additional iterations.
She writes a new function `aim`, that performs the application of the gradient `N` times.
~~~
julia> function aim(trebuchet, environment; N = 10, η = 0.05)
           better_trebuchet = copy(trebuchet)
           for _ in 1:N
               grad = gradient(x -> (shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance), better_trebuchet)
               better_trebuchet -= η * grad
               # short form of `better_trebuchet = better_trebuchet - η * grad`
           end
           return Trebuchet(better_trebuchet[1], better_trebuchet[2])
       end

julia> better_trebuchet  = aim(imprecise_trebuchet, environment);

julia> shoot_distance(better_trebuchet, environment)
92.90796744088856
~~~
{: .language-julia}

> ## Explore
> Play around with different inputs of `N` and `η`.
> How close can you come?
{: .discussion}

### While loops

Melissa finds the output of the above `aim` function too unpredictable to be useful.
That's why she decides to change it a bit.
This time she uses a `while`-loop to run the iterations until she is sufficiently near her target.

~~~
julia> function aim(trebuchet::Trebuchet, environment::Environment; ε = 1e-1, η = 0.05)
            better_trebuchet = copy(trebuchet)
            hit = x -> (shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance)
            while abs(hit(better_trebuchet)) > ε
                grad = gradient(hit, better_trebuchet)
                better_trebuchet -= η * grad
            end
            return Trebuchet(better_trebuchet[1], better_trebuchet[2])
        end

julia> better_trebuchet = aim(imprecise_trebuchet, environment)
2-element Trebuchet:
 499.9498970976752
 119.59293257732767

julia> shoot_distance(better_trebuchet, environment)
100.0975848073789
~~~
{: .language-julia}

That is more what she had in mind.
