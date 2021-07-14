---
title: "Introduction"
teaching: 5
exercises: 0
questions:
- "Who is teaching?"
- "What is the schedule?"
objectives:
- "Explain the overall content and in more detail the content of todays lesson."
keypoints:
- "Julia is a just in time compiled language"
---

## What is a programming language?

A programming language mediates between the natural language of humans and the machine instructions of a computer.
The human specifies what the computer should compute on a high level using the programming language.
This specification will be translated to machine instructions, the so called assembly code, which will be executed by the processor (CPU, GPU, ...).

## Interpreting and compiling

This translation happens differently depending of the programming language you use.
There are mainly two different techniques: _compiling_ and _interpreting_.
Interpreted languages such as python and R translate instructions one at a time, while compiled languages like C and Fortran take whole documents analyze the structure of the code and perform optimizations before translating it to machine code.

This leads to more efficient machine instructions of the compiled code at the cost of less flexibility and more verbose code.
Most prominently the need for type declarations in compiled languages.

## Why julia?

Julia is a programming language that superficially looks like an interpreted language and mostly behaves like one.
But before each function is executed it will compile it _just in time_.

Thus you get the flexibility of an interpreted language and the execution speed of the compiled language at the cost of waiting a bit longer for the first execution of any function.

{% include links.md %}
