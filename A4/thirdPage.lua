
local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

  --set back button
  local backTextButton = display.newText("<|",60,45,"Verdana",34)
  --set background
  local background = display.newImage("blurredback.jpg")
  background.x = display.contentWidth/2
  background.y = display.contentHeight/2
  background.width =  2000
  background.height = 2000
  --set text login, button
  local textLogin = display.newText("Register", display.contentWidth/2,display.contentHeight -400,"Verdana",25)
  local buttonLogin = display.newRoundedRect(display.contentWidth/2,display.contentHeight-400,400,80,40)
  -- set username text
  local username = display.newText("Username *", display.contentWidth/2-70,400,"Verdana",30)
  -- display name
  local name = display.newText("Name", display.contentWidth/2-120,500,"Verdana",30)
  -- display last name
  local lastName = display.newText("Last Name", display.contentWidth/2-85,600,"Verdana",30)
  -- display email
  local email = display.newText("Email", display.contentWidth/2-120,700,"Verdana",30)
  local line1 = display.newRect(display.contentWidth/2+34,465,400,1)
  local line2 = display.newRect(display.contentWidth/2+34,565,400,1)
  local line3 = display.newRect(display.contentWidth/2+34,670,400,1)
  local line4 = display.newRect(display.contentWidth/2+34,770,400,1)


  -- add objects to the scene group
  textLogin:setFillColor( 0,0,0,1)
  sceneGroup:insert( background )
  sceneGroup:insert( buttonLogin )
  sceneGroup:insert( textLogin )
  sceneGroup:insert( username )
  sceneGroup:insert( name )
  sceneGroup:insert( lastName )
  sceneGroup:insert( email )
  sceneGroup:insert( line1 )
  sceneGroup:insert( line2 )
  sceneGroup:insert( line3 )
  sceneGroup:insert( line4 )
  sceneGroup:insert( backTextButton )

  local function goToMain( event )
  		composer.gotoScene( "firstPage", "slideRight", 700  )
  		--return true -- prevents other objects from receiving the event, and basically means that it worked.
  end
  -- add listener to the text button
  backTextButton:addEventListener("tap",goToMain)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end


function scene:destroy( event )
	local sceneGroup = self.view

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
