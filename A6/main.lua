-----------------------------------------------------------------------------------------
--
-- main.lua
-- By Boris Pallares April 2
-----------------------------------------------------------------------------------------

local t={}
local frameToCheck =0 
local nextFrame = false
local isCurrentlyAnimated = false

-- Background definitions
local b =display.newRect(display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
b:setFillColor(0.85,0.85,0.85)
-- Background with numbers
local e = display.newImage("numbers.png",display.contentWidth/2,display.contentHeight/2,display.contentWidth)
e.width = display.contentWidth
e.height =display.contentHeight
e.alpha =  0.029
-- Button
local button = display.newRect(56,20,90,30)
-- Text of the button 
local d = display.newText("Do Something...",56,20,"Helvetica",12)
d:setFillColor(1,1,1)
button:setFillColor(0,0,0)
-- Loading text 
local c =display.newText("Loading...",display.contentWidth/2,display.contentHeight/2+120,"Helvetica",12)
c:setFillColor(0,0,0)
-- Data Sheet configuration 
local sheetData = {width=287, height=314, numFrames=276, sheetContentWidth=4096, sheetContentHeight=8192}
local mySheet = graphics.newImageSheet("cuckoo2.png", sheetData)
-- sequence definitions
local sequenceData = {
    {name = "spin", start=1,count=92,time=4500 },
    {name = "bird", start=93,count=183,time=9000 }
}
-- clock spriteSheet
local clock  = display.newSprite(mySheet, sequenceData)
clock.x = display.contentWidth/2
clock.y = display.contentHeight/2
clock:setSequence("spin")
clock:play()
clock:scale(0.7,0.7)
-- mini light. this lets user know that the button has been pressed
local a = display.newCircle(display.contentWidth/2+13,display.contentHeight/2-43,2)
a:setFillColor(1,0,0)
-- CallBird checks if button has been pressed
-- status cannot be changed is the animation is running
function callBird(event)
    if isCurrentlyAnimated  == false then 
        nextFrame = true
        a:setFillColor(0,1,0)
        c.text= "Loading...Be Patient"
    end 
end

-- checks  at what frame it can start doing the next sequence
function t:timer(event)
    
    frameToCheck = clock.frame
    -- if button has been pressed and the frame is 1 then start doing the next sequence
    if frameToCheck == 1 and nextFrame == true then 
        clock:setSequence("bird")
        clock:play()
        nextFrame = false
        isCurrentlyAnimated  = true
    -- is second sequence is done then call the first sequence 
    elseif frameToCheck == 183 then 
        clock:setSequence("spin")
        clock:play()
        a:setFillColor(1,0,0)
        c.text= "Loading..."
        isCurrentlyAnimated = false
    -- if is the second sequence then do sound when the frame is 43
    elseif frameToCheck ==43 and isCurrentlyAnimated==true then
        local soundtrack2 = audio.loadStream("cuckoo.wav");
        audio.play(soundtrack2, {channel=2, loops=0});
        audio.setVolume( 0.2, { channel=2 } )
    end

end
-- Lsiteners
button:addEventListener("tap",callBird)
timer.performWithDelay(1,t,0)
--- background sound
local soundtrack = audio.loadStream("tick tock.wav");
audio.play(soundtrack, {channel=5, loops=-1}); -- 5 second fadein,
audio.setVolume( 0.02, { channel=5 } )
