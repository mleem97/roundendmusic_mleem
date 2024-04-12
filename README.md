TTT End Round Music REWORK REWORK
=======================
This addon was originally designed by [Kurochi](http://steamcommunity.com/id/_kurochi).

The title already reveals that the plugin is designed for the Trouble in Terrorist Town Gamemode by Badking. Music (or sounds) will be played on every round end and it can be configured in a .txt file from which sounds it should be chosen one randomly on traitor or innocent win or timeout.

It should work for the original and the second gamemode.

Configuration
=======================
Sounds can be configured in data/sounds.txt. The configuration of the widget can be done in lua/autorun/client/cl_endroundsounds.lua.
```Lua
WIDGET_FADESPEED = 2			-- Time to take for fading in and out, in seconds, cannot be zero.
WIDGET_STAYTIME = 5				-- Time to keep widget displayed before fading out, in seconds
WIDGET_APPEARINTERVAL = 0.2		-- Time to wait before starting fade-in
WIDGET_THICKNESS = 1			-- Size of the font
WIDGET_ALIGN_X = ALIGN_LEFT		-- Horizontal alignment of widget; Possibilities: ALIGN_LEFT, ALIGN_CENTER, ALIGN_RIGHT
WIDGET_ALIGN_Y = ALIGN_TOP		-- Vertical alignment of widget; Possibilities: ALIGN_TOP, ALIGN_BOTTOM
WIDGET_X = 20					-- Horizontal position
WIDGET_Y = 20					-- Vertical position
```

Modifications
=======================
Features additionally built in by me:
* The ability to turn off sounds being played on round end in TTT settings menu (F1)

Planned features:
* Widget config in a text file instead of a lua file
* Support for other gamemodes like Murder and Prop Hunt
* Option for playing sounds / music directly from an URL
* Control panel for easier configuration / changes
