# This file was generated, do not modify it. # hide
#hideall
function koch(order, scale=10)
    if iszero(order)
        angles = @. ([0, 120, 240] + 90) * pi/180
        return @. scale / sqrt(3) * exp(angles * 1im)
    end
    ZR = 0.5 - 0.5im * sqrt(3)/3
    p1 = koch(order - 1)
    p2 = [p1[2:end]..., p1[1]]
    dp = p2 .- p1

    new_points = zeros(ComplexF64, length(p1) * 4)
    new_points[1:4:end] .= p1
    new_points[2:4:end] .= @. p1 + dp / 3
    new_points[3:4:end] .= @. p1 + dp * ZR
    new_points[4:4:end] .= @. p1 + dp / 3 * 2
    return new_points
end

function koch_plot(order, scale=10)
    points = koch(order, scale)
    x, y = real.(points), imag.(points)
    figure(figsize=(8,8))
    axis("equal")
    fill(x, y)
end

koch_plot(5)

savefig(joinpath(@OUTPUT, "koch.svg")) # hide