local M = {}

local sda = 1 -- SDA Pin
local scl = 2 -- SCL Pin
local pin = 4

local function init_OLED(sda,scl) --Set up the u8glib lib
                 sla = 0x3C
                 i2c.setup(0, sda, scl, i2c.SLOW)
                 disp = u8g.ssd1306_128x64_i2c(sla)
                 disp:setFont(u8g.font_6x10)
                 disp:setFontRefHeightExtendedText()
                 disp:setDefaultForegroundColor()
                 disp:setFontPosTop()
                 --disp:setRot180()           -- Rotate Display if needed
end
init_OLED(sda,scl)

local function update()
        status, temp, humi, temp_dec, humi_dec = dht.read(pin)
        if status == dht.OK then
            disp:firstPage()
               repeat
                 disp:drawFrame(2,2,126,62)
                 disp:drawStr(5, 10, "Current Temperature" )
                 disp:drawStr(5, 20, "And Humidity.." )
                 disp:drawStr(5, 30,"Temp: "..temp.."°C")
                 disp:drawStr(5, 40,"Humidity: "..humi.."%" )
                 --disp:drawCircle(18, 47, 14)
               until disp:nextPage() == false
             print("DHT Temperature:"..temp..";".."Humidity:"..humi)
              elseif status == dht.ERROR_CHECKSUM then
              disp:firstPage()
               repeat
                 disp:drawFrame(2,2,126,62)
                 disp:drawStr(5, 10, "DHT Checksum" )
                 disp:drawStr(5, 20, "error" )
                 --disp:drawCircle(18, 47, 14)
               until disp:nextPage() == false
            print( "DHT Checksum error." )
        elseif status == dht.ERROR_TIMEOUT then
            disp:firstPage()
               repeat
                 disp:drawFrame(2,2,126,62)
                 disp:drawStr(5, 10, "DHT" )
                 disp:drawStr(5, 20, "timed out." )
                 --disp:drawCircle(18, 47, 14)
               until disp:nextPage() == false
            print( "DHT timed out." )
        end
end

local function getTemp()
        status, temp, humi, temp_dec, humi_dec = dht.read(pin)
        if status == dht.OK then
              return temp
              elseif status == dht.ERROR_CHECKSUM then
            print( "DHT Checksum error." )
        elseif status == dht.ERROR_TIMEOUT then
            print( "DHT timed out." )
        end
end

M.update = update
M.getTemp = getTemp
return M
