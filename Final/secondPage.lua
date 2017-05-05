
local composer = require( "composer" )
local json = require( "json" )
local scene = composer.newScene()
local widget = require( "widget" )
local http=require'socket.http'



function scene:create( event )
   local sceneGroup = self.view
   local composer = require "composer"
   -- create navbar
   local navbar = display.newRect(display.contentWidth/2,50,display.contentWidth,199)
   navbar:setFillColor(0.075,0.19,0.32)
   -- create container for logo 
   local logoContainer =  display.newRect(50,100,200,200)
   logoContainer:setFillColor(0.20,0.24,0.43)
   -- create logo 
   local logo = display.newText("N",70,110,"Times New Roman",100)
   logo:setFillColor(1,1,1)
   -- get the parameters from the previous scene 
   local difficulty = event.params.news
   local widget = require( "widget" )
   --store url
   local url
   local cWeather

    -- locate the file to be read
    local locationOfFile = system.pathForFile("weather.json",system.DocumentDirectory)
    local fileHandle = io.open(locationOfFile, "r") --  open the file to read

    -- if the file has been found and is ioen 
     if fileHandle then 
        -- decode the file to be read
        local process = json.decode(fileHandle:read("*a"))
          -- read the summary of the current weather and print it with the temperature
          cWeather = display.newText("Current Weather: "..process.currently.summary.." and "..math.floor(process.currently.temperature).." C°",display.contentWidth/2,100,"Verdana",35)
     end
 
    -- Create the widget
    local scrollView = widget.newScrollView(
        {
            top =150,
            left = 0,
            width = display.contentWidth,
            height = display.contentHeight,
            scrollWidth = 600,
            scrollHeight = 800,
            listener = scrollListener
        }
    )
 
    -- get the path of the file
    local locationOfFile = system.pathForFile("data.json",system.DocumentDirectory)
    local fileHandle = io.open(locationOfFile, "r") --  open the file to read
    -- if there is a file open 
    if fileHandle then 
    -- decode the file to be read
    local process = json.decode(fileHandle:read("*a"))
        -- put fow the multimedia 
        local count=1;
            for k,v in pairs(process.results[difficulty].multimedia) do

                if count ==1 then
                    xWidth =  scrollView.contentWidth/2 
                    yHeight = 470
                else
                    xWidth = scrollView.contentWidth/2
                    yHeight = 900 * count+20
                end
                
                -- load images from the file AND remotely from the url 
                image = display.loadRemoteImage( process.results[difficulty].multimedia[4].url, "GET", 
                function( event )
                        if ( event.isError ) then
                            print ( "Network error - download failed" )
                        else
                            event.target.alpha = 0
                            transition.to( event.target, { alpha = 1.0 } )
                            scrollView:insert(event.target)
                             event.target.width =2048/2
                            event.target.height =1365/2
                        end

                    end
                
                , "image"..count..".png", system.TemporaryDirectory, xWidth,yHeight )


                break
            end
            
            -- display the title of the news 
            local title = display.newText( process.results[difficulty].title,scrollView.contentWidth/2,scrollView.contentHeight/2+70,scrollView.contentWidth-100,0,"Times New Roman",80)
            title:setFillColor(0,0,0)
            -- display content of the news 
            local content = display.newText( process.results[difficulty].abstract,scrollView.contentWidth/2,scrollView.contentHeight/2+400,scrollView.contentWidth-100,0,"Times New Roman",60)
            content:setFillColor(0,0,0)
            --author
            local author = display.newText( process.results[difficulty].byline,scrollView.contentWidth/2,scrollView.contentHeight/2+250,scrollView.contentWidth-100,0,"Times New Roman",45)
            author:setFillColor(0,0,0)
            -- organize the content accordingly to what is there already 
            content.y = content.contentHeight/2  + content.y -50
            -- organize the seemore Y
            seeMore =  content.y + content.contentHeight/2 +70
            -- create the seemore 
            local imageArrow = display.newImage("arrow.png",60,seeMore)
            local seeMoreLink = display.newText( "Read More",scrollView.contentWidth/2+50,seeMore,scrollView.contentWidth-100,0,"Times New Roman",60)
            seeMoreLink:setFillColor(0,0,0)
            -- insert to scrollview 
            url = process.results[difficulty].url
            scrollView:insert(imageArrow)
            scrollView:insert(seeMoreLink)
            scrollView:insert(author)
            scrollView:insert(title)
            scrollView:insert(content)
            seeMoreLink:addEventListener("tap", function(event)
                system.openURL( url  )
            end
            )


    end

     sceneGroup:insert(navbar)
     sceneGroup:insert(scrollView)
     sceneGroup:insert(cWeather)
     sceneGroup:insert(logoContainer)
     sceneGroup:insert(logo)

     -- if clicked on logo then go back 
      logoContainer:addEventListener("tap", function(event) 
        composer.gotoScene( "firstPage", "slideRight", 400) 
        composer.removeScene( "secondPage", true )

        end 
    )
    

end

function scene:show( event )

	local phase = event.phase

	if "did" == phase then

    
	end

end

function scene:hide( event )

	local phase = event.phase
	if "will" == phase then
	end
end

function scene:destroy( event )

	print( "((destroying scene 2's view))" )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
