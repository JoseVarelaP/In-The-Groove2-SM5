return Def.ActorFrame{
	-- The biggest challenge here was to compesate the positions because of SM5's TextureFiltering.
	-- It is different from 3.95/OpenITG's filters, which differ a lot with the original positions.
	-- IN ADDITION of the different x and y handling anyways.
	-- 																			Jose_Varela



	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text="CHECK YOUR STATS",
		InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
		OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,.3;zoom,1);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements","stage 1") )..{
		OnCommand=cmd(x,30;y,34;addx,-SCREEN_WIDTH;sleep,3;decelerate,0.3;addx,SCREEN_WIDTH);
		},

	},

	-- 	-- Banner frame
	LoadActor( THEME:GetPathG("","ScreenEvaluation banner frame") )..{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
	OnCommand=cmd(ztest,1;y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-124);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},

	-- This is the score frames
	LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame p1") )..{
	InitCommand=function(self)
	self:xy(SCREEN_CENTER_X-145,SCREEN_CENTER_Y+54)
	end,
	OnCommand=cmd(addx,-SCREEN_WIDTH/2;sleep,3;decelerate,0.3;addx,SCREEN_WIDTH/2);
	},
	LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame p2") )..{
	InitCommand=function(self)
	self:xy(SCREEN_CENTER_X+145,SCREEN_CENTER_Y+54)
	end,
	OnCommand=cmd(addx,SCREEN_WIDTH/2;sleep,3;decelerate,0.3;addx,-SCREEN_WIDTH/2);
	},
}

-- return Def.ActorFrame{
-- 	OnCommand=cmd(xy,SCREEN_LEFT+36,SCREEN_TOP+38);

-- 	-- header text

-- 	Def.BitmapText{
-- 	Font="_eurostile blue glow",
-- 	Text="CHECK YOUR STATS",
-- 	InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
-- 	OnCommand=cmd(zoomx,0;zoomy,6;bounceend,.3;zoom,1);
-- 	OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
-- 	},

-- 	-- Banner frame
-- 	LoadActor( THEME:GetPathG("","ScreenEvaluation banner frame") )..{
-- 	InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-126) end,
-- 	OnCommand=cmd(ztest,1;y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-170);
-- 	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
-- 	},

-- 	-- This is the score frames

-- 	LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame p1") )..{
-- 	InitCommand=function(self) self:xy(SCREEN_LEFT-150,SCREEN_CENTER_Y+10) end,
-- 	OnCommand=cmd(addx,-SCREEN_WIDTH/2;sleep,3;decelerate,0.3;x,SCREEN_CENTER_X-180);
-- 	},

-- 	LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame p2") )..{
-- 	InitCommand=function(self) self:xy(SCREEN_RIGHT+150,SCREEN_CENTER_Y+10) end,
-- 	OnCommand=cmd(addx,SCREEN_WIDTH/2;sleep,3;decelerate,0.3;x,SCREEN_CENTER_X+120);
-- 	},
-- }