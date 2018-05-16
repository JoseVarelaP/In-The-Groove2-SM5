return Def.ActorFrame{

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=THEME:GetString("ScreenPlayerOptions","HeaderText"),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements Items/stage",""..ToEnumShortString(GAMESTATE:GetCurrentStage() ) ) )..{
		OnCommand=cmd(x,40;y,34;addx,-SCREEN_WIDTH;sleep,0.2;decelerate,0.6;addx,SCREEN_WIDTH);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

	LoadActor( THEME:GetPathG("","_name p1") )..{
		OnCommand=cmd(player,PLAYER_1;x,SCREEN_CENTER_X+(372-320);y,81;addx,SCREEN_WIDTH*3/4;sleep,0.1;decelerate,0.3;addx,-SCREEN_WIDTH*3/4);
		OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH);
	},

	LoadActor( THEME:GetPathG("","_name p2") )..{
		OnCommand=cmd(player,PLAYER_2;x,SCREEN_CENTER_X+(540-320);y,81;addx,SCREEN_WIDTH*3/4;sleep,0.2;decelerate,0.3;addx,-SCREEN_WIDTH*3/4);
		OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH);
	},


}