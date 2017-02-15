local outText = display.newText("###",display.contentWidth/2, display.contentHeight/2,"Apple Casual	",120)

function doSomething(event)
  print("Timer has fired")
  print(event.name)
  print(event.source)
  print(event.time)
  print(event.count)
  outText.text =  event.count
end


myTimer = timer.performWithDelay(1,doSomething, -1)

function stop(event)
end
Runtime:addEventListener("tap",stop)


local red = display.newCircle(200,200,20)
red:setFillColor(1,0,0)
local green  = display.newCircle(300,200,20)
green:setFillColor(0,1,0)
local blue   = display.newCircle(300,400,20)
blue:setFillColor(0,0,1)

transition.to(red,{time=2000, y=600,x=100,xScale=3, rotation=95, alpha=.5})
