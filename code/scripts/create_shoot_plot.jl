using MelissasModule
using Plots

environment = Environment(5, 100)

function create_shoot_plot(gridlength = 10; weight_values::Tuple{Float64, Float64}=(100.0, 500.0), angle_values=(pi/10, pi/3),  environment = environment)
    weights = range(weight_values[1], weight_values[2], length=gridlength)
    angles  = range(angle_values[1], angle_values[2],  length=gridlength)
    distances = [shoot_distance(Trebuchet(weight, angle), environment) for (angle, weight) in Iterators.product(angles, weights)]
    surface(weights, angles, distances)
end
