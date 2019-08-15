local t = Def.ActorFrame{};
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.BitmapText{
		Condition=GAMESTATE:IsPlayerEnabled(player) and GAMESTATE:GetPlayMode() == "PlayMode_Rave";
		Font="Common Normal";
		InitCommand=function(self)
			self:settext( GAMESTATE:GetPlayerDisplayName(player) )
		end;
		OnCommand=function(self)
			self:xy( player == PLAYER_1 and SCREEN_CENTER_X-224 or SCREEN_CENTER_X+224, SCREEN_TOP+53 )
			:diffuse( Color.Black ):zoom(0.5):maxwidth(100):addy(-100):sleep(0.5)
			:decelerate(0.8):addy(100)
		end;
		OffCommand=function(self)
			self:sleep(1):accelerate(0.8):addy(-100)
		end;
	};

	t[#t+1] = Def.BitmapText{
		Condition=GAMESTATE:IsPlayerEnabled(player) and GAMESTATE:GetPlayMode() ~= "PlayMode_Rave";
		Font="_futurist metalic";
		Text=" 0.00%";
		OnCommand=function(self)
			self:xy( player == PLAYER_1 and SCREEN_CENTER_X-180 or SCREEN_CENTER_X+180, SCREEN_TOP+56 )
			:diffuse( player == PLAYER_1 and color("#FBBE03") or color("#56FF48") ):addy(-100):sleep(0.5)
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
		end;
		OffCommand=function(self)
			self:sleep(1):accelerate(0.8):addy(-100)
		end;
	};

	t[#t+1] = LoadActor( "Lifebar", player )..{
		Condition=GAMESTATE:IsPlayerEnabled(player) and ThemePrefs.Get("ExperimentalLifebar"),
		OnCommand=function(self)
			local tsns = ToEnumShortString(player)
			self:xy( THEME:GetMetric("ScreenGameplay","Life"..tsns.."X") , THEME:GetMetric("ScreenGameplay","Life"..tsns.."Y") )
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
		OnCommand=function(self)
			self:sleep(0.5):queuecommand("TweenOn")
		end;
		OffCommand=function(self)
			self:sleep(1):queuecommand("TweenOff")
		end;
		ShowGameplayTopFrameMessageCommand=function(self)
			self:playcommand("TweenOn")
		end;
		HideGameplayTopFrameMessageCommand=function(self)
			self:playcommand("TweenOff")
		end;

		Def.ActorFrame{
			Condition=GAMESTATE:IsPlayerEnabled(player);
			OnCommand=function(self)
				self:xy( player == PLAYER_1 and SCREEN_LEFT+66 or SCREEN_RIGHT-66,SCREEN_TOP+25)
				:addx( player == PLAYER_1 and  -250 or 250 );
			end;
			TweenOnCommand=function(self)
				self:decelerate(0.8):addx( player == PLAYER_1 and  250 or -250 );
			end;
			TweenOffCommand=function(self)
				self:accelerate(0.8):addx( player == PLAYER_1 and  -250 or 250 );
			end;
	
				Def.Sprite{
					Texture=THEME:GetPathG('','_difficulty icons');
					OnCommand=function(self)
						self:pause():playcommand("Update");
					end;
					-- Update Difficulty frame when update begins.
					["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Update"); end;
					UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(player) ) end,
				},
	
				Def.BitmapText{
				Font="Common Normal",
				OnCommand=function(self)
					self:zoom(0.5):xy(-36,0):horizalign(left):playcommand("Update")
				end;
				["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self)
					self:playcommand("Update")
				end;
				UpdateCommand=function(self)
						if GAMESTATE:GetCurrentSteps(player) then
							local steps = GAMESTATE:GetCurrentSteps(player):GetDifficulty();
							self:settext( DifficultyName("Steps", player) ):maxwidth(100)
							:diffuse( ContrastingDifficultyColor( steps ) )
						end
					end,
				},
	
				Def.BitmapText{
				Font="Common Normal",
				OnCommand=function(self)
					self:zoom(0.5):xy(35,0):horizalign(right):playcommand("Update")
				end;
				["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self)
					self:playcommand("Update")
				end;
				UpdateCommand=function(self)
					if GAMESTATE:GetCurrentSteps(player) then
						local steps = GAMESTATE:GetCurrentSteps(player)
						self:settext( steps:GetMeter() )
						self:diffuse( ContrastingDifficultyColor( steps:GetDifficulty() ) )
					end
					end,
				},
	
		},
	};
end

t[#t+1] = LoadActor("WideScreen SongMeter")..{ Condition=IsUsingWideScreen(); };

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_TOP+24):addy(-100):sleep(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(self)
		self:sleep(1):queuecommand("TweenOff")
	end;
	TweenOnCommand=function(self)
		self:decelerate(0.8):addy(100)
	end;
	TweenOffCommand=function(self)
		self:accelerate(0.8):addy(-100)
	end;

		Def.SongMeterDisplay{
		Condition=not IsUsingWideScreen();
        InitCommand=function(self)
        	self:SetStreamWidth(390)
        end;
        
        Stream=Def.Sprite{ Texture="meter stream",
        	InitCommand=function(self) self:diffusealpha(1) end
        },
        Tip=Def.Sprite{ Texture="tip",
            OnCommand=function(self) self:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0) end;
        },
    };

    Def.Sprite{ Texture="meter frame", Condition=not IsUsingWideScreen(); },
	
	Def.BitmapText{
	Font="_eurostile normal",
	OnCommand=function(self)
		self:y(1):zoom(.5):shadowlength(0)
	end;
	CurrentSongChangedMessageCommand=function(self)
		self:playcommand("Update")
	end;
	UpdateCommand=function(self)
	if not GAMESTATE:IsCourseMode() then
		self:settext( GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
	else
		self:settext( GAMESTATE:GetCurrentCourse():GetTranslitFullTitle().." - "..GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
	end
	self:maxwidth(SCREEN_WIDTH+20)
	end,
	},
};

-- Draw on top of the rest
	
t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:diffuse(color("#000000")):stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(1):linear(0.3):diffusealpha(0)
	end
};

t[#t+1] = LoadActor("../_song credit display")..{
	Condition=not GAMESTATE:IsDemonstration();
	OnCommand=function(self)
		self:sleep(2.5):linear(0.3):diffusealpha(0)
	end;
};

-- demonstration stuff
t[#t+1] = Def.ActorFrame{
	Condition=GAMESTATE:IsDemonstration(),

	Def.Sprite{
		Texture="demonstration gradient",
		OnCommand=function(self)
			self:FullScreen():diffusealpha(0.8)
		end;
	};
	Def.Sprite{
		Texture="demonstration logo",
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-180):pulse():effectmagnitude(1.0,0.9,0):effectclock("bgm"):effectperiod(1)
		end;
	};
};

if GAMESTATE:IsCourseMode() then
	local StageNum = 1
	t[#t+1] = Def.ActorFrame{
			OnCommand=function(self) self:Center():animate(0):draworder(105):zoom(1):sleep(1.2):linear(0.3):zoom(0.25):y(SCREEN_BOTTOM-40) end;
			OffCommand=function(self) self:accelerate(0.8):addy(150) end;
			BeforeLoadingNextCourseSongMessageCommand=function(self)
				self:finishtweening():linear(0.3):Center():zoom(1):sleep(0.5):zoom(0.25):y(SCREEN_BOTTOM-40)
			end,
			Def.Sprite{
			Texture=THEME:GetPathG("StageAndCourses/ScreenGameplay course","song "..StageNum),
			OnCommand=function(self) self:animate(0) end;
			BeforeLoadingNextCourseSongMessageCommand=function(self)
				StageNum = StageNum + 1
				self:Load( THEME:GetPathG("StageAndCourses/ScreenGameplay course","song "..StageNum) )
			end,
			},
		};
end

return t;