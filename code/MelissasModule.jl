module MelissasModule
import Trebuchet as Trebuchets
using ForwardDiff: gradient

export aim, shoot_distance, Trebuchet, Environment

mutable struct Trebuchet{T} <: AbstractVector{T}
  counterweight::T
  release_angle::T
end
Base.copy(trebuchet::Trebuchet) = Trebuchet(trebuchet.counterweight, trebuchet.release_angle)
Base.size(trebuchet::Trebuchet) = tuple(2)
Base.getindex(trebuchet::Trebuchet, i::Int) = getfield(trebuchet, i)
function Base.setindex!(trebuchet::Trebuchet, v, i::Int)
    if i === 1
        trebuchet.counterweight = v
    elseif i === 2
        trebuchet.release_angle = v
    else
        error("Trebuchet only accepts indices 1 and 2, yours is $i")
    end
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
function shoot_distance(trebuchet::Trebuchet, env::Environment)
    shoot_distance(env.wind, trebuchet.release_angle, trebuchet.counterweight)
end

function aim(trebuchet::Trebuchet, environment::Environment; ε = 1e-1, η = 0.05)
    better_trebuchet = copy(trebuchet)
    hit = x -> (shoot_distance([environment.wind, x[2], x[1]]) - environment.target_distance)
    while abs(hit(better_trebuchet)) > ε
        grad = gradient(hit, better_trebuchet)
        better_trebuchet -= η * grad
    end
    return Trebuchet(better_trebuchet[1], better_trebuchet[2])
end
end # MelissasModule

