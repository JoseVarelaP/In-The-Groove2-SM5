return Def.ActorFrame{

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text="SELECT A STYLE",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

	LoadActor("explanation frame")..{
	OnCommand=cmd(x,SCREEN_CENTER_X+82;y,SCREEN_CENTER_Y+134;diffusealpha,0;linear,0.5;diffusealpha,1);
	MadeChoiceP1MessageCommand=cmd(playcommand, "GoOff");
	MadeChoiceP2MessageCommand=cmd(playcommand, "GoOff");
	GoOffCommand=cmd(linear,0.5;diffusealpha,0);
	},
}