--[[ Physics project in lua
     By Boris Pallares
     February 11/17
     Apps For mobile devices class ]]

-- load physics
local physicsEnvironment = require "physics"
physicsEnvironment.start()
physics.setDrawMode( "normal" )  --the default Corona renderer, with no collision outlines
-- gravity
physics.setGravity( 0, 0 )

 -- get rid of the status bar
display.setStatusBar( display.HiddenStatusBar )


-- add a round body to the screen
local mainPlayer = display.newCircle(display.contentWidth/2,display.contentHeight/2,50)
-- red color
mainPlayer:setFillColor(1,0,0)
-- add body to physicsEnvironment
physicsEnvironment.addBody(mainPlayer, "kinematic", {bounce = 0, friction = 0,
                                    density = 0, radius = 50})

function moveBall(event)
transition.to(mainPlayer,{time=3000,x= event.x, y= event.y})
end

-- on tap move the ball up --
Runtime:addEventListener("tap",moveBall)
