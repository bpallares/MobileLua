--[[ Physics project in lua
     By Boris Pallares
     February 11/17
     Apps For mobile devices class ]]

-- load physics
local physicsEnvironment = require "physics"
physicsEnvironment.start()
physics.setDrawMode( "hybrid" )  --the default Corona renderer, with no collision outlines
physics.setGravity( 0, 9.8 ) -- gravity
display.setStatusBar( display.HiddenStatusBar )  -- get rid of the status bar

-- Add a round body to the screen
local mainPlayer = display.newCircle(200,display.contentHeight-500,35)
-- Red color
mainPlayer:setFillColor(1,0,0)
-- add body to physicsEnvironment
physicsEnvironment.addBody(mainPlayer, { density=0.15, friction=1.0, bounce=.9, radius=35 })
-- Add wall around the scene
local wallGroup = display.newGroup()
local wallTop = display.newRect(display.contentWidth/2,0,display.contentWidth,5)
wallGroup:insert( wallTop )
local wallBotton = display.newRect(display.contentWidth/2,display.contentHeight,display.contentWidth,5)
wallGroup:insert( wallBotton )
local wallLeft = display.newRect(0,display.contentHeight/2,5,display.contentHeight)
wallGroup:insert( wallLeft )
local wallRight = display.newRect(display.contentWidth,display.contentHeight/2,5,display.contentHeight)
wallGroup:insert( wallRight )
-- table creation
local table1 = display.newRect(200,display.contentHeight-170,100,325)
physics.addBody(table1,"static")
-- creation of books
local book1 = display.newImage("book1.png")
book1.x=900 ; book1.y=display.contentHeight-100 ; book1.width=200; book1.height=200

--[[
halfWidth — Half of the body width. This property is required.
halfHeight — Half of the body height. This property is required.
x — The x offset (±) from the display object's center. This property is optional and defaults to 0.
y — The y offset (±) from the display object's center. This property is optional and defaults to 0.
angle — The angle (rotation) of the body. This property is optional and defaults to 0.]]
--local bookShape ={900,900,900,900,900,900}
--ocal image_outline = graphics.newOutline( 2, book1 )

physics.addBody(book1)

-- add group
local squares = { wallTop, wallBotton, wallRight, wallLeft }
for i = 1, #squares do
    squares[i]:setFillColor(1,0,0)
    physics.addBody(squares[i],"static")
end

mainPlayer.linearDamping = 0.3 -- theorical friction of the object moving through air
mainPlayer.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls



--Creat Rotating target
target = display.newImage( "target.png" )
target.height = 400 ;target.width= 400
target.x = mainPlayer.x ; target.y = mainPlayer.y ;target.alpha = 0


-- Shoot the cue ball, using a visible force vector
function cballShot( event )

	local t = event.target
	local phase = event.phase


	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true

		-- Stop current mainPlayer motion, if any
		t:setLinearVelocity( 0, 0 )
		t.angularVelocity = 0

    -- move Target PNG to the ball
		target.x = t.x
		target.y = t.y
    -- rotate
		startRotation = function()
		target.rotation = target.rotation + 4
		end

		Runtime:addEventListener( "enterFrame", startRotation )

		local showTarget = transition.to( target, { alpha=0.4, xScale=0.4, yScale=0.4, time=200 } )
		myLine = nil

	elseif t.isFocus then

		if "moved" == phase then

			if ( myLine ) then -- is there is a line
				myLine.parent:remove( myLine ) -- erase previous line, if any
			end
			myLine = display.newLine( t.x,t.y, event.x,event.y )
			myLine:setStrokeColor( 1, 1, 1, 50/255 )
			myLine.strokeWidth = 15

		elseif "ended" == phase or "cancelled" == phase then

			display.getCurrentStage():setFocus( nil )
			t.isFocus = false

			local stopRotation = function()
				Runtime:removeEventListener( "enterFrame", startRotation )
			end

			local hideTarget = transition.to( target, { alpha=0, xScale=1.0, yScale=1.0, time=200, onComplete=stopRotation } )

			if ( myLine ) then
				myLine.parent:remove( myLine )
			end

			-- Strike the ball!
			--	local cueShot = audio.loadSound("cueShot.mp3")
			--	audio.play(cueShot)
			t:applyForce( (t.x - event.x), (t.y - event.y), t.x, t.y )
		end
	end

	return true	-- Stop further propagation of touch event
end


-- on tap move the ball up --
--Runtime:addEventListener("tap",moveBall)
mainPlayer:addEventListener( "touch", cballShot ) -- Sets event listener to cueball
