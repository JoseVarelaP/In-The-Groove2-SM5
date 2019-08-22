local t = Def.ActorFrame{}

local stretchpos = {
	["PlayerNumber_P1"] = {SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM},
	["PlayerNumber_P2"] = {SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM},
	{SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM}
}

local function side(pn)
	local s = 1
	if pn == PLAYER_1 then return s*(-1) end
	return s
end

local style = GAMESTATE:GetCurrentStyle()
local styleType = style:GetStyleType()
local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		HealthStateChangedMessageCommand=function(s, param)
			if param.PlayerNumber == player then
				if param.HealthState == "HealthState_Danger" then
					s:playcommand("Show"..ToEnumShortString(player))
				else
					s:playcommand("Hide"..ToEnumShortString(player))
				end
			end
		end;
		Def.Quad{
			Name="FadeQuad";
			InitCommand=function(s)
				s:diffusealpha(0):stretchto( SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM )
				:fadeleft(0.1):faderight(0.1)
				if not bDoubles then
					if player == PLAYER_1 then s:faderight(.1):fadeleft(0) else s:fadeleft(.1):faderight(0) end
					s:stretchto( unpack( stretchpos[player] ) )
				end
			end;
			["Show".. ToEnumShortString(player) .. "Command"]=function(s)
				s:diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8"))
			end;
			["Hide".. ToEnumShortString(player) .."Command"]=function(s) s:stopeffect():stoptweening():linear(.5):diffusealpha(0) end;
		};
		LoadActor("Danger Text/danger text")..{
			Name="DText",
			InitCommand=function(s)
				s:x( SCREEN_CENTER_X+(SCREEN_WIDTH/4)*side(player) ):y(SCREEN_CENTER_Y+10):diffusealpha(0)
				if bDoubles then s:x(SCREEN_CENTER_X) end
			end;
			["Show".. ToEnumShortString(player) .. "Command"]=function(s) s:diffusealpha(1) end;
			["Hide".. ToEnumShortString(player) .. "Command"]=function(s) s:stopeffect():stoptweening():linear(.5):diffusealpha(0) end;
		};
		LoadActor("Danger Text/danger glow")..{
			Name="DGlow",
			InitCommand=function(s)
				s:x( SCREEN_CENTER_X+(SCREEN_WIDTH/4)*side(player) ):y(SCREEN_CENTER_Y+10):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1)
				if bDoubles then s:x(SCREEN_CENTER_X) end
			end;
			["Show".. ToEnumShortString(player) .. "Command"]=function(s)
				s:cropleft(-0.3):cropright(1):sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show"..ToEnumShortString(player))
			end;
			["Hide".. ToEnumShortString(player) .. "Command"]=function(s)
				s:stopeffect():stoptweening():linear(.5):diffusealpha(0)
			end;
		};
	}
end

return t;