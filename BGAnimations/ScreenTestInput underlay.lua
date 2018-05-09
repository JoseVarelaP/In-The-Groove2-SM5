return Def.ActorFrame{

	LoadActor("ScreenWithMenuElements underlay"),

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=string.upper(THEME:GetString("ScreenTestInput","HeaderText")),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

	Def.DeviceList {
		Font="Common Normal",
		InitCommand=cmd(x,SCREEN_LEFT+20;y,SCREEN_TOP+80;zoom,0.8;halign,0);
	};

	Def.InputList {
		Font="Common Normal",
		InitCommand=cmd(x,SCREEN_CENTER_X-280;y,SCREEN_CENTER_Y;zoom,1;halign,0;vertspacing,8;zoom,0.6);
	};

}