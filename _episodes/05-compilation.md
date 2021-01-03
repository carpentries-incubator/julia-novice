---
title: "Compilation process"
teaching: 30
exercises: 0
questions:
- "What stages are in julia compilation involved?"
objectives:
- "Learn the use of `dump`,`@code_lowered`,`@code_llvm` and `@code_native`."
- "Understand the implications of type in-/stability."
keypoints:
- "type inference can be checked via `@code_warntype`"
- "type stable code is significantly faster"
---

{% include links.md %}
