--[[ ** Boris Pallares
     ** 1/24/2017
     ** Version 1.0
     ** Assignment #2
--]]

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
  	--The primary object in the Composer library is the scene object.
  	--This is an event listener that responds to specific events,
  	--and it contains a unique self.view property which is a reference to the display group associated with the scene.
  	--This self.view is where you should insert visual elements pertaining to the scene.

  --[[ create a group ]]--
  groupOfGUI = display.newGroup()
  -- set background color and "responsive", (iphone 750x1334)
  globalBackground = display.newRect(display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
  globalBackground:setFillColor(0.133,0.145,0.188)
  groupOfGUI:insert(globalBackground)
  --[[ top menu ]]--
  -- rectangle with color
  divider = display.newRect(display.contentWidth/2,75,display.contentWidth,150)
  divider:setFillColor(0.475,0.49,0.545)
  groupOfGUI:insert(divider)
  --[[ search bar & text ]]--
  -- rounded rectangle with color
  -- text hint
  searchBar = display.newRoundedRect(display.contentWidth/2,85,450,50,500)
  textBar = display.newText("Please enter a city",380,85 , "Verdana", 25)
  textBar:setFillColor(0,0,0)
  textBar.alpha=0.2
  --[[ back "button" ]]--
  backTextButton = display.newText("=",60,85,"Verdana",65)
  --[[ image container1 and items ]]--
  -- image
  image = display.newImage("image.jpg")
  image.alpha = 0.6
  image.height = 400
  image.width =700
  image.x = 300
  image.y = 350
  -- right side bar
  sideBar2 = display.newRect(display.contentWidth-50,350,100,400)
  sideBar2:setFillColor(0.251,0.267,0.322)  -- 0.251,0.267,0.322
  goText1 = display.newText("|>",display.contentWidth-50,350,"Verdana",35)
  goText1:setFillColor(0.475,0.49,0.545)
  -- actual container
  imgContainer1 = display.newRect(display.contentWidth/2,350,display.contentWidth,400)
  imgContainer1:setFillColor(0.353,0.369,0.431) --0.133,0.145,0.431
  groupOfGUI:insert(imgContainer1)

  --[[ image container2 ]]--
  -- image
  image2 = display.newImage("image2.jpg")
  image2.alpha=0.6
  image2.height = 400
  image2.width =700
  image2.x = 300
  image2.y = 760
  -- right side bar
  sideBar2 = display.newRect(display.contentWidth-50,760,100,400)
  sideBar2:setFillColor(0.251,0.267,0.322)
  goText2 = display.newText("|>",display.contentWidth-50,760,"Verdana",35)
  goText2:setFillColor(0.475,0.49,0.545)
  -- actual container
  imgContainer2 = display.newRect(display.contentWidth/2,760,display.contentWidth,400)
  imgContainer2:setFillColor(0.353,0.369,0.431)
  groupOfGUI:insert(imgContainer2)

  --[[ image container3 ]]--
  -- image
  image3 = display.newImage("image3.jpg")
  image3.alpha=0.6
  image3.height = 400
  image3.width =700
  image3.x = 300
  image3.y = 1170
  --right side bar
  sideBar3 = display.newRect(display.contentWidth-50,1170,100,400)
  sideBar3:setFillColor(0.251,0.267,0.322)
  goText3 = display.newText("|>",display.contentWidth-50,1170,"Verdana",35)
  goText3:setFillColor(0.475,0.49,0.545)
  -- actual container
  imgContainer3 = display.newRect(display.contentWidth/2,1170,display.contentWidth,400)
  imgContainer3:setFillColor(0.353,0.369,0.431)
  groupOfGUI:insert(imgContainer3)
  --[[ bottom menu ]]--
  dividerButton = display.newRect(display.contentWidth/2,display.contentHeight-50,display.contentWidth,100)
  dividerButton:setFillColor(0.475,0.49,0.545)
  --[[ circle "button" with text ]]--
  scrollCircle = display.newCircle(50,1170,50)
  scrollCircle:setFillColor(0.133,0.145,0.188)
  scrollCText = display.newText("^",50,1175,"Verdana",60)
  --[[ button /icons ]] --
  -- ..., finder icon , profile icon, star icon included here
  -- ...
  moreButton = display.newText("...",display.contentWidth-250,display.contentHeight-69,"Verdana",60)
  homeButton = display.newImage("home.png")
  homeButton.x = display.contentWidth-500
  homeButton.y = display.contentHeight-54
  -- find
  findButton = display.newImage("finder.png")
  findButton.x = display.contentWidth-380
  findButton.y = display.contentHeight-54
  -- profile
  profileButton = display.newImage("profile.png")
  profileButton.x = display.contentWidth-50
  profileButton.y = 85
  -- empty star
  emptyStar = display.newImage("emptystar.png")
  emptyStar.x = 600
  emptyStar.y = 210
  emptyStar:scale(.8,.8)
  -- full star
  emptyStar2 = display.newImage("fullstar.png")
  emptyStar2.x = 600
  emptyStar2.y = 610
  emptyStar2:scale(.8,.8)
  -- full star
  emptyStar3 = display.newImage("fullstar.png")
  emptyStar3.x = 600
  emptyStar3.y = 1010
  emptyStar3:scale(.8,.8)

  --[[ Ad text/ block of ad text --]]
  -- add 1
  adText1 = display.newEmbossedText("From \n$50,000", 100, 210 , "Verdana",40)
  adTextBlock1 = display.newEmbossedText("Saint Apartments" , 180, 450 , "Verdana",40)
  adTextBlock1 = display.newEmbossedText("5.8 miles from your location" , 185, 490 , "Verdana",25)
  -- add 2
  adText2 = display.newEmbossedText("From \n$1,000,000", 120, 630 , "Verdana",40)
  dTextBlock2 = display.newEmbossedText("HazelWood Apartments" , 240, 850 , "Verdana",40)
  adTextBlock2 = display.newEmbossedText("20.8 miles from your location" , 192, 890 , "Verdana",25)
  -- add 3
  adText3 = display.newEmbossedText("From \n$100,000", 100, 1040 , "Verdana",40)
  --[[ view organization ]]--
  globalBackground:toBack()
  divider:toFront()

end
