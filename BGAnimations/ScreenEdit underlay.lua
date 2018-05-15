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
	Def.BitmapText{
	Font="_eurostile blue glow",
	Text="EDITOR",
	InitCommand=cmd(shadowlength,4;horizalign,left;x,SCREEN_LEFT+40;y,SCREEN_TOP+40;diffusealpha,0.7);
	},

	Def.BitmapText{
	Font="_eurostile blue glow",
	InitCommand=cmd(diffusealpha,0.8;maxwidth,184;x,SCREEN_LEFT+100;y,SCREEN_CENTER_Y-80;playcommand, "Refresh");
	RefreshCommand=function(self) self:settext(GetEditStepsText())self:sleep(0.5); self:queuecommand('Refresh') end,
	},

	Def.FadingBanner{
	OnCommand=function(self) self:LoadFromSong(GAMESTATE:GetCurrentSong()); self:x(SCREEN_LEFT+100); self:y(SCREEN_CENTER_Y-40); self:zoom(0.30); end,
	},

	Def.BitmapText{
	Font="_eurostile blue glow",
	Text="Press SELECT\n  button for a\n  list of\n  commands\n\nPress START\n  button for the\n  Edit Menu",
	InitCommand=cmd(shadowlength,2;zoom,0.6;horizalign,left;x,SCREEN_LEFT+30;y,SCREEN_BOTTOM-90);
	},
}
