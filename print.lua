local M = {}
--local myTemp = require("temp")

-- Variables
sda = 1 -- SDA Pin
scl = 2 -- SCL Pin
test1 =""
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

local function print_OLED()
   disp:firstPage()
   repeat
     disp:drawFrame(2,2,126,62)
     disp:drawStr(5, 10, str1)
     disp:drawStr(5, 20,"a" )
     disp:drawCircle(18, 47, 14)
   until disp:nextPage() == false

end


local function print_Repeat(temp)
   str1 = temp
   print_OLED()

end


-- Main Program
str1= ""
--str2=""
init_OLED(sda,scl)
print_OLED()

M.print_OLED = print_OLED
M.print_Repeat = print_Repeat
