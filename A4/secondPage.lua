local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

local defaultBox



function scene:create( event )
	local sceneGroup = self.view
	--The primary object in the Composer library is the scene object.
	--This is an event listener that responds to specific events,
	--and it contains a unique self.view property which is a reference to the display group associated with the scene.
	--This self.view is where you should insert visual elements pertaining to the scene.


	divider = display.newRect(display.contentWidth/2,50,display.contentWidth,100)
	divider:setFillColor(0.475,0.49,0.545)
	local backTextButton = display.newText("<|",60,45,"Verdana",34)




	-- Create text box
	searchBar = display.newRoundedRect(display.contentWidth/2,50,500,50,25)
	defaultBox = native.newTextBox( display.contentWidth/2,50,450,50,500 )
	defaultBox.text = "Enter location"
	defaultBox.isEditable = true
 	defaultBox.alpha=0.2
	defaultBox.font = native.newFont( "Verdana", 24 )




	--defaultBox:addEventListener( "userInput", textListener )

-- The "onRowRender" function may go here (see example under "Inserting Rows", above)

-- Create image sheet for custom scroll bar
local scrollBarOpt = {
    width = 20,
    height = 20,
    numFrames = 3,
    sheetContentWidth = 20,
    sheetContentHeight = 60
}
local scrollBarSheet = graphics.newImageSheet( "scrollBar.png", scrollBarOpt )

local images = {"image.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg"}
-- when the row is rendering then
local function onRowRender( event )

    -- Get reference to the row group
    local row = event.row

    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

    local rowTitle = display.newText( row, "Row " .. row.index, 0, 0, nil, 14 )
    rowTitle:setFillColor( 0 )

		image = display.newImage(row,images[row.index])
		--image.alpha = 0.6
		image.height = 400
		image.width =700
		image.x = 300
		image.y = 201

    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 0
    rowTitle.y = rowHeight * 0.5
end

-- Create the widget
local tableView = widget.newTableView(
    {
        x = display.contentWidth/2,
        y = 765,
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
        }
    }
)


-- Insert 10 rows
for i = 1, 6 do

    -- Insert a row into the tableView
    tableView:insertRow(
        {

            isCategory = false,
            rowHeight = 400,
            rowColor = { default={0.251,0.267,0.322}, over={1,0.5,0,0.2} },
            lineColor = { 0.5, 0.5, 0.5 }

        }
    )
end



sceneGroup:insert(tableView)
sceneGroup:insert(divider)
sceneGroup:insert(searchBar)
sceneGroup:insert(backTextButton)
sceneGroup:insert(defaultBox)


local function goToMain( event )
		defaultBox.alpha=0
		composer.gotoScene( "firstPage", "slideRight", 700  )
		--return true -- prevents other objects from receiving the event, and basically means that it worked.
end

backTextButton:addEventListener("tap",goToMain)





end -- scene create

function scene:show( event )

	local phase = event.phase

	if "did" == phase then
	  -- fixes the text box  that had a glitch when transitioning
		defaultBox.alpha=0.2




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
