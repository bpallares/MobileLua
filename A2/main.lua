--[[ Physics project in lua
     By Boris Pallares
     February 11/17
     Apps For mobile devices class ]]
-----------------------------------------------------------------------------------------------------------------

----------------- Envitonment Configuration ----------------
local physicsEnvironment = require "physics"
physicsEnvironment.start()
physics.setGravity( 0, 9.8 ) -- gravity
display.setStatusBar( display.HiddenStatusBar )  -- get rid of the status bar

-- Set background
local background = display.newImage("back.jpg",display.contentWidth/2,display.contentHeight/2)
background.alpha=0.4

-- Set Score
local globalScore=0
local textScore = display.newText("Score:"..globalScore,180,50,"Verdana",50)

-- Bounce to reset
local bounceCounter=0

-- max number of books
local maxNumberBooks=1

-- Add a round body to the screen
local mainPlayer = display.newCircle(200,display.contentHeight-500,35)
mainPlayer:setFillColor(1,0,0)
physicsEnvironment.addBody(mainPlayer, { density=0.01, friction=1.0, bounce=.9, radius=35 })
mainPlayer.linearDamping = 0.3 -- theorical friction of the object moving through air
mainPlayer.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls


-- Add wall around the scene & set up names of the objects
local wallTop = display.newRect(display.contentWidth/2,0,display.contentWidth,5)
local wallBotton = display.newRect(display.contentWidth/2,display.contentHeight,display.contentWidth,5)
local wallLeft = display.newRect(0,display.contentHeight/2,5,display.contentHeight)
local wallRight = display.newRect(display.contentWidth,display.contentHeight/2,5,display.contentHeight)
wallBotton.name="wallBotton"
local squares = { wallTop, wallBotton, wallLeft,wallRight }
for i = 1, #squares do --  add objects to physics
    squares[i]:setFillColor(1,0,0,0)
    physics.addBody(squares[i],"static")
end

-- Table under the ball and bookselves
local table1 = display.newRect(200,display.contentHeight-170,100,325)
physics.addBody(table1,"static")
table1.name="table1"
local bookShelve1 = display.newRect(1200,500,350,10)
physics.addBody(bookShelve1,"static")
bookShelve1.name="bookShelve1"
local bookShelve2 = display.newRect (1700, 500,350,10)
physics.addBody(bookShelve2,"static")
bookShelve2.name="bookShelve2"


-- Creation of initial book
local book1 = display.newImage("book1.png")
book1.x=900 ; book1.y=display.contentHeight-100; book1.width=200; book1.height=200
local bookShape ={-20,-100, 20,-100, 20,100, -20,100 }
physics.addBody(book1,"dynamic",{density=0.8, bounce=.2, friction=.9,shape = bookShape})
book1.name= "book1"

-- Create obstacles
local pathWay = display.newRect(700,350,10,350)
physics.addBody(pathWay,"static")
pathWay.name= "pathWay"
local pathWay2 = display.newRect(700,700,10,350)
physics.addBody(pathWay2,"static")
pathWay2.name= "pathWay2"


--Creat Rotating target around ball
target = display.newImage( "target.png" )
target.height = 400 ;target.width= 400
target.x = mainPlayer.x ; target.y = mainPlayer.y ;target.alpha = 0

-- Particles that will appear after hitting a book or a head
local particleSystem = physics.newParticleSystem{
  filename = "particle.png",
  colorMixingStrength = 0.1,
  radius = 3,
  imageRadius = 6
}
-- text displaying "Start"
local textReset = ""
textReset = display.newText("Start", display.contentWidth/2,display.contentHeight/2,"verdana",50)
transition.to(textReset,{time= 2000 ,xScale=80,yScale=80,alpha=0, onComplete= function() textReset.text="" end})


----------------------------------------- Functions -----------------------------------
-- Generate books randomly
function generateBooks (event)
        -- will not generate more than 8 books
         if (maxNumberBooks<8) then
        -- x and y random
          local x = math.random(1000, display.contentWidth-100)
          local y = math.random(200,display.contentHeight-100)
          local bookNumber = math.random(1,5)
          book = display.newImage("book"..bookNumber..".png")
          book.name= "book"..bookNumber
          if bookNumber >= 1 and bookNumber <3 then
        -- shape of the book
            local bookShape ={-20,-100, 20,-100, 20,100, -20,100 }
            physics.addBody(book,"dynamic",{density=0.8, bounce=.2, friction=.9,shape = bookShape})
            book.width=200; book.height=200;book.x=x; book.y = y
            maxNumberBooks = maxNumberBooks +1
            book.alpha=0
            transition.to(book,{time=1000,alpha=1})
          else
            physics.addBody(book,"dynamic",{density=0.8, bounce=.2, friction=.9, radius=100})
            book.width=200; book.height=200;book.x=x; book.y = y
            maxNumberBooks = maxNumberBooks +1
            book.alpha=0
            transition.to(book,{time=1000,alpha=1})
          end

        end
end
Runtime:addEventListener("enterFrame",generateBooks)

-- reset ball when bounces more than 15 times on the floor
function resetBall(self, event)
  mainPlayer.x = 200 ; mainPlayer.y = display.contentHeight-500
-- reset speed if any
  mainPlayer:setLinearVelocity( 0, 0 )
  mainPlayer.angularVelocity = 0
  bounceCounter=0
  transition.to(mainPlayer,{alpha=1})
  local soundtrack = audio.loadStream("teleport.mp3")
  audio.play(soundtrack)
end

-- desintegrate books , play sounds
switch =0
local fx1 = audio.loadStream("trump.mp3")
local fx3 = audio.loadStream("fantastic.mp3")
function particleDesintegration(event)

if (event.other.name == "book1" or event.other.name == "book2" or event.other.name == "book3" or event.other.name == "book4" or event.other.name== "book5") then
    globalScore= globalScore+1
    textScore.text= "Score :"..globalScore
    -- Create red particles
    local random1,random2,random3,random4
    random1 = math.random(0.1, 1.0)
    random2 = math.random(0.1, 1.0)
    random3 = math.random(0.1, 1.0)
-- set up particle settings
    local particleParams1 =
    {
    	flags = { "water", "colorMixing" },
    	linearVelocityX = 256,
    	linearVelocityY = -480,
    	color = { random1, random2, random3, 1 },
    	x = event.other.x,
    	y = event.other.y,
    	lifetime = 8.0,
    	radius = 10,
    }

    text = display.newText("+1",mainPlayer.x,mainPlayer.y,"verdana",80 )
    transition.to(text,{time=2000, alpha=0})

    -- Generate particles
    local function onTimer( event )
    	particleSystem:createGroup( particleParams1)
    end
    -- timer
    timer.performWithDelay( 2, onTimer, 5 )
    if event.other.name == "book4" then
       audio.play(fx1, {channel=10})
    else
       audio.play(fx3, {channel=9})
    end
    event.other:removeSelf()
    maxNumberBooks = maxNumberBooks -1
  elseif (event.other.name == "wallBotton") then
        bounceCounter = bounceCounter + 1
        -- if bounce more than 15 time then reset
        if bounceCounter > 15 then
          mainPlayer.alpha=0
          textReset = display.newText("Ball Reset", display.contentWidth/2,display.contentHeight/2,"verdana",50)
          transition.to(textReset,{time= 2000 ,xScale=80,yScale=80,alpha=0, onComplete= function() textReset.text="" end})
          timer.performWithDelay(1,function() return resetBall( self, event) end )
        end
  elseif (event.other.name =="bookShelve1") then
    if switch ==0 then
      transition.to(bookShelve1, {time=1000,rotation = 70, onComplete= function() switch=1 end})
    elseif switch ==1 then
      transition.to(bookShelve1, {time=1000,rotation = 0, onComplete= function() switch=0 end})
    end
  elseif (event.other.name =="bookShelve2") then
    if switch ==0 then
      transition.to(bookShelve2, {time=1000,rotation = 70, onComplete= function() switch=1 end})
    elseif switch ==1 then
      transition.to(bookShelve2, {time=1000,rotation = 0, onComplete= function() switch=0 end})
    end
  else
    bounceCounter=0
  end
end
mainPlayer:addEventListener("collision",particleDesintegration)


-- Spin or move an then obstacles
factor = 0
factor2 =0
function obstacleMove(event)
  pathWay.rotation = pathWay.rotation + 4
  pathWay2.rotation = pathWay2.rotation - 4

  -- print(pathWay.y)
  if math.floor(pathWay.y) == display.contentHeight-200 then
    factor = -10
  elseif math.floor(pathWay.y) == 350  then
    factor = 10
  end

  pathWay.y = pathWay.y + factor
  pathWay2.y =pathWay2.y + factor*(-1)

end
Runtime:addEventListener("enterFrame",obstacleMove)

-- Shoot the ball
function cballShot( event )

	local t = event.target
	local phase = event.phase
-- if screen is being touched
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
    -- show the target
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
			t:applyForce( (t.x - event.x), (t.y - event.y), t.x, t.y )
		end
	end

	return true	-- Stop further propagation of touch event
end

-- load annoying background musics
--local soundtrack = audio.loadStream("trollolol.mp3");
--audio.play(soundtrack, {channel=5, fadein=5000, loops=-1}); -- 5 second fadein,
--audio.setVolume( 0.0, { channel=5 } )

mainPlayer:addEventListener( "touch", cballShot ) -- Sets event listener to cueball
Runtime:addEventListener("tap",generateBooks)
