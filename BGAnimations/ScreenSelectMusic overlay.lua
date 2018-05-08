return Def.ActorFrame{

	LoadActor( THEME:GetPathG('ScreenSelectMusic','banner frame') )..{
		OnCommand=cmd(x,SCREEN_CENTER_X-320+444;y,SCREEN_CENTER_Y-240+222)
	},

	LoadActor( THEME:GetPathG('ScreenSelectMusic','StepsDisplayList') )..{
		OnCommand=cmd(fov,50;x,SCREEN_CENTER_X+140;y,SCREEN_CENTER_Y+2;rotationy,-20.0;zoomx,1;zoomy,0.94;)
	},

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text="PICK A TUNE",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements","stage "..ToEnumShortString(GAMESTATE:GetCurrentStage() ) ) )..{
		OnCommand=cmd(x,40;y,34;addx,-SCREEN_WIDTH;sleep,0.2;decelerate,0.6;addx,SCREEN_WIDTH);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},


	LoadActor( THEME:GetPathG('PaneDisplay','p1') )..{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);
		OnCommand=cmd(x,SCREEN_CENTER_X-155;y,SCREEN_BOTTOM-95;zoomy,0;sleep,0.5;decelerate,0.3;zoomy,1);
	},
	LoadActor( THEME:GetPathG('PaneDisplay','p1') )..{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
		OnCommand=cmd(x,SCREEN_CENTER_X+155;y,SCREEN_BOTTOM-95;zoomy,0;sleep,0.5;decelerate,0.3;zoomy,1);
	},


}