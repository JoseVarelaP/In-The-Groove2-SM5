return Def.ActorFrame{
	Def.BitmapText{
	Font="_eurostile outline",
	Text="???",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-56;shadowlength,2;zoom,0.9;diffuseshift;effectcolor1,color("#FFE58BFF");effectcolor2,color("#FFE58B00");playcommand, "Refresh");
	RefreshCommand=function(self) self:settext(Get2PlayerJoinMessage()) end,
	SideJoinedP1MessageCommand=cmd(PlayCommand, "Refresh");
	SideJoinedP2MessageCommand=cmd(PlayCommand, "Refresh");
	CurrentStyleChangedMessageCommand=cmd(PlayCommand, "Refresh");
	CoinInsertedMessageCommand=cmd(PlayCommand, "Refresh");
	CoinModeChangedMessageCommand=cmd(PlayCommand, "Refresh");
	},
}