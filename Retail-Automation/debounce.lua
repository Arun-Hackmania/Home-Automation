local button_1 = 6
local debounceDelay
local debounceAlarmId
gpio.mode(button_1, gpio.INT, gpio.PULLUP)


function doorLocked()
    -- don't react to any interupts from now on and wait 50ms until the interrupt for the up event is enabled
    -- within that 50ms the switch may bounce to its heart's content
    gpio.trig(button_1, "none")
    tmr.alarm(1, 10, tmr.ALARM_SINGLE, function()
        gpio.trig(button_1, "up", doorUnlocked)
    end)
    print("Door Locked")
end

function doorUnlocked()
    -- don't react to any interupts from now on and wait 50ms until the interrupt for the down event is enabled
    -- within that 50ms the switch may bounce to its heart's content
    gpio.trig(button_1, "none")
    tmr.alarm(1, 10, tmr.ALARM_SINGLE, function()
        gpio.trig(button_1, "down", doorLocked)
    end)
    --print("Door Unlocked")
end

gpio.trig(button_1, "down", doorLocked))
