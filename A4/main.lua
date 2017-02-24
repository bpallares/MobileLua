--[[ ** Boris Pallares
     ** 2/24/2017
     ** Version 1.0
     ** Assignment #4
--]]
-- disable the status bar
display.setStatusBar( display.HiddenStatusBar )
-- add composer
local composer = require "composer"
-- background
local background = display.newImage("blurredback.jpg")
background.x = display.contentWidth/2
background.y = display.contentHeight/2
background.width =  2000
background.height = 2000
--container1
--local container = display.newRect(display.contentWidth/2,display.contentHeight/2,700,950)
--container.alpha = 0.2
-- add Welcome message
local welcome = display.newText("Welcome", display.contentWidth/2,display.contentHeight/2 -300,"Verdana",80)
-- add message
local message = display.newText("",display.contentWidth/2,display.contentHeight/2 -100,"Verdana",28)
message.text = "Welcome to the app of the future. \n" ..
                "Please, login to post apartments for rent,\n"..
                "or press search to find you next home! \n"..
                "\nfor more details access our website: \n"..
                "www.blablabla.com. \n"..
                "Thanks for downloading our app"
-- add 2 buttons
local buttonSearch = display.newRoundedRect(display.contentWidth/2,display.contentHeight-500,400,80,40)
local buttonLogin = display.newRoundedRect(display.contentWidth/2,display.contentHeight-400,400,80,40)
-- colors -- stroke
buttonSearch.fill= none
buttonSearch.strokeWidth = 2
buttonLogin:setFillColor(0.14,0.67,0.37)
-- Text on top of the buttons
local textSearch = display.newText("Search", display.contentWidth/2,display.contentHeight -500,"Verdana",25)
local textLogin = display.newText("Login", display.contentWidth/2,display.contentHeight -400,"Verdana",25)
local textRegister= display.newText("Register", display.contentWidth/2-60,display.contentHeight -340,"Verdana",20)
-- block separating register and password ( Register | Password)
local textSeparator= display.newText("|", display.contentWidth/2,display.contentHeight -340,"Verdana",20)
local textForgot= display.newText("Password", display.contentWidth/2+60,display.contentHeight -340,"Verdana",20)
----------------------------------------------------------------
