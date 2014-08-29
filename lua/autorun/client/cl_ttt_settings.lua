CreateClientConVar("ttt_endroundsounds_enable", "1", FCVAR_ARCHIVE)

hook.Add("TTTSettingsTabs", "EndRoundSoundsTTTSettingsTab", function(dtabs)

	local padding = dtabs:GetPadding()

	padding = padding * 2

	local dsettings = vgui.Create("DPanelList", dtabs)
	dsettings:StretchToParent(0,0,padding,0)
	dsettings:EnableVerticalScrollbar(true)
	dsettings:SetPadding(10)
	dsettings:SetSpacing(10)

	do
		local dgui = vgui.Create("DForm", dsettings)
		dgui:SetName("General settings")

		local cb = nil

		dgui:CheckBox("Enable music on round end", "ttt_endroundsounds_enable")

		dsettings:AddItem(dgui)
	end

	dtabs:AddSheet("Music", dsettings, "icon16/music.png", false, false, "End Round Music settings")
end)