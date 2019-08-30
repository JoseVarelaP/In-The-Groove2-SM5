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
		self:queuecommand("CheckState")
	end;
	CheckStateCommand=function(self)
		if SCREENMAN:GetTopScreen() and SCREENMAN:GetTopScreen():GetName() == "ScreenEdit" then
			self:visible( SCREENMAN:GetTopScreen():GetEditState() == "EditState_Edit" )
		end
		self:sleep(1/60):queuecommand("CheckState")
	end;
	Def.BitmapText{
	Font=_eurostileColorPick(),
	Text="EDITOR",
	InitCommand=function(self)
		self:shadowlength(4):halign(0):xy(SCREEN_LEFT+40,SCREEN_TOP+40):diffusealpha(0.7)
	end;
	},

	Def.BitmapText{
	Font=_eurostileColorPick(),
	InitCommand=function(self)
		self:diffusealpha(0.8):maxwidth(184):x(SCREEN_LEFT+100):y(SCREEN_CENTER_Y-80):playcommand("Refresh")
	end;
	RefreshCommand=function(self) self:settext(GetEditStepsText())self:sleep(0.5); self:queuecommand('Refresh') end,
	},

	Def.FadingBanner{
	OnCommand=function(self) self:LoadFromSong(GAMESTATE:GetCurrentSong()); self:x(SCREEN_LEFT+100); self:y(SCREEN_CENTER_Y-40); self:zoom(0.30); end,
	},

	Def.BitmapText{
	Font=_eurostileColorPick(),
	Text="Press SELECT\n  button for a\n  list of\n  commands\n\nPress START\n  button for the\n  Edit Menu",
	InitCommand=function(self)
		self:shadowlength(2):zoom(0.6):horizalign(left):x(SCREEN_LEFT+30):y(SCREEN_BOTTOM-90)
	end;
	},
}
