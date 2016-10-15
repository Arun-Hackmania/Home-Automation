btn_One = 6
ind_One=7

gpio.mode(btn_One,gpio.INT,gpio.PULLUP)
gpio.mode(ind_One,gpio.OUTPUT)

tmr.alarm(6,5000,tmr.ALARM_SINGLE,function()
      dofile("connect.lua")
    end)
