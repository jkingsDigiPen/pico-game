-- Filename: input.lua
-- Purpose: Define inputs
-- Author: Jeremy Kings

-- Dependencies
--require("")

-- Consts
local input = {}

input.keyCodes =
{
	left = 0,
	right = 1,
	up = 2,
	down = 3,
	action1 = 4,
	action2 = 5,
}

input.keyStates = {}

function input.isHeld(k) return band(input.keyStates[k], 1) == 1 end
function input.isPressed(k) return band(input.keyStates[k], 2) == 2 end
function input.isReleased(k) return band(input.keyStates[k], 4) == 4 end

function input.updateKey(k)
    if input.keyStates[k] == 0 then
        if btn(k) then input.keyStates[k] = 3 end
    elseif input.keyStates[k] == 1 then
        if btn(k) == false then input.keyStates[k] = 4 end
    elseif input.keyStates[k] == 3 then
        if btn(k) then input.keyStates[k] = 1
        else input.keyStates[k] = 4 end
    elseif input.keyStates[k] == 4 then
        if btn(k) then input.keyStates[k] = 3
        else input.keyStates[k] = 0 end
    end
end

function input.update()
	for i = 0,5 do input.updateKey(i) end
end

function input.init()
	for i = 0,5 do input.keyStates[i] = 0 end
end

return input
