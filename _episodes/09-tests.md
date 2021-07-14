---
title: "Adding tests"
teaching: 10
exercises: 10
questions:
- "What are unit tests?"
- "How are tests organized in julia?"
objectives:
- "Learn to create unit tests and test-sets using the `Test` standard library"
keypoints:
- "Tests are important"
---

## Unit tests

Now that Melissa has released her first package she fears that future changes will impact the existing functionality of her package.
This can be prevented by adding tests to her package.

Looking at the structure of other packages Melissa figured out that tests usually go in a separate `test` folder next to the `src` folder.
This should contain a `runtests.jl` file.
