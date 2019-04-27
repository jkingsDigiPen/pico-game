-- Filename: vec2.lua
-- Purpose: 2D vector functions
-- Author: Jeremy Kings

-- Dependencies
-- require("")

-- Constructor
-- Params:
--  x,y - x and y of vector
function vec2(x, y)
	v = {}
	v.x = x
	v.y = y
	return v
end

-- Operators
function vec2Add(v0, v1)
	vr = vec2(0,0)
	vr.x = v0.x + v1.x
	vr.y = v0.y + v1.y
	return vr
end

function vec2Sub(v0, v1)
	vr = vec2(0,0)
	vr.x = v0.x - v1.x
	vr.y = v0.y - v1.y
	return vr
end

function vec2Scale(v, s)
	vr = vec2(0,0)
	vr.x = v.x * s
	vr.y = v.y * s
	return vr
end

function vec2Dot(v0, v1)
	fr = 0.0
	fr = v0.x * v1.x + v0.y * v1.y
	return fr
end
	
function vec2LenSq(v)
	fr = 0.0
	fr = v.x * v.x + v.y * v.y
	return fr
end

function vec2Len(v)
	return sqrt(vec2LenSq(v))
end

function vec2DistSq(v0,v1)
	return vec2LenSq(vec2Sub(v0,v1))
end

function vec2Dist(v0,v1)
	return sqrt(vec2DistSq(v0,v1))
end
