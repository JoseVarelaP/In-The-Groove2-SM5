local t = Def.ActorFrame{}
local style = GAMESTATE:GetCurrentStyle()
local styleType = style:GetStyleType()
local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
local stretchpos = {
	["PlayerNumber_P1"] = {SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM},
	["PlayerNumber_P2"] = {SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM},
	{SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM}
}

for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.Quad{
		Condition=not bDoubles,
		OnCommand=function(s)
			s:diffuse(color("0,0,0,0"))
			s:stretchto( unpack( stretchpos[player] ) )
			if player == PLAYER_1 then s:faderight(.1):fadeleft(0) else s:fadeleft(.1):faderight(0) end
		end;
		HealthStateChangedMessageCommand=function(s, param)
			if param.PlayerNumber == player then
				if param.HealthState == "HealthState_Dead" then s:diffusealpha(0.5) end
			end
		end;
	};
end

t[#t+1] = Def.ActorFrame{
	Name="DeadDouble";
	BeginCommand=function(s)
		s:visible( styleType == "StyleType_OnePlayerTwoSides" or styleType == "StyleType_TwoPlayersSharedSides" )
	end;
	HealthStateChangedMessageCommand=function(s, param)
		if param.HealthState == "HealthState_Dead" then
			s:RunCommandsOnChildren(function(s) s:playcommand("Show") end)
		end
	end;
	Def.Quad{
		InitCommand=function(s)
			s:diffuse(color("0,0,0,0.5")):fadeleft(.2):faderight(.2):FullScreen():diffusealpha(0)
		end;
		ShowCommand=function(s)
			s:linear(0.2):diffusealpha(0.5)
		end;
	};
};

return t;