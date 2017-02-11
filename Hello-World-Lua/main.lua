--[[
    Author: Boris Pallares
    Date: 1/17/2017
    Version: 1.0
    Class: Applications for mobile Devices
    "Hello World"
--]]

-- Background Image generation and settings--
background = display.newImage("backgroundTest3.png")
-- background width will fill the entire screen
background.x = background.width/2
-- background image will begin at the top of the background stripe
background.y = 5000
-- opacity of the backgroubnd
background.alpha = 0.7
-- time is 809999 so it will take a while to complete the
-- transition to the end of the background stripe
transition.to(background , {time=809999 , y= -3650})
-- foreground Image and settings --
foreground = display.newImage("foreground1.png")
-- x and y positions that will locate the foreground image
-- behind the text
foreground.x = 400
foreground.y = 750
-- opacity at 0
foreground.alpha = 0
-- fade the image in
transition.fadeIn(foreground, {time=2000, alpha=1})
-- Display Text 1 and settings --
textHello = display.newText("Hello World",380,480,"Verdana", 80)
textHello.alpha = 0
-- change opacity adn move the text vertically
transition.to(textHello , {time=1000 , alpha=1, y=450})
-- Display Text 2  Name and settings --
textName = display.newText("By Boris Pallares",380,560, "Verdana",45)
textName.alpha = 0
-- change opacity adn move the text vertically
transition.to(textName, {time=1000 , alpha=1, y=550})
-- Quote and settings  --
quoteParr = display.newText("\"Practice does not make perfect.Only perfect practice makes perfect\". \n\n~Vince Lombardi",400,750,700,0,"Verdana",35)
quoteParr.alpha = 0
-- change opacity adn move the text Horizontally
transition.to(quoteParr, {time=1000, alpha = 1, x=410})
