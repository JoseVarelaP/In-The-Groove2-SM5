local style = ThemePrefs.Get("ITG1") and "ITG1/" or ""
local ExitSelect = {false,false}
local t = Def.ActorFrame{
	BeginCommand=function(s)
		local screen = SCREENMAN:GetTopScreen():GetName()
		s:y( THEME:GetMetric(screen,"SeparateExitRowY") ):addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH)
	end;
	CancelMessageCommand=function(s) s:playcommand("Off") end;
}

for player in ivalues(PlayerNumber) do
	local pnumber = tonumber( string.len(ToEnumShortString(GAMESTATE:GetMasterPlayerNumber()), 1 ) )
	t[#t+1] = LoadActor( style.."triangle" )..{
		OnCommand=function(s)
			s:x( player == PLAYER_1 and -48 or 48):diffuseblink():effectcolor1(0.6,0.6,0.6,1):effectperiod(1):effectoffset(0.2):effectclock("bgm")
		end;
		["ExitSelected".. ToEnumShortString(player) .."Command"]=function(s)
			s:stoptweening():linear(.15):rotationz( player == PLAYER_1 and -90 or 90)
			ExitSelect[ pnumber ] = true
			MESSAGEMAN:Broadcast("TweenCheck")
		end;
		["ExitUnselected".. ToEnumShortString(player) .."Command"]=function(s)
			s:stoptweening():linear(.15):rotationz(0)
			ExitSelect[ pnumber ] = false
			MESSAGEMAN:Broadcast("TweenCheck")
		end;
	};
end

t[#t+1] = LoadActor("moreexit")..{
	OnCommand=function(s)
		s:y(14):cropbottom(.57):croptop(.1)
	end;
	TweenCheckMessageCommand=function(s)
		s:stoptweening():linear(.15)
		if GAMESTATE:GetNumPlayersEnabled() == 2 and (ExitSelect[1] and ExitSelect[2]) or ExitSelect[ tonumber( string.len(ToEnumShortString(GAMESTATE:GetMasterPlayerNumber()), 1 ) ) ] then
			s:y(-18):croptop(.57):cropbottom(.1)
		else
			s:y(14):cropbottom(.57):croptop(.1)
		end
	end;
};

return t;
