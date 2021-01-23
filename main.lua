#!/usr/bin/lua5.1

ease = require "ease"

-- print test results
print(ease.pi)
print(ease.radians(ease.pi*2))
print(ease.interpolate(0.5, 10, 20))
print(ease.linear(5, 10, 2))
print(ease.inOut(5, 10))
print(ease.wideParabola(5, 10, 1))
print(ease.bezierPopIn(5, 10))
print(ease.bezierPopOut(5, 10))
print(ease.sinuoidBounceOut(10, 10))

-- finished tests
print("Done")