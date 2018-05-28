return Def.ActorFrame{

	LoadActor( THEME:GetPathG("","ScreenSelectMusic wheel mask") )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-385;y,SCREEN_CENTER_Y-10;zoom,1.1;zoomy,1.2;zwrite,true;z,1;blend,"BlendMode_NoEffect");
	},

	Def.ActorProxy{
		BeginCommand=function(self) local Wheel = SCREENMAN:GetTopScreen():GetChild('MusicWheel'); self:SetTarget(Wheel); end,
		InitCommand=function(self) end,
	},

	LoadActor( THEME:GetPathG('ScreenSelectMusic','banner frame/NetSelectMusic') )..{
		OnCommand=cmd(x,SCREEN_CENTER_X-320+444;y,SCREEN_CENTER_Y-240+222)
	},

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		--Text=THEME:GetString("ScreenSelectMusic","HeaderText"),
		Text="PICK A GAME ROOM",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

}