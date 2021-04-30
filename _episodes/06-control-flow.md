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
She wants her trebuchet to shoot two hundred meters!

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
{. :quotation}

Melissa uses the `gradient` function of `ForwardDiff.jl` to get the direction in which she needs to change the parameters to make the largest difference.

> ## Do you remember?
> What does Melissa need to write into the REPL to install the package `ForwardDiff`?
{: .challenge}

> ##
> <kbd>]</kbd> to enter Pkg-mode.
> Then 
> ~~~
> pkg> add ForwardDiff
> ~~~
> {: .language-julia}
{: .solution}

~~~
julia> using ForwardDiff: gradient

julia> arguments = [5, 0.25pi, 500];

julia> grad = gradient(x -> (shoot_distance(x) - 200), arguments)
TODO: wirte correct gradient
~~~
{: .language-julia}

Melissa now changes her arguments a little bit in the direction of the gradient and checks the new distance.

~~~
julia> new_arguments = arguments - 0.1 * grad;

julia> shoot_distance(new_arguments)
~~~
{: .language-julia}
### For loops

