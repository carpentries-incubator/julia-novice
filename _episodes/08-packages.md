---
title: "Finding and creating Packages"
teaching: 30
exercises: 0
questions:
- "How to create a package?"
- "How to find the right package?"
objectives:
- "Learn setting up a project using modules."
- "Learn common package structure."
- "Practice setting up unit tests."
- "Learn to browse github for packages and find documentation."
keypoints:
- "The general registry is hosted on github."
- "Useful information can be found at the Readme.md and usually each package has its own documentation homepage as well."
- "Juliahub can be used to search for packages and documentation."
- "Split code in `src`, `test` and `script` code."
- "Tests are set up using `@test` and `@testset` macro."
---

## Modules

Melissa now has a bunch of definitions in her running julia session and using the REPL for interactive exploration is great, but on the one hand it is more and more taxing to keep in mind, what is defined and on the other hand all the definitions are lost once she closes the REPL.

That is why she decides to put her code in a file.
She opens up her text editor and creates a file called `aim_trebuchet.jl` and pastes the code she got so far in there.

This is what it looks like:
~~~
import Trebuchet as Trebuchets
using ForwardDiff: gradient

struct Trebuchet
  counterweight::Float64
  release_angle::Float64
end

struct Environment
  wind::Float64
  target_distance::Float64
end

function shoot_distance(windspeed, angle, weight)
    Trebuchets.shoot(windspeed, angle, weight)[2]
end
function shoot_distance(args...)
    Trebuchets.shoot(args...)[2]
end

function aim(target, arguments; ε = 1e-1, η = 0.05, wind::Float64 = 5.0)
    new_arguments = copy(arguments)
    hit = x -> (shoot_distance([wind, x...]) - target)
    while abs(hit(new_arguments)) > ε
        grad = gradient(hit, new_arguments)
        new_arguments -= η * grad
    end
    return new_arguments
end

arguments = [0.25pi, 500]
aim(100, arguments)
shoot_distance([5, ans...])
~~~
{: .language-julia}

{% include links.md %}
