local t = Def.ActorFrame{};
local Settings = {
	StageNum = 1,
	CurrentScreen = "",
	Rewards = {
		["W1"] = "+0.2",
		["W3"] = "-0.5",
		["W4"] = "-1.0",
		["W5"] = "-2.0",
		["Miss"] = "-4.0",
	}
}

for player in ivalues(PlayerNumber) do
	local pn = ToEnumShortString(player)
	local CurColor = function()
		return player == PLAYER_1 and color("#FBBE03") or color("#56FF48")
	end
	t[#t+1] = Def.Actor{
		OnCommand=function()
			if SCREENMAN:GetTopScreen() then
				Settings.CurrentScreen = SCREENMAN:GetTopScreen():GetName()
			end
		end;
	}
	t[#t+1] = Def.BitmapText{
		Condition=GAMESTATE:IsPlayerEnabled(player) and GAMESTATE:GetPlayMode() == "PlayMode_Rave";
		Font="Common Normal";
		InitCommand=function(s) s:settext( GAMESTATE:GetPlayerDisplayName(player) )
		end;
		OnCommand=function(s)
			s:xy( player == PLAYER_1 and SCREEN_CENTER_X-224 or SCREEN_CENTER_X+224, SCREEN_TOP+53 )
			:diffuse( Color.Black ):zoom(0.5):maxwidth(100):addy(-100):sleep(0.5)
			:decelerate(0.8):addy(100)
		end;
		OffCommand=function(s)
			s:sleep(1):accelerate(0.8):addy(-100)
		end;
	};

	t[#t+1] = Def.BitmapText{
		Condition=GAMESTATE:IsPlayerEnabled(player) and (GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" and GAMESTATE:GetPlayMode() ~= "PlayMode_Oni") and not GAMESTATE:Env()["WorkoutMode"] and not GAMESTATE:Env()["Training"];
		Font="_futurist metalic";
		Text=" 0.00%";
		OnCommand=function(self)
			self:xy( player == PLAYER_1 and SCREEN_CENTER_X-150 or SCREEN_CENTER_X+150, SCREEN_TOP+56 )
			:visible( Settings.CurrentScreen ~= "ScreenGameplaySyncMachine" )
			:diffuse( CurColor() ):addy(-100):sleep(0.5)
			:decelerate(0.8):addy(100)
			if ThemePrefs.Get("CompareScores") and GAMESTATE:GetNumPlayersEnabled() == 2 then
				self:pulse():effectclock("bgm"):effectmagnitude(1.05,0.95,0):effectperiod(1)
			end
		end;
		JudgmentMessageCommand=function(self) self:queuecommand("UpdateScore") end;
		UpdateScoreCommand=function(self)
			self:settext( CalculatePercentage(player) )
			-- time to check who's winning
			if GAMESTATE:GetNumPlayersEnabled() == 2 then
				if CalPerNum(player) < CalPerNum(player == PLAYER_1 and 1 or 0) then
					self:effectmagnitude(1,1,0)
				else
					self:effectmagnitude(1.05,0.95,0)
				end
			end
		end,
		OffCommand=function(self)
			self:sleep(1):accelerate(0.8):addy(-100)
		end
	}

	t[#t+1] = Def.BitmapText{
		Condition=GAMESTATE:IsPlayerEnabled(player) and GAMESTATE:GetPlayMode() == "PlayMode_Oni";
		Font="Common Normal";
		OnCommand=function(s)
			s:xy( player == PLAYER_1 and SCREEN_CENTER_X-100 or SCREEN_CENTER_X+100, SCREEN_TOP+54 )
			:diffusealpha(0)
		end;
		JudgmentMessageCommand=function(s,params)
			if params.Player == player and params.Notes then
				local score = ToEnumShortString(params.TapNoteScore)
				s:settext( Settings.Rewards[score] and Settings.Rewards[score].."s" or "" )
				:finishtweening():shadowlength(2):diffusealpha(1):zoom(0.9):linear(0.2):zoom(0.8):sleep(0.2):diffusealpha(0)
			end
		end;
	};

	-- Workout mode calories indicator
	t[#t+1] = Def.ActorFrame{
		Condition=(GAMESTATE:IsPlayerEnabled(player) and GAMESTATE:Env()["WorkoutMode"] ~= nil);
		OnCommand=function(s)
			s:xy( player == PLAYER_1 and SCREEN_CENTER_X-180 or SCREEN_CENTER_X+180, SCREEN_TOP+56 )
			:addy(-100):sleep(0.5):decelerate(0.8):addy(100)
		end;
		OffCommand=function(s) s:sleep(1):accelerate(0.8):addy(-100) end;
		Def.RollingNumbers{
			File = THEME:GetPathF("_futurist", "metalic");
			InitCommand=function(s)
				s:Load("RollingNumbersWorkout"):targetnumber(STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetCaloriesBurned())
			end;
			OnCommand=function(s) s:diffuse( CurColor() ) end;
			StepMessageCommand=function(s) s:queuecommand("Set") end;
			SetCommand = function (s)
				local stats = {STATSMAN:GetAccumPlayedStageStats(player), STATSMAN:GetCurStageStats(player)}
				s:finishtweening():targetnumber(
					stats[1]:GetPlayerStageStats(player):GetCaloriesBurned() + stats[2]:GetPlayerStageStats(player):GetCaloriesBurned()
				)
			end;
		};
	};

	t[#t+1] = Def.ActorFrame{
		Condition=(GAMESTATE:IsPlayerEnabled(player) and GAMESTATE:Env()["WorkoutMode"] ~= nil),
		OnCommand=function(s)
			s:xy( player == PLAYER_1 and SCREEN_CENTER_X-180 or SCREEN_CENTER_X+180, SCREEN_BOTTOM-48 )
			:addy(100):sleep(0.5):decelerate(0.8):addy(-100)
		end;
		OffCommand=function(s) s:sleep(1):accelerate(0.8):addy(100) end;
		Def.BitmapText{
			Font="_futurist metalic",
			OnCommand=function(s) s:diffuse( CurColor() ):queuecommand("UpdateTime") end;
			UpdateTimeCommand=function(s)
				local stats = {
					STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player),
					STATSMAN:GetCurStageStats(player):GetPlayerStageStats(player)
				}
				s:settext( SecondsToMMSSMsMs( stats[1]:GetAliveSeconds() + stats[2]:GetAliveSeconds() ) )
				:sleep(1/60):queuecommand("UpdateTime")
			end;
		};

		Def.BitmapText{
			Font="Common Normal",
			Text=THEME:GetString("ScreenGameplayWorkout","Goal Complete!"),
			OnCommand=function(s)
				s:diffuseshift():zoom(0.6):y(-30):visible(false)
				:effectcolor1(color("0.7,0.7,0.7,1")):shadowlength(2)
				:queuecommand("CheckGoal")
			end;
			CheckGoalCommand=function(s)
				local stats = {
					STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player),
					STATSMAN:GetCurStageStats(player):GetPlayerStageStats(player)
				}
				local GoalType = PROFILEMAN:GetProfile(player):GetGoalType()
				if GoalType == 1 then
					local time = stats[1]:GetAliveSeconds() + stats[2]:GetAliveSeconds()
					if (time >= PROFILEMAN:GetProfile(player):GetGoalSeconds()) then
						GAMESTATE:Env()["WorkoutComplete"..player] = true
					end
				end
				if GoalType == 0 then
					local cal = stats[1]:GetCaloriesBurned() + stats[2]:GetCaloriesBurned()
					if (cal >= PROFILEMAN:GetProfile(player):GetGoalCalories()) then
						GAMESTATE:Env()["WorkoutComplete"..player] = true
					end
				end

				s:visible( GAMESTATE:Env()["WorkoutComplete"..player] == true and true or false )
				s:sleep(1/20):queuecommand("CheckGoal")
			end;
		};
	}

	t[#t+1] = LoadActor( "Lifebar", player )..{
		Condition=(GAMESTATE:IsPlayerEnabled(player) and ThemePrefs.Get("ExperimentalLifebar")) and not GAMESTATE:Env()["WorkoutMode"] and GAMESTATE:GetPlayMode() ~= "PlayMode_Rave",
		OnCommand=function(s)
			s:xy( THEME:GetMetric("ScreenGameplay","Life"..pn.."X") , THEME:GetMetric("ScreenGameplay","Life"..pn.."Y") )
			:addx( player == PLAYER_1 and -100 or 100)
			:sleep(0.5):decelerate(0.8)
			:addx( player == PLAYER_1 and 100 or -100)
		end;
		OffCommand=function(s)
			s:sleep(1):accelerate(0.8)
			:addx( player == PLAYER_1 and -100 or 100)
		end;
	};

	t[#t+1] = Def.ActorFrame{
		OnCommand=function(s) s:sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(s) s:sleep(1):queuecommand("TweenOff") end;
		ShowGameplayFrameMessageCommand=function(s) s:queuecommand("TweenOn") end;
		HideGameplayFrameMessageCommand=function(s) s:queuecommand("TweenOff") end;

		Def.ActorFrame{
			Condition=GAMESTATE:IsPlayerEnabled(player);
			OnCommand=function(s)
				local margin = ThemePrefs.Get("ITG1") and WideScale(66,108) or 66
				s:xy( player == PLAYER_1 and SCREEN_LEFT+margin or SCREEN_RIGHT-margin,SCREEN_TOP+25)
				:addx( player == PLAYER_1 and  -250 or 250 );
			end;
			TweenOnCommand=function(s)
				s:decelerate(0.8):addx( player == PLAYER_1 and  250 or -250 );
			end;
			TweenOffCommand=function(s)
				s:accelerate(0.8):addx( player == PLAYER_1 and  -250 or 250 );
			end;
	
				Def.Sprite{
					Texture=ThemePrefs.Get("ITG1") and THEME:GetPathG('_gameplay mirrored difficulty','frame') or THEME:GetPathG('_difficulty','icons');
					OnCommand=function(s)
						s:pause():playcommand("Update")
						:zoomx( player == PLAYER_1 and 1 or -1 )
					end;
					-- Update Difficulty frame when update begins.
					["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(s) s:playcommand("Update"); end;
					UpdateCommand=function(s,parent) s:setstate( SetFrameDifficulty(player) ) end,
				},
	
				Def.BitmapText{
				Font="Common Normal",
				OnCommand=function(s)
					s:zoom(0.5):xy( player == PLAYER_1 and -36 or 36,0):horizalign( player == PLAYER_1 and left or right):playcommand("Update")
				end;
				["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(s)
					s:playcommand("Update")
				end;
				UpdateCommand=function(s)
						if GAMESTATE:GetCurrentSteps(player) then
							local steps = GAMESTATE:GetCurrentSteps(player):GetDifficulty();
							s:settext( DifficultyName("Steps", player) ):maxwidth(100)
							:diffuse( ThemePrefs.Get("ITG1") and Color.Black or ContrastingDifficultyColor( steps ) )
						end
					end,
				},
	
				Def.BitmapText{
				Font="Common Normal",
				OnCommand=function(s)
					s:zoom(0.5):xy(player == PLAYER_1 and 35 or -35,0):horizalign(player == PLAYER_1 and right or left):playcommand("Update")
				end;
				["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(s)
					s:playcommand("Update")
				end;
				UpdateCommand=function(s)
					if GAMESTATE:GetCurrentSteps(player) then
						local steps = GAMESTATE:GetCurrentSteps(player)
						s:settext( steps:GetMeter() )
						s:diffuse( ThemePrefs.Get("ITG1") and Color.Black or ContrastingDifficultyColor( steps:GetDifficulty() ) )
					end
					end,
				},
	
		},
	};
end

t[#t+1] = Def.ActorFrame{
	OnCommand=function(s)
		s:xy(SCREEN_CENTER_X,SCREEN_TOP+24):addy(-100):sleep(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(s)
		s:sleep(1):queuecommand("TweenOff")
	end;
	ShowGameplayFrameMessageCommand=function(s) s:queuecommand("TweenOn") end;
	HideGameplayFrameMessageCommand=function(s) s:queuecommand("TweenOff") end;
	TweenOnCommand=function(s)
		s:decelerate(0.8):addy(100)
	end;
	TweenOffCommand=function(s)
		s:accelerate(0.8):addy(-100)
	end;

		Def.SongMeterDisplay{
        InitCommand=function(s)
        	s:SetStreamWidth( WideScale( ThemePrefs.Get("ITG1") and 418 or 390, 418+128) )
        end;
        
        Stream=Def.Sprite{ Texture=ThemePrefs.Get("ITG1") and "_meter stream" or "meter stream",
        	InitCommand=function(s) s:diffusealpha(1) end
        },
        Tip=Def.Sprite{ Texture="tip",
            OnCommand=function(s) s:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0) end;
        },
    };

	Def.Sprite{ Texture="meter frame", Condition=not IsUsingWideScreen() and not ThemePrefs.Get("ITG1"); },
	LoadActor( THEME:GetPathB("","_frame 3x1"), {"progress",WideScale( 374, 374+128 )} )..{ Condition=ThemePrefs.Get("ITG1"); };
	
	Def.BitmapText{
	Font="_eurostile normal",
	OnCommand=function(s)
		s:y(1):zoom(.5):shadowlength(0)
	end;
	CurrentSongChangedMessageCommand=function(s)
		s:playcommand("Update")
	end;
	UpdateCommand=function(s)
	if not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
		s:settext( GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
	-- The only elseif of the entire theme.
	elseif GAMESTATE:GetCurrentCourse() then
		s:settext( GAMESTATE:GetCurrentCourse():GetTranslitFullTitle().." ".. (GAMESTATE:GetPlayMode() == "PlayMode_Endless" and "- "..Settings.StageNum.." " or "") .."- "..GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
	end
	s:maxwidth(SCREEN_WIDTH+20)
	end,
	},
};

t[#t+1] = LoadActor("WideScreen SongMeter")..{ Condition=IsUsingWideScreen() and not ThemePrefs.Get("ITG1"); };

-- Draw on top of the rest
	
t[#t+1] = Def.Quad{
	OnCommand=function(s)
		s:diffuse(color("#000000")):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(1):linear(0.3):diffusealpha(0)
	end
};

t[#t+1] = LoadActor("../_song credit display")..{
	Condition=not GAMESTATE:IsDemonstration();
	OnCommand=function(s)
		s:sleep(2.5):linear(0.3):diffusealpha(0)
	end;
};

-- demonstration stuff
t[#t+1] = Def.ActorFrame{
	Condition=GAMESTATE:IsDemonstration(),

	Def.Sprite{
		Texture="demonstration gradient",
		OnCommand=function(s)
			s:FullScreen():diffusealpha(0.8)
		end;
	};
	Def.Sprite{
		Texture="demonstration logo",
		OnCommand=function(s)
			s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-180):pulse():effectmagnitude(1.0,0.9,0):effectclock("bgm"):effectperiod(1)
		end;
	};
};

if GAMESTATE:IsCourseMode() then
	t[#t+1] = Def.ActorFrame{
			OnCommand=function(s)
				s:Center():animate(0):draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40)
				if GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
					s:sleep(0.2):linear(0.4):diffusealpha(0)
				end
			end;
			OffCommand=function(s) s:accelerate(0.8):addy(150) end;
			BeforeLoadingNextCourseSongMessageCommand=function(s)
				s:finishtweening():linear(0.3):Center():zoom(1):sleep(0.5):zoom(0.25):y(SCREEN_BOTTOM-40)
			end,
			Def.Sprite{
			Texture=THEME:GetPathG("StageAndCourses/ScreenGameplay course","song "..Settings.StageNum),
			OnCommand=function(s) s:animate(0) end;
			BeforeLoadingNextCourseSongMessageCommand=function(s)
				Settings.StageNum = Settings.StageNum + 1
				if GAMESTATE:GetPlayMode() ~= "PlayMode_Endless" then
					s:Load( THEME:GetPathG("StageAndCourses/ScreenGameplay course","song "..Settings.StageNum) )
				end
			end,
			},
	};
end

return t;