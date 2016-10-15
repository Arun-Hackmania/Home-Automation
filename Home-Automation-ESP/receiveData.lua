function GetData()
gpio.mode(3,gpio.OUTPUT)
gpio.mode(5,gpio.OUTPUT)
  http.get("http://pubsub.pubnub.com/history/sub-c-f224d246-36bb-11e6-ac64-0619f8945a4f/RIngHackMania/0/1", nil, function(code, data)
      if (code < 0) then
        print("HTTP request failed")
      else
        jsonData = nil
        jsonData = string.match(data,'{.*}')     
        print(jsonData)
        if(string.find(jsonData,'id_1..1') ~= nil) then
        print("Success")
                   gpio.write(3,gpio.HIGH)
        else
          print("Failed")
          gpio.write(3,gpio.LOW)
        end
         if(string.find(jsonData,'id_2..1') ~= nil) then
        print("Success 2")
                   gpio.write(5,gpio.HIGH)
        else
          print("Failed 2")
          gpio.write(5,gpio.LOW)
        end
      end
    end)
end

-- every 5 seconds, check ThingSpeak
tmr.alarm(0, 1000, 1, function() GetData() end)
