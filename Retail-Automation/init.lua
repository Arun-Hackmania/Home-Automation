btn_One = 6
ind_One=7

btn_Two = 2
ind_Two = 9

gpio.mode(btn_One,gpio.INT,gpio.PULLUP)
gpio.mode(ind_One,gpio.OUTPUT)
gpio.mode(btn_Two,gpio.INT,gpio.PULLUP)
gpio.mode(ind_Two,gpio.OUTPUT)


tmr.alarm(6,5000,tmr.ALARM_SINGLE,function()
      dofile("connect.lua")
    end)
