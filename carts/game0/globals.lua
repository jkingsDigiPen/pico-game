-- Filename: globals.lua
-- Purpose: Define globals
-- Author: Jeremy Kings

-- Dependencies
--require("")

-- Consts
local globals = {}

-- Viewport/screen
globals.pixelsPerUnit = 8 -- Pixels per unit
globals.viewportWidth = 128 -- Viewport width in pixels

-- Colors
globals.colors =
{
	black = 0,
	blueDark = 1,
	purpleDark = 2,
	greenDark = 3,
	brown = 4,
	grayDark = 5,
	grayLight = 6,
	white = 7,
	red = 8,
	orange = 9,
	yellow = 10,
	green = 11,
	blue = 12,
	purpleLight = 13,
	pink = 14,
	peach = 15,
}

-- Map
globals.map =
{
	width = 32, -- Map width in units
	height = 16, -- Map height in units
	offsetX = 0, -- Offset of map upper-left in units
	offsetY = 16, -- Offset of map upper-left in units
}

-- Sprites
globals.sprites =
{
	player = 17,
	cursor = 70,
	fireball = 53,
	lightning = 0,
	goblin = 0,
	imp = 0,
}

-- Objects
globals.objectTypes =
{
	player = 1,
	fireball = 2,
	lightning = 3,
	goblin = 4,
	imp = 5,
}

return globals
