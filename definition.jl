# Before starting to work in a new document, Melissa has to:

# Activate her environment
using Pkg
Pkg.activate(joinpath(@__DIR__, "projects", "trebuchet"))
Pkg.instantiate()

# Importing the package under its modified name
import Trebuchet as Trebuchets
#-

# Defining the structures
mutable struct Trebuchet <: AbstractVector{Float64}
  counterweight::Float64
  release_angle::Float64
end

struct Environment
  wind::Float64
  target_distance::Float64
end
