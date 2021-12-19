function GetEditStepsText()
	local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
	if steps == nil then 
		return ""
	elseif steps:GetDifficulty() == DIFFICULTY_EDIT then 
		return steps:GetDescription()
	else
		local Shorten = ToEnumShortString( steps:GetDifficulty() )
		return THEME:GetString("Difficulty", Shorten)
	end
end

return Def.ActorFrame{
	OnCommand=function(self)
		-- If we're on OutFox, we don't need to check for this state, but instead just the MessageCommand to recieve it.
		if tonumber(VersionDate()) < 20211212 then
			self:queuecommand("CheckState")
		end
	end,
	EditorStateChangedMessageCommand=function(self,params)
		self:visible( params.EditState ~= "EditState_Playing" )
	end,
	CheckStateCommand=function(self)
		if SCREENMAN:GetTopScreen() and SCREENMAN:GetTopScreen():GetName() == "ScreenEdit" then
			self:visible( SCREENMAN:GetTopScreen():GetEditState() ~= "EditState_Playing" )
		end
		self:sleep(1/60):queuecommand("CheckState")
	end,
	Def.BitmapText{
		Font=_eurostileColorPick(),
		Text="EDITOR",
		InitCommand=function(self)
			self:shadowlength(4):halign(0):xy(40,40):diffusealpha(0.7)
		end
	},

	Def.BitmapText{
		Font=_eurostileColorPick(),
		InitCommand=function(self)
			self:diffusealpha(0.8):maxwidth(184):xy(100,SCREEN_CENTER_Y-80):playcommand("Refresh")
		end,
		RefreshCommand=function(self)
			self:settext(GetEditStepsText())
			:sleep(0.5)
			:queuecommand('Refresh')
		end
	},

	Def.FadingBanner{
		OnCommand=function(self)
			self:LoadFromSong(GAMESTATE:GetCurrentSong())
			:xy(100,SCREEN_CENTER_Y-40)
			:zoom(0.30)
		end
	},

	Def.BitmapText{
		Font=_eurostileColorPick(),
		Text="Press SELECT\n  button for a\n  list of\n  commands\n\nPress START\n  button for the\n  Edit Menu",
		InitCommand=function(self)
			self:shadowlength(2):zoom(0.6):horizalign(left):xy(30,SCREEN_BOTTOM-90)
		end
	}
}
