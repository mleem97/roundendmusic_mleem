local WST = WST

function WST:DisplayWidget(artist, title)
	if artist and title then
		WIDGET_ARTIST = artist
		WIDGET_TITLE = title
		WIDGET_STATUS = STATUS_INVISIBLE
		
		local curTime = CurTime()
		WIDGET_FADEIN_TIME = curTime + WIDGET_APPEARINTERVAL
		WIDGET_FADEOUT_TIME = curTime + WIDGET_APPEARINTERVAL + WIDGET_FADESPEED + WIDGET_STAYTIME
		WIDGET_INVISIBLE_TIME = curTime + WIDGET_APPEARINTERVAL + WIDGET_FADESPEED + WIDGET_STAYTIME + WIDGET_FADESPEED
	end
end

net.Receive("TTTWin", function()
	local length = net.ReadUInt(32)
	local sound = util.JSONToTable(util.Decompress(net.ReadData(length)))
	if cvars.Bool("ttt_endroundsounds_enable", true) then
		surface.PlaySound(sound.path)
		if sound.artist and sound.title then
			WST:DisplayWidget(sound.artist, sound.title)
		end
	end
end)

-- Enums
STATUS_INVISIBLE = 0
STATUS_FADINGIN = 1
STATUS_FADINGOUT = 2

ALIGN_LEFT = 0
ALIGN_CENTER = 1
ALIGN_RIGHT = 2

ALIGN_TOP = 0
ALIGN_BOTTOM = 2

-- Widget Global Vars
WIDGET_STATUS = STATUS_INVISIBLE
WIDGET_ALPHAFLOAT = 0
WIDGET_ARTIST = "#Artist"
WIDGET_TITLE = "#Song Title"

WIDGET_FADEIN_TIME = -1
WIDGET_FADEOUT_TIME = -1
WIDGET_INVISIBLE_TIME = -1

-- CONFIGURABLE VALUES START HERE
WIDGET_FADESPEED = 2
WIDGET_STAYTIME = 5
WIDGET_APPEARINTERVAL = 0.2
WIDGET_THICKNESS = 1
WIDGET_ALIGN_X = ALIGN_RIGHT
WIDGET_ALIGN_Y = ALIGN_BOTTOM
WIDGET_X = ScrW() - 10
WIDGET_Y = ScrH() - 10
-- CONFIGURABLE VALUES END HERE

hook.Add("HUDPaint", "SongTitleArtist", function()
	if CurTime() >= WIDGET_FADEIN_TIME and CurTime() < WIDGET_FADEOUT_TIME and CurTime() < WIDGET_INVISIBLE_TIME then
		WIDGET_STATUS = STATUS_FADINGIN
	elseif CurTime() >= WIDGET_FADEOUT_TIME and CurTime() > WIDGET_FADEIN_TIME and CurTime() < WIDGET_INVISIBLE_TIME then
		WIDGET_STATUS = STATUS_FADINGOUT
	elseif (CurTime() >= WIDGET_INVISIBLE_TIME and CurTime() > WIDGET_FADEOUT_TIME and CurTime() > WIDGET_INVISIBLE_TIME) then
		WIDGET_STATUS = STATUS_INVISIBLE
		return
	end

	if WIDGET_STATUS == STATUS_FADINGIN then
		WIDGET_ALPHAFLOAT = math.Clamp01(WIDGET_ALPHAFLOAT + ((1 / WIDGET_FADESPEED) * FrameTime()))
	elseif WIDGET_STATUS == STATUS_FADINGOUT then
		WIDGET_ALPHAFLOAT = math.Clamp01(WIDGET_ALPHAFLOAT - ((1 / WIDGET_FADESPEED) * FrameTime()))
	end

	local font = "Trebuchet18"
	surface.SetFont(font)
	local textWidth2, textHeight2 = surface.GetTextSize("Now Playing")
	textWidth2 = textWidth2 + (WIDGET_THICKNESS * 2)
	textHeight2 = textHeight2 + (WIDGET_THICKNESS * 2)
	local artist = WIDGET_ARTIST
	local title = WIDGET_TITLE
	font = "Trebuchet24"
	surface.SetFont(font)
	local width, height = surface.GetTextSize(artist)
	local width2, height2 = surface.GetTextSize(title)
	if width2 + height2 > width + height then
		width = width2
		height = height2
	end
	local textHeight = height
	width = width + 20
	height = (height * 2) + 25

	local textAlpha = 255 * WIDGET_ALPHAFLOAT
	local boxAlpha = 123 * WIDGET_ALPHAFLOAT

	local shouldAddSize = 0
	if WIDGET_ALIGN_Y == ALIGN_TOP then
		shouldAddSize = 1
	end
	draw.RoundedBox(8, WIDGET_X - ((width / 2) * WIDGET_ALIGN_X), WIDGET_Y - ((height / 2) * WIDGET_ALIGN_Y) + ((textHeight2 / 2) * shouldAddSize), width, height, Color(0, 0, 0, boxAlpha))
	local textX = WIDGET_X - ((width / 2) * WIDGET_ALIGN_X)
	local textY = WIDGET_Y - ((height / 2) * WIDGET_ALIGN_Y) + ((textHeight2 / 2) * shouldAddSize)

	draw.SimpleText(artist, font, textX + 10, textY + 10, Color(255, 255, 255, textAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	draw.SimpleText(title, font, textX + 10, textY + 10 + textHeight + 5, Color(255, 255, 255, textAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	font = "Trebuchet18"
	surface.SetFont(font)
	draw.SimpleTextOutlined("Now Playing", font, textX + 10, textY - textHeight2 / 2, Color(255, 255, 255, textAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, WIDGET_THICKNESS, Color(0, 0, 0, textAlpha))
end)