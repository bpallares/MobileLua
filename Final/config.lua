
application =
{content =
	{
  fps = 60,
	width = 1080,
	height = 1920,
	scale ="zoomEven"
	}
}


--[[

at the top of your main.lua file place the following:
require("config");

FPS could also be manipulated. The application area would allow debugging to be disabled.

    "letterbox" — scales the content area to fill the screen while preserving the same aspect ratio. The entire content area will reside on the screen, but this might result in "black bars" on devices with aspect ratios that differ from your content aspect ratio. Note that you can still utilize this "blank" area and fill it with visual elements by positioning them outside the content area.

    "zoomEven" — scales the content area to fill the screen while preserving the same aspect ratio. Some content may "bleed" off the screen edges on devices with aspect ratios that differ from your content aspect ratio.

    "adaptive" — instead of a static content area, a dynamic content width and height is chosen based on the device. This uses platform-dependent heuristics so that the virtual DPI (number of Corona content units per inch) is approximately 160 across devices. On iOS, the width and height is chosen to match the native iOS point width/height of the device (most iOS devices maintain roughly 160 points per inch). On Android, a combination of the standardized DPI (mdpi, hdpi, etc.) and the actual screen width/height in pixels is used to calculate a virtual width/height, assuming a virtual DPI of 160. In the Corona Simulator, this scale matches content width and height to simulate the device.

    "zoomStretch" — scales the content area to fill the entire screen. All content will remain on the screen, but it may be stretched horizontally or vertically. This mode is not recommended since it will typically distort the content area.


	]]--

