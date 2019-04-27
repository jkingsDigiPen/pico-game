-- Filename: manager.lua
-- Purpose: Manage objects
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- gameObjectMove, gameObjectDraw

local manager =
{
	-- Array of all objects in world
	objects = {},

	update = function()
		for go in all(objects) do
			gameObjectUpdate(go, objects)
		end
	end,

	draw = function()
		foreach(objects, gameObjectDraw)
	end,
}

return manager
