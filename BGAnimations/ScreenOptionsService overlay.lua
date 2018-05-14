return Def.ActorFrame{

	LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor("ScreenOptions overlay/ScreenOptions frame")..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addy,18);
	OnCommand=cmd(addx,-SCREEN_WIDTH;decelerate,0.3;addx,SCREEN_WIDTH);
	OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH);
	},

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text="SERVICE OPTIONS",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

}