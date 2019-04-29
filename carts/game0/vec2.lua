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
	return vec2:new(self.x + v1.x, self.y + v1.y)
end

function vec2:minus(v1)
	return vec2:new(self.x - v1.x, self.y - v1.y)
end

function vec2:times(s)
	return vec2:new(self.x * s, self.y * s)
end

function vec2:negated()
	return vec2:new(-self.x, -self.y)
end

function vec2:dot(v1)
	return self.x * v1.x + self.y * v1.y
end
	
function vec2:lengthSquared()
	return self.x * self.x + self.y * self.y
end

function vec2:length()
	return sqrt(self:lengthSquared())
end

function vec2:distanceSquared(v1)
	return self:minus(v1):lengthSquared()
end

function vec2:distance(v1)
	return sqrt(self:distanceSquared(v1))
end

function vec2:normalized()
	local length = self:length()
	if length ~= 0 then
		return vec2:new(self.x / length, self.y / length)
	else
		return vec2:new(self.x, self.y)
	end
end
