
local composer = require( "composer" )
-- require json library 
local json = require( "json" )
local scene = composer.newScene()
local widget = require( "widget" )

-- function that creates scenes
function scene:create( event )
   local sceneGroup = self.view
   local composer = require "composer"
   -- create navbar and set color
   local navbar = display.newRect(display.contentWidth/2,50,display.contentWidth,199)
   navbar:setFillColor(0.075,0.19,0.32)
   -- logo container 
   local logoContainer =  display.newRect(50,100,200,200)
   logoContainer:setFillColor(0.20,0.24,0.43)
   -- actual logo 
   local logo = display.newText("N",70,110,"Times New Roman",100)
   logo:setFillColor(1,1,1)
   -- variables just in case there is an alert in the area -> for the ( weather api)
   local alerts
   local cWeather
   local alertBox
    -- locate the file to be read
    local locationOfFile = system.pathForFile("weather.json",system.DocumentDirectory)
    local fileHandle = io.open(locationOfFile, "r") --  open the file to read

    -- if the file has been found and is ioen 
     if fileHandle then 
        -- decode the file to be read
        local process = json.decode(fileHandle:read("*a"))
          -- read the summary of the current weather and print it with the temperature
          cWeather = display.newText("Current Weather: "..process.currently.summary.." and "..math.floor(process.currently.temperature).." C°",display.contentWidth/2,100,"Verdana",35)
          -- for any alert that there is (if any then)
          for k,v in pairs(process.alerts) do
            -- generate the box for the alert
            alertBox = display.newRect(display.contentWidth/2,173,display.contentWidth,50)
            alertBox:setFillColor(1,0,0)
            
            -- options for the alert message 
            options = {
                    -- the follow line adds the text without \n , which comes by default from the api
                    text = string.gsub(process.alerts[k].description, "\n"," "),
                    x = display.contentWidth/2,
                    y =173,
                    font = "Verdana",
                    fontSize = 35
                }
            -- set the alert message, with color, location and transition
            alerts = display.newText(options)
            alerts:setFillColor(1,1,1)
            alerts.x = alerts.contentWidth/2+display.contentWidth
            transition.to( alerts, { time=99000, x=-5000, onComplete=function(event) alerts.text=""  transition.to( alertBox, { time=1000, alpha=0}) end })
            break

          end


     end

   local function onRowRender( event )
        -- get rows
        local row = event.row
        local rowHeight = row.contentHeight
        local rowWidth = row.contentWidth
     
        -- read the file 
        local locationOfFile = system.pathForFile("data.json",system.DocumentDirectory)
        local fileHandle = io.open(locationOfFile, "r") --  open the file to read

        -- if there is a file 
        if fileHandle then 
            -- decode and read the file 
            local process = json.decode(fileHandle:read("*a"))      
            local iHeight
            -- if it is the first news then is featured, meaning that is bigger.
           if row.index == 1 then 
            yPos = rowHeight/2
            xPos = rowWidth/2
            -- if is the second row then make an  psace for "Today"
           elseif row.index ==2 then 
            yPos = rowHeight/2
            xPos = 0 + 150
            -- separator rectangle / line
            separator = display.newRect(row,rowWidth/2,rowHeight, rowWidth/2+500,2)
            separator:setFillColor(0.91,0.91,0.91)
            separator:toFront()
            -- display the message Today 
            todayMsg = display.newText(row,"TODAY",90,50,"Arial",40)
            todayMsg:setFillColor(0.61,0.61,0.61)
            -- separator below message 
            separator2 = display.newRect(row,rowWidth/2,100, rowWidth/2+500,2)
            separator2:setFillColor(0.91,0.91,0.91)
            separator2:toFront()

            -- title of the news that is being parsed
            local message = display.newText(row,"",rowWidth/2+150,200,650,0,"Times New Roman",55)
            message.text = process.results[row.index].title
            message:setFillColor(0,0,0)
            -- author of the news
            local byAuthor = display.newText(row,"",rowWidth/2+150,rowHeight/2+100,650,0,"Times New Roman",50)
            byAuthor.text = "By: "..process.results[row.index].byline
            byAuthor:setFillColor(0.61,0.61,0.61)
            -- date published
            local date = display.newText(row,"",rowWidth/2+150,rowHeight-20,650,0,"Times New Roman",25)
             date.text = process.results[row.index].published_date
            date:setFillColor(0.61,0.61,0.61)

           else -- if it is anything else then 

            yPos = rowHeight/2
            xPos = 0 + 150
            -- make a separator 
            separator = display.newRect(row,rowWidth/2,rowHeight, rowWidth/2+500,2)
            separator:setFillColor(0.91,0.91,0.91)
            separator:toFront()
            -- news title 
            local message = display.newText(row,"",rowWidth/2+150,140,650,0,"Times New Roman",55)
            message.text = process.results[row.index].title
            message:setFillColor(0,0,0)
            -- author
            local byAuthor = display.newText(row,"",rowWidth/2+150,rowHeight/2+100,650,0,"Times New Roman",50)
            byAuthor.text = process.results[row.index].byline
            byAuthor:setFillColor(0.61,0.61,0.61)
            -- date 
            local date = display.newText(row,"",rowWidth/2+150,rowHeight-20,650,0,"Times New Roman",25)
            date.text = process.results[row.index].published_date
            date:setFillColor(0.61,0.61,0.61)

           end
           
            -- load the HD images from the file              
                 local imag = display.loadRemoteImage( process.results[row.index].multimedia[4].url, "GET",    
                        function(lri_event)
                        --Check if row is in bounds by looking for existence of _proxy
                            if(event.row._proxy ) then
                                if(lri_event.isError) then
                                print("----error loading photo")
                                else
                                --image is saved in lri_event.target
                                event.row:insert(lri_event.target)
                                end
                            else
                                --Do not add image to row, it is out of bounds
                                display.remove(lri_event.target)
                            end
                            -- event.target.alpha = 0
                            -- transition.to( event.target, { alpha = 1.0 } )
                            if row.index == 1 then
                             lri_event.target.height =display.contentHeight/2+1360/18
                             lri_event.target.width = display.contentHeight/2+2600/18
                             --lri_event.target:scale(0.5,0.5)
                            else
                             lri_event.target.height = 250
                             lri_event.target.width = 250
                            end

                        end,
                        "corona"..row.index..".png", system.TemporaryDirectory,xPos, yPos
                    )
                    
            -- close the file being read
            io.close()
        end

         
    end

    local function onRowTouch(event) 
       if event.phase == 'tap' then
       -- pass the index of the row being pressed to the next Scene
          local options = {  params = { news = event.target.index } }
          composer.gotoScene( "secondPage",options, "slideLeft", 400 )
       end
    end
 

    -- Create the tableview widget
    local tableView = widget.newTableView(
        {
            x = display.contentWidth/2, -- middle axis
            y = display.contentHeight/2+150, 
            height = display.contentHeight,
            width = display.contentWidth,
            onRowRender = onRowRender,
            onRowTouch = onRowTouch,
            listener = scrollListener,
            scrollBarOptions = {
                sheet = scrollBarSheet,
                topFrame = 1,
                middleFrame = 2,
                bottomFrame = 3
            },
            noLines= true
        }
    )


    -- Insert 6 rows
    for i = 1, 10 do
        -- Insert a row into the tableView
        if i == 1 then 
            tableView:insertRow(
                {
                    isCategory = false,
                    rowHeight = 900,
                    rowColor = { default={0.251,0.267,0.322}, over={1,0.5,0,0.2} },
                 }
            )
        elseif i == 2 then 
            tableView:insertRow(
                {
                    isCategory = false,
                    rowHeight = 550,
                    rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
                 }
            )
        else 
            tableView:insertRow(
                    {
                        isCategory = false,
                        rowHeight = 400,
                        rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
                     }
                )
        end 
    end
    -- insert into the group
    sceneGroup:insert(navbar)
    sceneGroup:insert(tableView)
    sceneGroup:insert(alertBox)
    sceneGroup:insert(alerts)
    sceneGroup:insert(logoContainer)
    sceneGroup:insert(logo)
    sceneGroup:insert(cWeather)

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
