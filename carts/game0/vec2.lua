-- Filename: vec2.lua
-- Purpose: 2D vector functions
-- Author: Jeremy Kings

-- Dependencies
-- require("")

-- Class definition
vec2 =
{
	x = 0,
	y = 0,
}

-- Constructor
function vec2:new(x, y)
	v = {}
	setmetatable(v, self)
	self.__index = self
	v.x = x
	v.y = y
	return v
end

-- Operators
function vec2:plus(v1)
	vr = vec2:new(0,0)
	vr.x = self.x + v1.x
	vr.y = self.y + v1.y
	return vr
end

function vec2:minus(v1)
	vr = vec2:new(0,0)
	vr.x = self.x - v1.x
	vr.y = self.y - v1.y
	return vr
end

function vec2:times(s)
	vr = vec2:new(0,0)
	vr.x = self.x * s
	vr.y = self.y * s
	return vr
end

function vec2:dot(v1)
	return self.x * v1.x + self.y * v1.y
end
	
function vec2:lenSq()
	return self.x * self.x + self.y * self.y
end

function vec2:len()
	return sqrt(self:lenSq())
end

function vec2:distSq(v1)
	return self:lenSq(self:sub(v1))
end

function vec2:dist(v1)
	return sqrt(self:distSq(v1))
end
