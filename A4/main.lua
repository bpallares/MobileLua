
--[[ ** Boris Pallares
     ** 2/27/2017
     ** Version 1.0
     ** Assignment #5
--]]
-- hide status bar
display.setStatusBar( display.HiddenStatusBar )
-- load composer
local composer = require "composer"
-- directly call the first page
composer.gotoScene( "firstPage", "fade", 400 )
