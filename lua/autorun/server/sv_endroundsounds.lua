TRAITOR = 2
INNOCENT = 3
TIMEOUT = 4
WST.sounds = {[INNOCENT] = {}, [TRAITOR] = {}, [TIMEOUT] = {}} -- (WST stands for WinSoundsTable)
WST.enabled = true

local WST = WST
util.AddNetworkString("TTTWin")

function WST:AddSound(winType, path, artist, title)
	if !file.Exists("sound/"..path, "GAME") then Msg("Round Music -- "); print("The file: 'sound/"..path.."' Does not exist!"); return; else Msg("Round Music -- "); print("Adding the file: 'sound/"..path.."'") end;
	local sound = {}
	sound.path = path
	if artist and title then sound.artist = artist; sound.title = title; end;
	table.insert(WST.sounds[winType], sound)
	resource.AddSingleFile("sound/"..path)
	util.PrecacheSound("sound/"..path)
end

if file.Exists("addons/endroundsounds/data/sounds.txt", "GAME") then
	RunStringEx(file.Read("addons/endroundsounds/data/sounds.txt", "GAME"), "EndRoundSounds")
else
	Msg("Round Music -- "); print("Config File Doesn't Exist!!! (addons/endroundsounds/data/sounds.txt)"); WST.enabled = false
end

hook.Add("TTTEndRound", "SoundClipEndRound", function(winType)
	if (!WST.enabled or #WST.sounds[winType] == 0) then return end
	net.Start("TTTWin")
		local sound = util.Compress(util.TableToJSON(table.Random(WST.sounds[winType])))
		net.WriteUInt(#sound, 32);
		net.WriteData(sound, #sound)
	net.Broadcast()
end)