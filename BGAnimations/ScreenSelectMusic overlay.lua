return Def.ActorFrame{

	LoadActor( THEME:GetPathG("","ScreenSelectMusic wheel mask") )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-385;y,SCREEN_CENTER_Y-10;zoom,1.1;zoomy,1.2;zwrite,true;z,1;blend,"BlendMode_NoEffect");
	},

	Def.ActorProxy{
		BeginCommand=function(self) local banner = SCREENMAN:GetTopScreen():GetChild('MusicWheel'); self:SetTarget(banner); end,
		InitCommand=function(self) end,
	},

	LoadActor( THEME:GetPathG('ScreenSelectMusic','banner frame') )..{
		OnCommand=cmd(x,SCREEN_CENTER_X-320+444;y,SCREEN_CENTER_Y-240+222)
	},

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=THEME:GetString("ScreenSelectMusic","HeaderText"),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements Items/stage",""..ToEnumShortString(GAMESTATE:GetCurrentStage() ) ) )..{
		OnCommand=cmd(x,40;y,34;addx,-SCREEN_WIDTH;sleep,0.2;decelerate,0.6;addx,SCREEN_WIDTH);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},


	LoadActor( THEME:GetPathG('PaneDisplay','p1') )..{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);
		OnCommand=cmd(x,SCREEN_CENTER_X-155;y,SCREEN_BOTTOM-95;zoomy,0;sleep,0.5;linear,0.3;zoomy,1);
		OffCommand=cmd(linear,0.3;zoomy,0);
	},
	LoadActor( THEME:GetPathG('PaneDisplay','p2') )..{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
		OnCommand=cmd(x,SCREEN_CENTER_X+155;y,SCREEN_BOTTOM-95;zoomy,0;sleep,0.5;linear,0.3;zoomy,1);
		OffCommand=cmd(linear,0.3;zoomy,0);
	},

	Def.HelpDisplay {
	File="_eurostile normal",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+203;zoom,0.75;diffuseblink);
	InitCommand=function(self)
		local s = THEME:GetString("ScreenSelectMusic","CompleteString");
		self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
		self:SetTipsColonSeparated(s);
	end;
	SetHelpTextCommand=function(self, params)
		self:SetTipsColonSeparated( params.Text );
	end;
	SelectMenuOpenedMessageCommand=function(self)
		self:stoptweening():decelerate(0.2):zoomy(0)
		SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMusic select","down") )
	end;
	SelectMenuClosedMessageCommand=function(self)
		self:stoptweening():bouncebegin(0.2):zoomy(0.75)
	end;
	OffCommand=cmd(linear,0.5;zoomy,0);
	},

	LoadActor(THEME:GetPathG("ScreenSelectMusic","Options Message"))..{
		InitCommand=cmd(Center;pause;diffusealpha,0);
		ShowPressStartForOptionsCommand=cmd(diffusealpha,1;faderight,.3;fadeleft,.3;cropleft,-0.3;cropright,1.3;linear,0.3;cropright,-0.3;sleep,1.2;linear,0.3;cropleft,1.3);
		ShowEnteringOptionsCommand=cmd(stoptweening;setstate,1;sleep,0.6;linear,0.3;cropleft,1.3);
		HidePressStartForOptionsCommandCommand=cmd(linear,0.3;cropleft,1.3);
	},


}