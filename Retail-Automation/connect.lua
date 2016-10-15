gpio.mode(4,gpio.OUTPUT)
wifi.setmode(wifi.STATION)
wifi.sta.config("Arunmozhi","q1w2e3r4")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
if wifi.sta.getip()== nil then print("WiFi not connected") 
else tmr.stop(1) tmr.stop(6) gpio.write(4,gpio.HIGH) print("Connection done, IP is "..wifi.sta.getip())
end end)

dofile("One_btn.lua")

