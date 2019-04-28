-- Filename: manager.lua
-- Purpose: Manage objects
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- gameObjectMove, gameObjectDraw

local manager = {}

-- Array of all objects in world
manager.objects = {}

function manager.add(go)
	add(manager.objects, go)
end

function manager.update()
	for go in all(manager.objects) do
		gameObject.Update(go, manager.objects)
	end
end

function manager.draw()
	foreach(manager.objects, gameObject.Draw)
end

return manager
