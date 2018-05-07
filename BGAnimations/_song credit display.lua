return Def.ActorFrame{
	Def.BitmapText{
	Font="_eurostile normal",
	Text=" ",
	InitCommand=function(self)
	if not GAMESTATE:IsCourseMode() then
		self:settext( GAMESTATE:GetCurrentSong():GetDisplayMainTitle().."\n"..GAMESTATE:GetCurrentSong():GetDisplayArtist() )
	end
	end,
	OnCommand=cmd(horizalign,left;x,SCREEN_LEFT+60;y,SCREEN_BOTTOM-100;shadowlength,2;zoom,0.75);
	},
}