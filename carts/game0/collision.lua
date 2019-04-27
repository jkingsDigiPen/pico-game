-- Filename: collision.lua
-- Purpose: Collision Detection, Resolution
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2

local collision =
{
	-- for any given point on the map, true if there is a wall
	checkMapPoint = function(position)

		-- grab the cell value
		val = mget(position.x, position.y)

		-- check if flag 1 is set (the
		-- orange toggle button in the 
		-- sprite editor)
		return fget(val, 1)
	 
	end,

	-- check if a rectangle overlaps with any walls
	--(only works for objects less than one tile big)
	checkMapRect = function(position, extents)
		return 
			checkMapPoint(vec2Sub(position, extents)) or
			checkMapPoint(vec2(position.x + extents.x, position.y - extents.y)) or
			checkMapPoint(vec2(position.x - extents.x, position.y + extents.y)) or
			checkMapPoint(vec2Add(position, extents))
	end,

	-- true if go will hit another
	-- object after moving a specific amount
	checkObject = function(go1, moveAmount, go2)

		local diffStart = vec2Sub(go1.position, go2.position)
		local diffEnd = vec2Sub(vec2Add(go1.position, moveAmount), go2.position)
		local extSum = vec2Add(go1.extents, go2.extents)
		
		if ((abs(diffEnd.x) < extSum.x) and (abs(diffEnd.y) < extSum.y)) then
			local velSum = vec2Add(go1.velocity, go2.velocity)

			-- moving together?
			-- this allows actors to
			-- overlap initially 
			-- without sticking together    
			if (moveAmount.x != 0 and abs(diffEnd.x) < abs(diffStart.x)) then
				v = velSum.x
				go1.velocity.x = v / 2
				go2.velocity.x = v / 2
				return true 
			end

			if (moveAmount.y != 0 and abs(diffEnd.y) < abs(diffStart.y)) then
				v = velSum.y
				go1.velocity.y = v / 2
				go2.velocity.y = v / 2
				return true 
			end

		--return true
		end
		
		return false
	end,

	-- check collision against all other objects
	checkObjectList = function(go1, moveAmount, objects)
		for go2 in all(objects) do
			if (go2 != go1) then
				if checkObject(go1, moveAmount, go2) then
					return true
				end
			end
		end
		
		return false
	end,

	-- check map and object collisions
	checkAll = function(go, moveAmount, objects)
		if checkMapRect(vec2Add(go.position, moveAmount), go.extents) then
			return true 
		end
		
		return checkObjectList(go, moveAmount, objects)
	end,
}

return collision
