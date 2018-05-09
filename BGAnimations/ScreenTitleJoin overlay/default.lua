return Def.ActorFrame{
	Def.BitmapText{
	Font="_tutorial",
	Condition=GAMESTATE:GetCoinMode()~="COINMODE_FREE" and GAMESTATE:GetPremium()==PREMIUM_JOINT;
	Text="Play 2 PLAYER style for 1 Credit!",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-140;zoom,0.6;diffusetopedge,0.5,0.5,0.5,1;shadowlength,4;glowshift);
	},

	Def.BitmapText{
	Condition=GAMESTATE:GetCoinMode()~="COINMODE_FREE" and GAMESTATE:GetPremium()==PREMIUM_DOUBLE;
	Font="_tutorial",
	Text="Play DOUBLE pad style for 1 Credit!",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-140;zoom,0.6;diffusetopedge,0.5,0.5,0.5,1;shadowlength,4;glowshift);
	},

	Def.BitmapText{
	Font="_eurostile outline",
	Text="PRESS &START;",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-86;shadowlength,2;diffuseblink;effectperiod,0.5;effectcolor1,1,1,1,0;effectcolor2,1,1,1,1);
	},

	LoadActor("../_join overlay")..{ Condition=not GAMESTATE:GetCoinMode()=="COINMODE_FREE" },
	LoadActor("../ScreenAttract overlay")..{ Condition=not GAMESTATE:GetCoinMode()=="COINMODE_FREE" },
}

-- [Layer4]
-- Type=BitmapText
-- Font=_eurostile outline
-- Text=PRESS &START;
-- OnCommand=x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-86;ShadowLength,2;diffuseblink;EffectPeriod,0.5;EffectColor1,1,1,1,0;EffectColor2,1,1,1,1

-- [Layer5]
-- Condition=GAMESTATE:GetCoinMode()~=COIN_MODE_FREE
-- File=../_join overlay

-- [Layer6]
-- Condition=GAMESTATE:GetCoinMode()==COIN_MODE_FREE
-- File=../ScreenAttract overlay
