local pubUrlb1,pubUrlb2,btnValue
local jsonData = nil
local subUrl = "http://pubsub.pubnub.com/history/sub-c-f224d246-36bb-11e6-ac64-0619f8945a4f/ESPDash_Button/0/1"


function onClickBtnOne()
  if(jsonData ~= nil) then
    local pubNubString=string.gsub(jsonData,"\"btn_id_1\":0","\"btn_id_1\":1")
    pubUrlb1 = 'GET /publish/pub-c-11527e8a-5008-4b84-82e9-c7f224ccc3d8/sub-c-f224d246-36bb-11e6-ac64-0619f8945a4f/0/ESPDash_Button/0/'..pubNubString..' \r\n'
    indBtn = 7
    btnValue = 6
    btnPressed()
  else
    print("JSON data is null inside btn 1")
  end
end



function onClickBtnTwo()
  if(jsonData ~= nil) then
    local pubNubString=string.gsub(jsonData,"\"btn_id_2\":0","\"btn_id_2\":1")
    pubUrlb2 = 'GET /publish/pub-c-11527e8a-5008-4b84-82e9-c7f224ccc3d8/sub-c-f224d246-36bb-11e6-ac64-0619f8945a4f/0/ESPDash_Button/0/'..pubNubString..' \r\n'
    indBtn = 9
    btnValue = 2
    btnPressed()
  else
    print("JSON data is null inside btn 2")
  end
end

function btnPressed()
  gpio.trig(btnValue,"none")
  tmr.alarm(1,50,tmr.ALARM_SINGLE,function()
      gpio.trig(btnValue,"up",btnReleased)
    end)
  onButtonClick()
end

function btnReleased()
  gpio.trig(btnValue,"none")
  tmr.alarm(1,50,tmr.ALARM_SINGLE,function()
      gpio.trig(btnValue,"down",btnPressed)
    end)
end


function onButtonClick()
  if btnValue==6 then
    pubUrl = pubUrlb1
  elseif  btnValue==2 then
    pubUrl = pubUrlb2
  end
  local conn1=net.createConnection(net.TCP, 0)
  conn1:on("connection",
    function(conn1,payload)
      conn1:send(pubUrl)
      conn1:send('Host: pubsub.pubnub.com//\r\n') 
      conn1:send('Accept: */*\r\n') 
      conn1:send('User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n')
      conn1:send('\r\n')
    end)
  conn1:on("receive",function(conn1,payload) print(payload) end)
  conn1:on("disconnection",function(conn1,payload) conn1:close() print ("disconnected")end)
  conn1:connect(80,'54.241.191.241')
end

function subscribeCheck()
  http.get(subUrl, nil, function(code, data)
      tmr.delay(3000)
      if (code < 0) then
        print("HTTP request failed")
      else
        --print(data)
        jsonData = nil
        jsonData = string.match(data,'{.*}')
        print(jsonData)
        if(string.find(jsonData,'btn_id_1..1') ~= nil) then
          print("led One on")
          gpio.write(7,gpio.HIGH)
        else
          print("led one off")
          gpio.write(7,gpio.LOW)
        end
        if(string.find(jsonData,'btn_id_2..1') ~= nil) then
          print("led Two on")
          gpio.write(9,gpio.HIGH)
        else
          print("led two off")
          gpio.write(9,gpio.LOW)
        end
      end
    if btnValue ~= nil then
    gpio.trig(btnValue,"none")
    end
    btnValue=nil
    indBtn=nil
    btn_One =6
    ind_One = 7
    btn_Two =2
    ind_Two = 9

    gpio.trig(btn_One,"down",onClickBtnOne)
    gpio.trig(btn_Two,"down",onClickBtnTwo)
    end)

end
gpio.trig(btn_One,"down",onClickBtnOne)
gpio.trig(btn_Two,"down",onClickBtnTwo)

function timerCall()
  tmr.alarm(4,2000,1,function()
  subscribeCheck()
  end)
end
print("Step 1")
timerCall()

