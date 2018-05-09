return Def.ActorFrame{

	LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor("ScreenOptions overlay/ScreenOptions frame")..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addy,18);
	OnCommand=cmd(addx,-SCREEN_WIDTH;decelerate,0.3;addx,SCREEN_WIDTH);
	OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH);
	},

	LoadActor( THEME:GetPathG("","MapController Mask") )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+40;zwrite,true;z,1;blend,"BlendMode_NoEffect");
	},

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=string.upper(THEME:GetString("ScreenMapControllers","HeaderText")),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

	Def.BitmapText{
		Font="_eurostile blue glow",
		Text="Player 1 Controls",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(xy,SCREEN_CENTER_X-160,SCREEN_CENTER_Y-160;zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	Def.BitmapText{
		Font="_eurostile blue glow",
		Text="Player 2 Controls",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(xy,SCREEN_CENTER_X+160,SCREEN_CENTER_Y-160;zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},
		
}