---
title: "Using the package manager"
teaching: 20
exercises: 0
---

:::::: questions

## Questions

  - "Where do I find packages?"
  - "How do I add packages?"
  - "How can I use packages?"

::::::

:::::: objectives

## Objectives

  - "Learn to add packages using pkg-mode"
  - "Learn to resolve name conflicts"
  - "Learn to activate environments"

::::::

## The package manager

:::::: callout

## The package Manager

This chapter focuses on the package mode available within the REPL.

A different aproach would be using the <kbd>Pkg</kbd> notation.

```julia
using Pkg
Pkg.add("Example")
```

If you prefer to use that method and want to know more, remember how to get [help](02_Getting_started.md).

_(for exp. <kbd>?Pkg.add</kbd>)_

::::::

Now it is time for Melissa and their mates to simulate the launch of the
trebuchet.
The necessary equations are really complicated, but an investigation on
[JuliaHub](https://juliahub.com/) revealed that someone already implemented
these and published it as the Julia package [`Trebuchet.jl`](https://juliahub.com/ui/Search?q=trebuchet&type=packages).
That saves some real work.

Melissa enters package mode by pressing <kbd>]</kbd>:

```julia
]
```

The `julia>` prompt becomes a blue `pkg>` prompt that shows the Julia version
that Melissa is running.

After consulting the [documentation](https://julialang.github.io/Pkg.jl/v1/)
she knows that the prompt is showing the _currently activated environment_ and
that this is the global environment that is activated by default.

However, she doesn't want to clutter the global environment when working on her
project.
The default global environment is indicated with `(@v1.x)` before the `pkg>` prompt, where `x` is the minor version number of julia, so on julia 1.7 it will look like `(@v1.7)`.
To create a new environment she uses the `activate` function of the package manager:

```julia
(@v1.x) pkg> activate projects/trebuchet
```


````output
  Activating project at `~/work/julia-novice/julia-novice/output/carpentries/projects/trebuchet`
    Updating registry at `~/.julia/registries/General.toml`
    Updating `~/work/julia-novice/julia-novice/output/carpentries/projects/trebuchet/Project.toml`
  [f6369f11] + ForwardDiff v0.10.36
  [295af30f] + Revise v3.5.3
  [98b73d46] + Trebuchet v0.2.2
    Updating `~/work/julia-novice/julia-novice/output/carpentries/projects/trebuchet/Manifest.toml`
⌅ [47edcb42] + ADTypes v0.1.6
  [79e6a3ab] + Adapt v3.6.2
  [ec485272] + ArnoldiMethod v0.2.0
  [4fba245c] + ArrayInterface v7.4.11
  [30b0a656] + ArrayInterfaceCore v0.1.29
  [bf4720bc] + AssetRegistry v0.1.0
  [d1d4a3ce] + BitFlags v0.1.7
  [62783981] + BitTwiddlingConvenienceFunctions v0.1.5
  [2a0fbf3d] + CPUSummary v0.2.3
  [d360d2e6] + ChainRulesCore v1.16.0
  [fb6a15b2] + CloseOpenIntervals v0.1.12
  [da1fd8a2] + CodeTracking v1.3.4
  [944b1d66] + CodecZlib v0.7.2
  [3da002f7] + ColorTypes v0.11.4
  [5ae59095] + Colors v0.12.10
  [38540f10] + CommonSolve v0.2.4
  [bbf7d656] + CommonSubexpressions v0.3.0
  [34da2185] + Compat v4.9.0
  [f0e56b4a] + ConcurrentUtilities v2.2.1
  [187b0558] + ConstructionBase v1.5.3
  [adafc99b] + CpuId v0.3.1
  [9a962f9c] + DataAPI v1.15.0
  [864edb3b] + DataStructures v0.18.15
  [e2d170a0] + DataValueInterfaces v1.0.0
  [2b5f629d] + DiffEqBase v6.128.1
  [163ba53b] + DiffResults v1.1.0
  [b552c78f] + DiffRules v1.15.1
  [b4f34e82] + Distances v0.10.9
  [ffbed154] + DocStringExtensions v0.9.3
  [4e289a0a] + EnumX v1.0.4
  [460bff9d] + ExceptionUnwrapping v0.1.9
  [d4d017d3] + ExponentialUtilities v1.24.0
  [e2ba6199] + ExprTools v0.1.10
  [7034ab61] + FastBroadcast v0.2.6
  [9aa1b823] + FastClosures v0.3.2
  [29a986be] + FastLapackInterface v2.0.0
  [6a86dc24] + FiniteDiff v2.21.1
  [53c48c17] + FixedPointNumbers v0.8.4
  [f6369f11] + ForwardDiff v0.10.36
  [069b7b12] + FunctionWrappers v1.1.3
  [77dc65aa] + FunctionWrappersWrappers v0.1.3
  [de31a74c] + FunctionalCollections v0.5.0
  [46192b85] + GPUArraysCore v0.1.5
  [c145ed77] + GenericSchur v0.5.3
  [86223c79] + Graphs v1.8.0
  [cd3eb016] + HTTP v1.9.14
  [3e5b6fbb] + HostCPUFeatures v0.1.16
  [615f187c] + IfElse v0.1.1
  [d25df0c9] + Inflate v0.1.3
  [92d709cd] + IrrationalConstants v0.2.2
  [82899510] + IteratorInterfaceExtensions v1.0.0
  [692b3bcd] + JLLWrappers v1.4.1
  [97c1335a] + JSExpr v0.5.4
  [682c06a0] + JSON v0.21.4
  [aa1ae85d] + JuliaInterpreter v0.9.24
  [ef3ab10e] + KLU v0.4.0
  [ba0b0d4f] + Krylov v0.9.3
  [10f19ff3] + LayoutPointers v0.1.14
  [50d2b5c4] + Lazy v0.15.1
  [d3d80556] + LineSearches v7.2.0
  [7ed4a6bd] + LinearSolve v2.5.0
  [2ab3a3ac] + LogExpFunctions v0.3.24
  [e6f89c97] + LoggingExtras v1.0.0
  [bdcacae8] + LoopVectorization v0.12.165
  [6f1432cf] + LoweredCodeUtils v2.3.0
  [1914dd2f] + MacroTools v0.5.10
  [d125e4d3] + ManualMemory v0.1.8
  [739be429] + MbedTLS v1.1.7
  [46d2c3a1] + MuladdMacro v0.2.4
  [d41bc354] + NLSolversBase v7.8.3
  [2774e3e8] + NLsolve v4.5.1
  [77ba4419] + NaNMath v1.0.2
  [8913a72c] + NonlinearSolve v1.9.0
  [510215fc] + Observables v0.5.4
  [6fe1bfb0] + OffsetArrays v1.12.10
  [4d8831e6] + OpenSSL v1.4.1
  [bac558e1] + OrderedCollections v1.6.2
  [1dea7af3] + OrdinaryDiffEq v6.53.4
  [65ce6f38] + PackageExtensionCompat v1.0.1
  [d96e819e] + Parameters v0.12.3
  [69de0a69] + Parsers v2.7.2
  [fa939f87] + Pidfile v1.3.0
  [f517fe37] + Polyester v0.7.5
  [1d0040c9] + PolyesterWeave v0.2.1
  [d236fae5] + PreallocationTools v0.4.12
  [aea7be01] + PrecompileTools v1.1.2
  [21216c6a] + Preferences v1.4.0
  [3cdcf5f2] + RecipesBase v1.3.4
  [731186ca] + RecursiveArrayTools v2.38.7
  [f2c3362d] + RecursiveFactorization v0.2.20
  [189a3867] + Reexport v1.2.2
  [ae029012] + Requires v1.3.0
  [295af30f] + Revise v3.5.3
  [7e49a35a] + RuntimeGeneratedFunctions v0.5.12
  [94e857df] + SIMDTypes v0.1.0
  [476501e8] + SLEEFPirates v0.6.39
  [0bca4576] + SciMLBase v1.94.0
  [e9a6253c] + SciMLNLSolve v0.1.8
  [c0aeaf25] + SciMLOperators v0.3.6
  [efcf1570] + Setfield v1.1.1
  [777ac1f9] + SimpleBufferStream v1.1.0
  [727e6d20] + SimpleNonlinearSolve v0.1.19
  [699a6c99] + SimpleTraits v0.9.4
  [ce78b400] + SimpleUnPack v1.1.0
  [66db9d55] + SnoopPrecompile v1.0.3
  [47a9eef4] + SparseDiffTools v2.4.1
  [e56a9233] + Sparspak v0.3.9
  [276daf66] + SpecialFunctions v2.3.1
  [aedffcd0] + Static v0.8.8
  [0d7ed370] + StaticArrayInterface v1.4.0
  [90137ffa] + StaticArrays v1.6.2
  [1e83bf80] + StaticArraysCore v1.4.2
  [82ae8749] + StatsAPI v1.6.0
  [7792a7ef] + StrideArraysCore v0.4.17
  [2efcf032] + SymbolicIndexingInterface v0.2.2
  [3783bdb8] + TableTraits v1.0.1
  [bd369af6] + Tables v1.10.1
  [8290d209] + ThreadingUtilities v0.5.2
  [3bb67fe8] + TranscodingStreams v0.9.13
  [98b73d46] + Trebuchet v0.2.2
  [d5829a12] + TriangularSolve v0.1.19
  [410a4b4d] + Tricks v0.1.7
  [781d530d] + TruncatedStacktraces v1.4.0
  [5c2747f8] + URIs v1.5.0
  [3a884ed6] + UnPack v1.0.2
  [3d5dd08c] + VectorizationBase v0.21.64
  [19fa3120] + VertexSafeGraphs v0.2.0
  [0f1e0344] + WebIO v0.8.21
  [104b5d7c] + WebSockets v1.6.0
  [cc8bc4a8] + Widgets v0.6.6
  [700de1a5] + ZygoteRules v0.2.3
  [458c3c95] + OpenSSL_jll v3.0.10+0
  [efe28fd5] + OpenSpecFun_jll v0.5.5+0
  [0dad84c5] + ArgTools v1.1.1
  [56f22d72] + Artifacts
  [2a0f44e3] + Base64
  [ade2ca70] + Dates
  [8ba89e20] + Distributed
  [f43a241f] + Downloads v1.6.0
  [7b1f6079] + FileWatching
  [9fa8497b] + Future
  [b77e0a4c] + InteractiveUtils
  [b27032c2] + LibCURL v0.6.3
  [76f85450] + LibGit2
  [8f399da3] + Libdl
  [37e2e46d] + LinearAlgebra
  [56ddb016] + Logging
  [d6f4376e] + Markdown
  [a63ad114] + Mmap
  [ca575930] + NetworkOptions v1.2.0
  [44cfe95a] + Pkg v1.9.2
  [de0858da] + Printf
  [3fa0cd96] + REPL
  [9a3f8284] + Random
  [ea8e919c] + SHA v0.7.0
  [9e88b42a] + Serialization
  [1a1011a3] + SharedArrays
  [6462fe0b] + Sockets
  [2f01184e] + SparseArrays
  [10745b16] + Statistics v1.9.0
  [4607b0f0] + SuiteSparse
  [fa267f1f] + TOML v1.0.3
  [a4e569a6] + Tar v1.10.0
  [8dfed614] + Test
  [cf7118a7] + UUIDs
  [4ec0a83e] + Unicode
  [e66e0078] + CompilerSupportLibraries_jll v1.0.5+0
  [deac9b47] + LibCURL_jll v7.84.0+0
  [29816b5a] + LibSSH2_jll v1.10.2+0
  [c8ffd9c3] + MbedTLS_jll v2.28.2+0
  [14a3606d] + MozillaCACerts_jll v2022.10.11
  [4536629a] + OpenBLAS_jll v0.3.21+4
  [05823500] + OpenLibm_jll v0.8.1+0
  [bea87d4a] + SuiteSparse_jll v5.10.1+6
  [83775a58] + Zlib_jll v1.2.13+0
  [8e850b90] + libblastrampoline_jll v5.8.0+0
  [8e850ede] + nghttp2_jll v1.48.0+0
  [3f19e933] + p7zip_jll v17.4.0+0
        Info Packages marked with ⌅ have new versions available but compatibility constraints restrict them from upgrading. To see why use `status --outdated -m`
Precompiling project...
[32m  ✓ [39m[90mPackageExtensionCompat[39m
[33m  ✓ [39m[90mURIs[39m
[32m  ✓ [39m[90mRuntimeGeneratedFunctions[39m
[32m  ✓ [39m[90mCodeTracking[39m
[32m  ✓ [39m[90mOpenSSL_jll[39m
[32m  ✓ [39m[90mHostCPUFeatures[39m
[32m  ✓ [39m[90mSpecialFunctions[39m
[32m  ✓ [39m[90mKrylov[39m
[32m  ✓ [39m[90mSciMLBase[39m
[32m  ✓ [39m[90mOpenSSL[39m
[32m  ✓ [39m[90mSpecialFunctions → SpecialFunctionsChainRulesCoreExt[39m
[32m  ✓ [39m[90mDiffRules[39m
[32m  ✓ [39m[90mHTTP[39m
[32m  ✓ [39mForwardDiff
[32m  ✓ [39m[90mWebSockets[39m
[32m  ✓ [39m[90mJuliaInterpreter[39m
[32m  ✓ [39m[90mForwardDiff → ForwardDiffStaticArraysExt[39m
[32m  ✓ [39m[90mWebIO[39m
[32m  ✓ [39m[90mSparseDiffTools[39m
[32m  ✓ [39m[90mPreallocationTools[39m
[32m  ✓ [39m[90mVectorizationBase[39m
[32m  ✓ [39m[90mNLSolversBase[39m
[32m  ✓ [39m[90mJSExpr[39m
[32m  ✓ [39m[90mSLEEFPirates[39m
[32m  ✓ [39m[90mDiffEqBase[39m
[32m  ✓ [39m[90mLineSearches[39m
[32m  ✓ [39m[90mLoweredCodeUtils[39m
[32m  ✓ [39m[90mNLsolve[39m
[32m  ✓ [39m[90mSimpleNonlinearSolve[39m
[32m  ✓ [39m[90mSciMLNLSolve[39m
[32m  ✓ [39mRevise
[32m  ✓ [39m[90mLoopVectorization[39m
[32m  ✓ [39m[90mLoopVectorization → SpecialFunctionsExt[39m
[32m  ✓ [39m[90mLoopVectorization → ForwardDiffExt[39m
[32m  ✓ [39m[90mTriangularSolve[39m
[32m  ✓ [39m[90mRecursiveFactorization[39m
[32m  ✓ [39m[90mLinearSolve[39m
[32m  ✓ [39m[90mNonlinearSolve[39m
[32m  ✓ [39m[90mOrdinaryDiffEq[39m
[32m  ✓ [39mTrebuchet
  40 dependencies successfully precompiled in 389 seconds. 116 already precompiled.
  [33m1[39m dependency precompiled but a different version is currently loaded. Restart julia to access the new version

````

In this environment she adds the `Trebuchet` package from its
open source code [repository on GitHub](https://github.com/FluxML/Trebuchet.jl) by typing

```julia
(trebuchet) pkg> add Trebuchet
```

Melissa quickly recognizes that far more packages are being installed than just
`Trebuchet`.
These are the dependencies of `Trebuchet`.
From the output

```output
[...]
Updating `[...]/projects/trebuchet/Project.toml`
  [98b73d46] + Trebuchet v0.2.1
  Updating `[...]/projects/trebuchet/Manifest.toml`
  [1520ce14] + AbstractTrees v0.3.3
  [79e6a3ab] + Adapt v1.1.0
  [...]
```

she sees that two files were created: `Project.toml` and `Manifest.toml`.

The project file `Project.toml` only contains the packages needed for her
project, while the manifest file `Manifest.toml` records the direct and
indirect dependencies as well as their current version, thus providing a fully
reproducible record of the code that is actually executed.
"That is really handy when I want to share my work with the others," thinks
Melissa.

After the installation finished she can check the packages present in her
environment.

```julia
(trebuchet) pkg> status
```


````output
Status `~/work/julia-novice/julia-novice/output/carpentries/projects/trebuchet/Project.toml`
  [f6369f11] ForwardDiff v0.10.36
  [295af30f] Revise v3.5.3
  [98b73d46] Trebuchet v0.2.2

````

Melissa can get back to the global environment using `activate` without any parameters.

:::::: callout

## Why use GitHub?

Melissa could have added the GitHub version of Trebuchet.jl by typing

```julia
(trebuchet) pkg> add Trebuchet#master
```

In this case the JuliaHub version is the same as the GitHub version,
so Melissa does not need to specify the installation.

If you know a package is stable, go ahead and install the default version registered on JuliaHub.
Otherwise, it’s good to check how different that version is from the current state of the software project.
Click through the link under “Repository” on the JuliaHub package page.

::::::

## Using and importing packages

Now that Melissa added the package to her environment, she needs to load it.
Julia provides two keywords for loading packages: `using` and `import`.

The difference is that `import` brings only the name of the package into the
namespace and then all functions in that package need the name in front
(prefixed).
But packages can define a list of function names to export, which means the
functions should be brought into the user's namespace when he loads the package
with `using`.
This makes working at the REPL more convenient.

### Name conflicts

It may happen that name conflicts arise.
For example Melissa defined a structure named `Trebuchet`, but the package she
added to the environment is also named `Trebuchet`.
Now she would get an error if she tried to `import`/`using` it directly.
One solution is to assign a nickname or alias to the package upon `import`
using the keyword *`as`*:

````julia
import Trebuchet as Trebuchets
````

:::::: keypoints

## Keypoints

  - "Find packages on JuliaHub"
  - "add packages using `pkg> add`"
  - "use many small environments rather than one big environment"

::::::

