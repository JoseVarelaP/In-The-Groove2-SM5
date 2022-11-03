return Def.ActorFrame{
	Def.BitmapText{
	Font="_tutorial",
	Condition=GAMESTATE:GetCoinMode()~="CoinMode_Free" and GAMESTATE:GetPremium()==PREMIUM_JOINT;
	Text="Play 2 PLAYER style for 1 Credit!",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-140):zoom(0.6):diffusetopedge(0.5,0.5,0.5,1):shadowlength(4):glowshift()
	end;
	},

	Def.BitmapText{
	Condition=GAMESTATE:GetCoinMode()~="CoinMode_Free" and GAMESTATE:GetPremium()==PREMIUM_DOUBLE;
	Font="_tutorial",
	Text="Play DOUBLE pad style for 1 Credit!",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-140):zoom(0.6):diffusetopedge(0.5,0.5,0.5,1):shadowlength(4):glowshift()
	end;
	},

	Def.BitmapText{
	Font="_eurostile outline",
	Text="PRESS &START;",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_BOTTOM-86):shadowlength(2):diffuseblink():effectperiod(0.5):effectcolor1(1,1,1,0):effectcolor2(1,1,1,1)
	end;
	OffCommand=function(self)
		SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
	end
	},

	LoadActor("../_join overlay")..{ Condition=not GAMESTATE:GetCoinMode()=="CoinMode_Free" },
	LoadActor("../ScreenAttract overlay")..{ Condition=not GAMESTATE:GetCoinMode()=="CoinMode_Free" },
}