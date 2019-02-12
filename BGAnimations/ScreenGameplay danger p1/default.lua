return Def.ActorFrame{
	Def.Quad{ Condition=not GAMESTATE:PlayerUsingBothSides();
		OnCommand=function(self)
			self:faderight(.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffuseshift():effectcolor1(1,0,0,0.3):effectcolor2(1,0,0,0.8)
		end;
	},
}

[Layer2]
File=../_ScreenGameplay danger text
Cond=not GAMESTATE:PlayerUsingBothSides()
Command=x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y

# Doubles only:
[Layer3]
Type=Quad
Cond=GAMESTATE:PlayerUsingBothSides()
OnCommand=faderight,.1;fadeleft,.1;stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuseshift;EffectColor1,1,0,0,0.3;EffectColor2,1,0,0,0.8

[Layer4]
File=../_ScreenGameplay danger text
Cond=GAMESTATE:PlayerUsingBothSides()
Command=x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y
