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

-- Map
globals.mapWidth = 32 -- Map width in units
globals.mapHeight = 16 -- Map height in units
globals.mapOffsetX = 0 -- Offset of map upper-left in units
globals.mapOffsetY = 16 -- Offset of map upper-left in units

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

return globals
