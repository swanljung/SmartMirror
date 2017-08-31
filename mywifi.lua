local M = {}

local function setup(callback)
    print("setting up wifi")
    wifi.setmode(wifi.STATION)
    wifi.sta.eventMonReg(wifi.STA_IDLE, function() print("STATION_IDLE") end)
    wifi.sta.eventMonReg(wifi.STA_CONNECTING, function() print("STATION_CONNECTING") end)
    wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function() print("STATION_WRONG_PASSWORD") end)
    wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function() print("STATION_NO_AP_FOUND") end)
    wifi.sta.eventMonReg(wifi.STA_FAIL, function() print("STATION_CONNECT_FAIL") end)
    wifi.sta.eventMonReg(wifi.STA_GOTIP, callback)
    wifi.sta.eventMonStart()



    station_cfg={}
    station_cfg.ssid="WifiName"
    station_cfg.pwd="WifiPassword"
    wifi.sta.config(station_cfg)
end

M.setup = setup
return M
