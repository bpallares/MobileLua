local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )



function scene:create( event )
	local sceneGroup = self.view
	--The primary object in the Composer library is the scene object.
	--This is an event listener that responds to specific events,
	--and it contains a unique self.view property which is a reference to the display group associated with the scene.
	--This self.view is where you should insert visual elements pertaining to the scene.



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

-- when the row is rendering then
local function onRowRender( event )

    -- Get reference to the row group
    local row = event.row

    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

    local rowTitle = display.newText( row, "Row " .. row.index, 0, 0, nil, 14 )
    rowTitle:setFillColor( 0 )

    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 0
    rowTitle.y = rowHeight * 0.5
end

-- Create the widget
local tableView = widget.newTableView(
    {
        x = display.contentWidth/2,
        y = display.contentHeight/2,
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


-- Insert 40 rows
for i = 1, 10 do

    -- Insert a row into the tableView
    tableView:insertRow(
        {
            isCategory = false,
            rowHeight = 300,
            rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
            lineColor = { 0.5, 0.5, 0.5 }

        }
    )
end
sceneGroup:insert(tableView)

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
