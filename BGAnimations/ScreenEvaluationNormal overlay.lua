return Def.ActorFrame{
	-- The biggest challenge here was to compesate the positions because of SM5's TextureFiltering.
	-- It is different from 3.95/OpenITG's filters, which differ a lot with the original positions.
	-- IN ADDITION of the different x and y handling anyways.
	-- 																			Jose_Varela

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=THEME:GetString("ScreenEvaluation","HeaderText"),
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements Items/stage",""..ToEnumShortString(GAMESTATE:GetCurrentStage() ) ) )..{
		OnCommand=cmd(x,30;y,34;addx,-SCREEN_WIDTH;sleep,3;decelerate,0.3;addx,SCREEN_WIDTH);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

	-- Banner frame


	LoadActor( THEME:GetPathG("Evaluation","banner frame mask") )..{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
	OnCommand=cmd(zwrite,1;z,1;blend,"BlendMode_NoEffect";y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-125;zoom,1.02);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},

	Def.Banner{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126)
	if GAMESTATE:IsCourseMode() then
		self:LoadFromCourse( GAMESTATE:GetCurrentCourse() )
	else
		self:LoadFromSong( GAMESTATE:GetCurrentSong() )
	end
	end,
	OnCommand=cmd(setsize,418/2,164/2;ztest,1;y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-124);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},

	LoadActor( THEME:GetPathG("","ScreenEvaluation banner frame") )..{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
	OnCommand=cmd(y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-124);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},

	-- This is the score frames
	Def.ActorFrame{
	Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);

		LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame p1") )..{
		InitCommand=function(self)
		self:xy(SCREEN_CENTER_X-145,SCREEN_CENTER_Y+54)
		end,
		OnCommand=cmd(addx,-SCREEN_WIDTH/2;sleep,3;decelerate,0.3;addx,SCREEN_WIDTH/2);
		OffCommand=cmd(accelerate,0.3;addx,-SCREEN_WIDTH/2);
		},

		LoadActor( THEME:GetPathG("", "_grade models/"..STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetGrade() ) )..{
			BeginCommand=cmd(x,SCREEN_CENTER_X-145;y,SCREEN_CENTER_Y-60;zoom,2;addx,-SCREEN_WIDTH;decelerate,0.5;addx,SCREEN_WIDTH;sleep,2.2;decelerate,0.5;zoom,0.9;x,SCREEN_CENTER_X-230;y,SCREEN_CENTER_Y-38);
			OffCommand=cmd(accelerate,0.3;addx,-SCREEN_WIDTH/2);
		},
	},

	Def.ActorFrame{
	Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
		
		LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame p2") )..{
		InitCommand=function(self)
		self:xy(SCREEN_CENTER_X+145,SCREEN_CENTER_Y+54)
		end,
		OnCommand=cmd(addx,SCREEN_WIDTH/2;sleep,3;decelerate,0.3;addx,-SCREEN_WIDTH/2);
		OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH/2);
		},

		LoadActor( THEME:GetPathG("", "_grade models/"..STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade() ) )..{
			BeginCommand=cmd(x,SCREEN_CENTER_X+145;y,SCREEN_CENTER_Y-60;zoom,2;addx,SCREEN_WIDTH;decelerate,0.5;addx,-SCREEN_WIDTH;sleep,2.2;decelerate,0.5;zoom,0.9;x,SCREEN_CENTER_X+56;y,SCREEN_CENTER_Y-38);
			OffCommand=cmd(accelerate,0.3;addx,SCREEN_WIDTH/2);
		},

	},
}
