local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
	Def.BitmapText{ Font="_eurostile normal",
		InitCommand=function(self) self:playcommand("UpdateText") end,
		-- Update the text when the players have selected the song.
		SongChosenMessageCommand=function(self) self:playcommand("UpdateText") end,
		UpdateTextCommand=function(self)
			local FinalText = ""
			local StepCharters = ""
			if not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
				local DataToPick = {
					Title = GAMESTATE:GetCurrentSong():GetDisplayFullTitle(),
					Artist = GAMESTATE:GetCurrentSong():GetDisplayArtist(),
				}
				FinalText = DataToPick.Title .. "\n" .. DataToPick.Artist
				if ThemePrefs.Get("StepArtist") then
					for player in ivalues(PlayerNumber) do
						if GAMESTATE:IsPlayerEnabled(player) then 
							local steps = GAMESTATE:GetCurrentSteps(player)
							local StepCharter = steps and ( steps:GetAuthorCredit() and steps:GetAuthorCredit() or steps:GetDescription() ) or ""							
							-- Show each difficulty's stepcharter. If it exists anyway.
							if StepCharter ~= "" then
								StepCharters = StepCharters .. "\n"..  DifficultyName("Steps", player) .. " " .. THEME:GetString("EditMenuRow","Steps") .. ": ".. StepCharter
								-- Both difficulties are the same? Filter them to only show one.
								if GAMESTATE:GetCurrentSteps(0) == GAMESTATE:GetCurrentSteps(1) then
									StepCharters = "\n"..  DifficultyName("Steps", player) .. " " .. THEME:GetString("EditMenuRow","Steps") .. ": ".. StepCharter
								end
							end
						end
					end
				end
				self:settext( FinalText .. StepCharters )
			end
		end,
		OnCommand=function(self)
			self:halign(0):xy(SCREEN_LEFT+60,SCREEN_BOTTOM-100):shadowlength(2):zoom(0.75)
		end
	}
}

return t