---
title: "Adding tests"
teaching: 10
exercises: 30
---

:::::: questions

## Questions

  - "What are unit tests?"
  - "How are tests organized in Julia?"

::::::

:::::: objectives

## Objectives

  - "Learn to create unit tests and test-sets using the `Test` standard library"

::::::

## Unit tests

Now that Melissa has released her first package she fears that future changes
will impact the existing functionality of her package.
This can be prevented by adding tests to her package.

Looking at the structure of other packages Melissa figured out that tests
usually go in a separate `test` folder next to the `src` folder.
This should contain a `runtests.jl` file.

The standard library `Test` provides the functionality for writing tests:
namely, the macros `@test` and `@testset`.

`@test` can be used to test a single equality, such as

````julia
using Test
@test 1 + 1 == 2
````

````output
Test Passed
````

Several tests can be grouped in a test-set with a descriptive name

````julia
using Test
@testset "Test arithmetic equalities" begin
    @test 1 + 1 == 2
end
````

````output
Test.DefaultTestSet("Test arithmetic equalities", Any[], 1, false, false, true, 1.698245666140703e9, 1.698245666189045e9, false)
````

With this Melissa can run her test using the pkg mode of the REPL:

```julia
(MelissasModule) pkg> test
```

### Test specific dependencies

Melissa needed to add `Test` to her package in order to run the code above, but
actually `Test` is not needed for her package other than testing.
Thus it is possible to move the `Test` entry in the `Project.toml` file from
`[deps]` to an `[extras]` section and then add another entry:

```julia
[targets]
test = ["Test"]
```

Check out the [sample project file](../code/Project.toml) for a complete
example.

:::::: challenge

## Challenge

Create a test for MelissasModule
Create a test that ensures that `shoot_distance` returns a value that is
between `target - ε` and `target + ε`.

:::::: solution

## Solution

```julia
using MelissasModule
using Test

@testset "Test hitting target" begin
   imprecise_trebuchet = Trebuchet(500.0, 0.25pi)
   environment = Environment(5, 100)
   precise_trebuchet = aim(imprecise_trebuchet, environment)
   @test 100 - 0.1 <= shoot_distance(precise_trebuchet, environment) <= 100 + 0.1
   # default ε is 0.1
end
```

::::::


::::::

:::::: keypoints

## Keypoints

  - "Tests are important"

::::::

