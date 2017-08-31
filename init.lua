local myTemp = require("temp")
local myWifi = require("mywifi")
local httpTest = require("httptest")
local function myCallback() 
    print("STATION_GOT_IP") 
    print(wifi.sta.getip()) 
    --httpTest.testcall("Tim")
end

myWifi.setup(myCallback)
local timer = tmr.create()

timer:register(10000, tmr.ALARM_AUTO, myTemp.update)
timer:start()
