-- Filename: manager.lua
-- Purpose: Manage objects
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- gameObjectMove, gameObjectDraw
physics = require("physics") -- update

local manager = {}

-- Array of all objects in world
manager.objects = {}

function manager.add(go)
	add(manager.objects, go)
end

function manager.update()
	foreach(manager.objects, gameObject.update)
	physics.update(manager.objects)
end

function manager.draw()
	foreach(manager.objects, gameObject.draw)
end

return manager
