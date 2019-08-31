local style = ThemePrefs.Get("ITG1") and "_" or ""
local t = Def.ActorFrame{}

t[#t+1] = LoadActor("../ScreenWithMenuElements underlay");
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(s)
			s:addx(-SCREEN_WIDTH)
			:decelerate(0.3):addx(SCREEN_WIDTH)
		end;
		OffCommand=function(s) s:accelerate(0.3):addx(SCREEN_WIDTH) SOUND:DimMusic(0,2) end;
		CancelMessageCommand=function(s) s:accelerate(0.3):addx(SCREEN_WIDTH) end;

		LoadActor( THEME:GetPathG("","_name frame" ), player )..{
			Condition=GAMESTATE:IsPlayerEnabled(player),
			OnCommand=function(s)
				s:xy( player == PLAYER_1 and SCREEN_CENTER_X-146 or SCREEN_CENTER_X+146, SCREEN_CENTER_Y-138 )
			end;
		};

		LoadActor( "player-frame" )..{
			Condition=GAMESTATE:IsPlayerEnabled(player),
			OnCommand=function(s)
				s:xy( player == PLAYER_1 and SCREEN_CENTER_X-146 or SCREEN_CENTER_X+146, SCREEN_CENTER_Y-60 )
			end;
		};

		Def.BitmapText{
			Font="Common Normal",
			Text=THEME:GetString("ScreenWorkoutMenu","NotPresent"),
			Condition=not GAMESTATE:IsPlayerEnabled(player),
			OnCommand=function(s)
				s:xy( player == PLAYER_1 and SCREEN_CENTER_X-146 or SCREEN_CENTER_X+146, SCREEN_CENTER_Y-70 )
				:diffuseshift():effectcolor1(color(".8,.8,.8,1")):effectcolor2(color(".4,.4,.4,1"))
			end;
		};
	};
end

t[#t+1] = Def.ActorFrame{
	OnCommand=function(s) s:CenterX():addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH) end;
	OffCommand=function(s) s:accelerate(0.3):addx(SCREEN_WIDTH) end;
	CancelMessageCommand=function(s) s:accelerate(0.3):addx(SCREEN_WIDTH) end;

	LoadActor( "shared-frame" )..{ OnCommand=function(s) s:y( SCREEN_CENTER_Y+36 ) end; };
	LoadActor( style.."explanation-frame" )..{ OnCommand=function(s) s:y( SCREEN_CENTER_Y+118 ) end; };
}

t[#t+1] = LoadActor("../_menu out")..{
	OnCommand=function(s)
		if ThemePrefs.Get("ITG1") then s:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8)) else s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y) end
		s:diffusealpha(0)
	end;
	OffCommand=function(s) s:sleep(0.3):linear(0.3):diffusealpha(1) end;
}

return t;