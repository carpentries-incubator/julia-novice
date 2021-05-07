---
title: "Control flow"
teaching: 45
exercises: 0
questions:
- "What are for and while loops?"
- "How to use conditionals?"
objectives:
---

{% include links.md %}

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


Since she can't influence the wind, the only arguments that can vary are the release angle and the mass of the counterweight.
~~~
julia> using ForwardDiff: gradient

julia> arguments = [0.25pi, 500];

julia> grad = gradient(x -> (shoot_distance([5, x...]) - 100), arguments)
2-element Vector{Float64}:
 -47.1917378801788
  -0.022101014146311698
~~~
{: .language-julia}

Melissa now changes her arguments a little bit in the direction of the gradient and checks the new distance.

~~~
julia> new_arguments = arguments - 0.05 * grad;

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
julia> function aim(target, arguments; N = 10, η = 0.05, wind::Float64 = 5.0)
           new_arguments = copy(arguments)
           for _ in 1:N
               grad = gradient(x -> (shoot_distance([wind, x...]) - target), new_arguments)
               new_arguments -= η * grad
               # short form of `new_arguments = new_arguments - η * grad`
           end
           return new_arguments
       end

julia> new_arguments = aim(100, arguments);

julia> shoot_distance([5, new_arguments...])
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
julia> function aim(target, arguments; ε = 1e-1, η = 0.05, wind::Float64 = 5.0)
           new_arguments = copy(arguments)
           hit = x -> (shoot_distance([wind, x...]) - target)
           while abs(hit(new_arguments)) > ε
               grad = gradient(hit, new_arguments)
               new_arguments -= η * grad
           end
           return new_arguments
       end

julia> aim(100, arguments)
2-element Vector{Float64}:
 119.59293257732767
 499.9498970976752

julia> shoot_distance([5, ans...])
100.0975848073789
~~~
{: .language-julia}

That is more what she had in mind.