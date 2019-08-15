local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
	Def.BitmapText{ Font="_eurostile normal",
	InitCommand=function(self)
	local FinalText = ""
	local StepCharters = ""
	if not GAMESTATE:IsCourseMode() then
		local DataToPick = {
			Title = GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),
			Artist = GAMESTATE:GetCurrentSong():GetDisplayArtist(),
		}
		FinalText = DataToPick.Title .. "\n" .. DataToPick.Artist
		if ThemePrefs.Get("StepArtist") then
			for player in ivalues(PlayerNumber) do
				if GAMESTATE:IsPlayerEnabled(player) then 
					local steps = GAMESTATE:GetCurrentSteps(player)
					local StepCharter = steps and ( steps:GetAuthorCredit() and steps:GetAuthorCredit() or steps:GetDescription() ) or ""
					StepCharters = StepCharters .. "\n"..  DifficultyName("Steps", player) .. " " .. THEME:GetString("EditMenuRow","Steps") .. ": ".. StepCharter
				end
			end
		end
		self:settext( FinalText .. StepCharters )
	end
	end,
	OnCommand=function(self)
		self:halign(0):xy(SCREEN_LEFT+60,SCREEN_BOTTOM-100):shadowlength(2):zoom(0.75)
	end;
	},
}

return t;