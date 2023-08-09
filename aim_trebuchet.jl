using Pkg
Pkg.activate("projects/trebuchet")
import Trebuchet as Trebuchets
using ForwardDiff: gradient

mutable struct Placeholder_Trebuchet <: AbstractVector{Float64}
    counterweight::Float64
    release_angle::Float64
end

Base.copy(trebuchet::Placeholder_Trebuchet) = Placeholder_Trebuchet(trebuchet.counterweight, trebuchet.release_angle)

Base.size(trebuchet::Placeholder_Trebuchet) = tuple(2)

Base.getindex(trebuchet::Placeholder_Trebuchet, i::Int) = getfield(trebuchet, i)

function Base.setindex!(trebuchet::Placeholder_Trebuchet, v, i::Int)
    if i === 1
        trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
end

struct Placeholder_Environment
    wind::Float64
    target_distance::Float64
end

function placeholder_shoot_distance(windspeed, angle, weight)
    Trebuchets.shoot(windspeed, angle, weight)[2]
end

function placeholder_shoot_distance(args...)
    Trebuchets.shoot(args...)[2]
end

function placeholder_shoot_distance(trebuchet::Placeholder_Trebuchet, env::Placeholder_Environment)
    placeholder_shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end

function placeholder_aim(trebuchet::Placeholder_Trebuchet, environment::Placeholder_Environment; ε = 1e-1, η = 0.05)
    better_trebuchet = copy(trebuchet)
    hit = x -> (placeholder_shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance)
    while abs(hit(better_trebuchet)) > ε
        grad = gradient(hit, better_trebuchet)
        better_trebuchet -= η * grad
    end
    return Placeholder_Trebuchet(better_trebuchet[1], better_trebuchet[2])
end

placeholder_imprecise_trebuchet = Placeholder_Trebuchet(500.0, 0.25pi)

placeholder_environment = Placeholder_Environment(5, 100)

placeholder_precise_trebuchet = placeholder_aim(placeholder_imprecise_trebuchet, placeholder_environment)

placeholder_shoot_distance(placeholder_precise_trebuchet, placeholder_environment)


