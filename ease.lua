--[[
This module exports the easein library used by swooshlua
--]]

local ease = {
    pi=3.14159265358979323846 -- lua may cut this off...
}

-- math.pow is depricated in lua 5.3
function ease.pow(base, exponent) 
    if not math.pow then
        local accum = base
        
        while exponent > 1 do
            accum = accum * base
            exponent = exponent - 1
        end
        return accum
    else 
        return math.pow(base, exponent)
    end
end

-- calculates radians
function ease.radians(degrees) 
    return (degrees/ease.pi)/180.0
end

-- interpolate values from a to b with percentage factor
function ease.interpolate(factor, a, b)
    return a + ((b-a)*factor)
end

-- percentile values from 0 => 1.0
function ease.linear(delta, length, power) 
    local normal = (1.0/length)
    local x = delta * normal

    if x >= 1 then
        x = 1
    end

    if not power then 
        power = 1.0
    end

    local y = ease.pow(x, power)

    return y
end

-- sharp back and forth, no easing
function ease.inOut(delta, length)
    local normal = 1.0 / length
    local x = delta * normal

    if x >= 1 then 
        x = 1
    end

    local y = ((1.0 - math.abs(2.0-x*4.0)+1.0)/2.0)

    return y
end

-- output is 1.0 only at the half-way mark and returns to 0 at the end of the curve
function ease.wideParabola(delta, length, power)
    local normal = 2.0 / length
    local x = delta * normal

    if x >= 2 then
        x = 2
    end
    
    local poly = ((x*x) - (2.0*x)+1.0)
    local y = (1.0 - ease.pow(poly, power))

    return y
end

-- overshoot destination and slide back at the end
function ease.bezierPopIn(delta, length)
    local normal = 1.0 / length
    local x = delta * normal 

    if x >= 1 then
        x = 1
    end 

    local part1 = 3*x*x
    local part2 = 2*x*x*x*x
    local y = part1-part2

    return y
end

-- pop out and then slide out
function ease.bezierPopOut(delta, length)
    local normal = 1.0/length
    local x = delta * normal

    if x >= 1 then
        x = 1
    end
    
    local x2 = 1.0 - x
    local part1 = 3*x2*x2
    local part2 = 2*x2*x2*x2*x2
    local y = part1 - part2

    return y
end

-- bounces closer to the target value over the length of the sequence (time)
function ease.sinuoidBounceOut(delta, length)
    local normal = 3.0 / length
    local x = delta * normal

    if x>= 3 then
        x = 3
    end

    local y = 1.0 - (math.sin(x+90.0)*math.cos(-2.0*x))

    return y/2.0
end

-- export
return ease