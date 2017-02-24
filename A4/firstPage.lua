
local composer = require( "composer" )
local scene = composer.newScene()



function scene:create( event )
	local sceneGroup = self.view
  -- disable the status bar
  -- add composer
  local composer = require "composer"
  -- background
  local background = display.newImage("blurredback.jpg")
  background.x = display.contentWidth/2
  background.y = display.contentHeight/2
  background.width =  2000
  background.height = 2000
	sceneGroup:insert(background )
  --container1
  --local container = display.newRect(display.contentWidth/2,display.contentHeight/2,700,950)
  --container.alpha = 0.2
  -- add Welcome message
  local welcome = display.newText("Welcome", display.contentWidth/2,display.contentHeight/2 -300,"Verdana",80)
	sceneGroup:insert( welcome)
  -- add message
  local message = display.newText("",display.contentWidth/2,display.contentHeight/2 -100,"Verdana",28)
  message.text = "Welcome to the app of the future. \n" ..
                  "Please, login to post apartments for rent,\n"..
                  "or press search to find you next home! \n"..
                  "\nfor more details access our website: \n"..
                  "www.blablabla.com. \n"..
                  "Thanks for downloading our app"
	sceneGroup:insert( message )
  -- add 2 buttons
  local buttonSearch = display.newRoundedRect(display.contentWidth/2,display.contentHeight-500,400,80,40)
  local buttonLogin = display.newRoundedRect(display.contentWidth/2,display.contentHeight-400,400,80,40)
	sceneGroup:insert( buttonSearch )
	sceneGroup:insert( buttonLogin )
  -- colors -- stroke
  buttonSearch.fill= none
  buttonSearch.strokeWidth = 2
  buttonLogin:setFillColor(0.14,0.67,0.37)
  -- Text on top of the buttons
  local textSearch = display.newText("Search", display.contentWidth/2,display.contentHeight -500,"Verdana",25)
  local textLogin = display.newText("Login", display.contentWidth/2,display.contentHeight -400,"Verdana",25)
  local textRegister=  display.newText("Register", display.contentWidth/2-60,display.contentHeight -340,"Verdana",20)
	sceneGroup:insert(textSearch)
	sceneGroup:insert( textLogin)
	sceneGroup:insert(textRegister)
  -- block separating register and password ( Register | Password)
  local textSeparator= display.newText("|", display.contentWidth/2,display.contentHeight -340,"Verdana",20)
  local textForgot= display.newText("Password", display.contentWidth/2+60,display.contentHeight -340,"Verdana",20)
	sceneGroup:insert( textSeparator)
	sceneGroup:insert(textForgot)
  ---------------
  local function goToStore( event )
  print("1st")
  		composer.gotoScene( "secondPage", "slideLeft", 400  )
  		--return true -- prevents other objects from receiving the event, and basically means that it worked.
  end

  buttonLogin:addEventListener("tap",goToStore)


end

function scene:show( event )

	local phase = event.phase

	if "did" == phase then




	end

end

function scene:hide( event )

	local phase = event.phase
	if "will" == phase then

		-- remove touch listener for image

		-- image:removeEventListener( "touch", image )


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
