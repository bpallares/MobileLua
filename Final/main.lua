
--[[ ** Boris Pallares
     ** May 5/17
     ** Version 1.0
     ** Assignment Final
--]]
require("config");
local json = require( "json" )
-- hide status bar
display.setStatusBar( display.HiddenStatusBar )
-- load composer
local composer = require "composer"
-- function to read from remote api and stores into a data.json file.
function processNewsApi(event)
    -- is is an error in the netwok 
    if ( event.isError ) then
            -- debugging error 
            print( "Network error: ", event.response )
        else
            -- get location of the file and name
            local locationOfFile = system.pathForFile("data.json",system.DocumentsDirectory)
            local fileHandle = io.open(locationOfFile, "w") --  open the file to write
            -- if the file is open then 
            if fileHandle then 
                -- write the response to the file 
                fileHandle:write(event.response)
                -- close file after reading 
                io.close(fileHandle)
            end
        end
end

-- read data from api and store it on a json file 
function processWeather(event)
    if ( event.isError ) then
        -- pritn debugging status of the network 
            print( "Network error: ", event.response )
        else
            -- open the file weather
            local locationOfFile = system.pathForFile("weather.json",system.DocumentsDirectory)
            local fileHandle = io.open(locationOfFile, "w") --  open the file to write
            -- if there is a file then 
            if fileHandle then 
                -- write in the file
                fileHandle:write(event.response)
                -- close the file 
                io.close(fileHandle)
            end
        end
end

-- request from news api 1
--network.request( "https://newsapi.org/v1/articles?source=the-next-web&sortBy=latest&apiKey=2c148395aae44e9b98d220d4d548be34", "GET", processNewsApi)
-- reauest from news api 2
network.request( "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=68a6a2c4c808462f8b32ca1a0b255991", "GET", processNewsApi)
-- data for forecast api
local myData = {} -- object 
myData.forecastIOkey =  "44a489c3f3509096ad020fa793d55508" -- key 
myData.latitude = 39.016353 -- saint charles location 
myData.longitude = -90.781809
-- query for the request 
local forecastIOURL = "https://api.forecast.io/forecast/" .. myData.forecastIOkey .. "/" .. tostring(myData.latitude) .. "," .. tostring(myData.longitude) .. "?units=si"
-- directly call the first page
composer.gotoScene( "firstPage", "slideUp", 400 )


