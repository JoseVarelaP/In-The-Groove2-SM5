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
						self:RunCommandsOnChildren(cmd(playcommand,"ShowP1"))
					else
						self:RunCommandsOnChildren(cmd(playcommand,"HideP1"))
					end
				end
			end;
			Def.Quad{
				InitCommand=cmd(faderight,.1;stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM;diffusealpha,0;);
				ShowP1Command=cmd(diffusealpha,1;diffuseshift;effectcolor1,color("1,0,0,0.3");effectcolor2,color("1,0,0,0.8"));
				HideP1Command=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor("Danger Text/danger text")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+10;diffusealpha,0;);
				ShowP1Command=cmd(diffusealpha,1;);
				HideP1Command=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor("Danger Text/danger glow")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+10;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;);
				ShowP1Command=cmd(sleep,0.5;linear,0.7;cropleft,1;cropright,-0.3;sleep,0.8;queuecommand,"Show");
				HideP1Command=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
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
						self:RunCommandsOnChildren(cmd(playcommand,"ShowP2"))
					else
						self:RunCommandsOnChildren(cmd(playcommand,"HideP2"))
					end
				end
			end;
			Def.Quad{
				InitCommand=cmd(fadeleft,.1;stretchto,SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffusealpha,0;);
				ShowP2Command=cmd(diffusealpha,1;diffuseshift;effectcolor1,color("1,0,0,0.3");effectcolor2,color("1,0,0,0.8"));
				HideP2Command=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor("Danger Text/danger text")..{
				InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+10;diffusealpha,0;);
				ShowP2Command=cmd(diffusealpha,1;);
				HideP2Command=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor("Danger Text/danger glow")..{
				InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+10;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;);
				ShowP2Command=cmd(sleep,0.5;linear,0.7;cropleft,1;cropright,-0.3;sleep,0.8;queuecommand,"Show");
				HideP2Command=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
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
