function GetData()
    http.get("http://pubsub.pubnub.com/history/sub-c-f224d246-36bb-11e6-ac64-0619f8945a4f/RIngHackMania/0/1", nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print("Voltage = " .. data .. " V")
    end
  end)
end

-- every 5 seconds, check ThingSpeak
tmr.alarm(0, 1000, 1, function() GetData() end)