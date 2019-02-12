return Def.ActorFrame{
	Def.ActorFrame{
		Name="Danger_Player1";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("ShowP1") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("HideP1") end)
					end
				end
			end;
			Def.Quad{
				InitCommand=function(self)
					self:faderight(.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0)
				end;
				ShowP1Command=function(self)
					self:diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8"))
				end;
				HideP1Command=function(self)
					self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				end;
			};
			LoadActor("Danger Text/danger text")..{
				InitCommand=function(self)
					self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+10):diffusealpha(0)
				end;
				ShowP1Command=function(self)
					self:diffusealpha(1)
				end;
				HideP1Command=function(self)
					self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				end;
			};
			LoadActor("Danger Text/danger glow")..{
				InitCommand=function(self)
					self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+10):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1)
				end;
				ShowP1Command=function(self)
					self:sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show")
				end;
				HideP1Command=function(self)
					self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				end;
			};
		};
	};

	Def.ActorFrame{
		Name="Danger_Player2";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("ShowP2") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("HideP2") end)
					end
				end
			end;
			Def.Quad{
				InitCommand=function(self)
					self:fadeleft(.1):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0)
				end;
				ShowP2Command=function(self)
					self:diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8"))
				end;
				HideP2Command=function(self)
					self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				end;
			};
			LoadActor("Danger Text/danger text")..{
				InitCommand=function(self)
					self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+10):diffusealpha(0)
				end;
				ShowP2Command=function(self)
					self:diffusealpha(1)
				end;
				HideP2Command=function(self)
					self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				end;
			};
			LoadActor("Danger Text/danger glow")..{
				InitCommand=function(self)
					self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+10):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1)
				end;
				ShowP2Command=function(self)
					self:sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show")
				end;
				HideP2Command=function(self)
					self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				end;
			};
		};
	};
}

-- [Layer2]
-- File=../_ScreenGameplay danger text
-- Cond=not GAMESTATE:PlayerUsingBothSides()
-- Command=x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y

-- # Doubles only:
-- [Layer3]
-- Type=Quad
-- Cond=GAMESTATE:PlayerUsingBothSides()
-- OnCommand=faderight,.1;fadeleft,.1;stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuseshift;EffectColor1,1,0,0,0.3;EffectColor2,1,0,0,0.8

-- [Layer4]
-- File=../_ScreenGameplay danger text
-- Cond=GAMESTATE:PlayerUsingBothSides()
-- Command=x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y
