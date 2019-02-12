return Def.ActorFrame{
	LoadActor("ScreenGameplay overlay/demonstration gradient")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):diffusealpha(0.8)
		end;
	},

	Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_TOP+24):addy(-100):sleep(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(self)
		self:queuecommand("TweenOff")
	end;
	ShowGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOn")
	end;
	HideGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOff")
	end;
	TweenOnCommand=function(self)
		self:decelerate(0.8):addy(100)
	end;
	TweenOffCommand=function(self)
		self:accelerate(0.8):addy(-100)
	end;

		Def.SongMeterDisplay{
        InitCommand=function(self)
        	self:SetStreamWidth(SCREEN_WIDTH/1.17)
        end;
        
        Stream=LoadActor("ScreenGameplay overlay/meter stream")..{
        	InitCommand=function(self)
        		self:diffusealpha(1)
        	end
        };
        Tip=LoadActor("ScreenGameplay overlay/tip")..{
            OnCommand=function(self)
            	self:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0)
            end;
        },
    },

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
			self:settext( GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().." - "..GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
		end
		self:maxwidth(SCREEN_WIDTH+80)
		end,
		},

    -- History Time
    
    -- I've made this trickery with the original meter frame texture back in 2016, when I was messing around with
    -- ITGPC and suddenly got the realization of how could I make the meter frame stretch to fit, without distoring it.
    -- I kept the code I did for this, and now it is used for Widescreen SM setups.
    																						-- Jose_Varela

    	
    	LoadActor("ScreenGameplay overlay/meter frame")..{
    		 OnCommand=function(self)
    			self:zoomtowidth(SCREEN_WIDTH/2):cropleft(0.5):x(SCREEN_WIDTH/5)
    		end
    	},
    	
    	LoadActor("ScreenGameplay overlay/meter frame")..{
    		 OnCommand=function(self)
    			self:zoomtowidth(SCREEN_WIDTH/2):cropright(0.5):x(SCREEN_WIDTH/-5)
    		end
    	},
    	
    	LoadActor("ScreenGameplay overlay/meter frame")..{
    		 OnCommand=function(self)
    			self:zoomtowidth(SCREEN_WIDTH/2):cropright(0.1):cropleft(0.1):x(0)
    		end
    	},
	},



	-- Difficulty time
	Def.ActorFrame{
	OnCommand=function(self)
		self:sleep(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(self)
		self:queuecommand("TweenOff")
	end;
	ShowGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOn")
	end;
	HideGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOff")
	end;

		Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1),
		OnCommand=function(self)
			self:x(SCREEN_LEFT+150):y(SCREEN_TOP+60):addx(-250)
		end;
		TweenOnCommand=function(self)
			self:decelerate(0.8):addx(250)
		end;
		TweenOffCommand=function(self)
			self:accelerate(0.8):addx(-250)
		end;

			LoadActor( THEME:GetPathG('','_difficulty icons') )..{
				OnCommand=function(self)
					self:animate(0):playcommand("Update")
				end;
				CurrentStepsP1ChangedMessageCommand=function(self)
					self:playcommand("Update")
				end;
				CurrentStepsP2ChangedMessageCommand=function(self)
					self:playcommand("Update")
				end;
				UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_1) ) end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):xy(-35,0):horizalign(left):playcommand("Update")
			end;
			CurrentStepsP1ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			CurrentStepsP2ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( DifficultyName("Steps", PLAYER_1) )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):xy(35,0):horizalign(right):playcommand("Update")
			end;
			CurrentStepsP1ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			CurrentStepsP2ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

		},

		Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2),
		OnCommand=function(self)
			self:x(SCREEN_RIGHT-150):y(SCREEN_TOP+60):addx(250)
		end;
		TweenOnCommand=function(self)
			self:decelerate(0.8):addx(-250)
		end;
		TweenOffCommand=function(self)
			self:accelerate(0.8):addx(250)
		end;

			LoadActor( THEME:GetPathG('','_difficulty icons') )..{
				OnCommand=function(self)
					self:animate(0):playcommand("Update")
				end;
				CurrentStepsP1ChangedMessageCommand=function(self)
					self:playcommand("Update")
				end;
				CurrentStepsP2ChangedMessageCommand=function(self)
					self:playcommand("Update")
				end;
				UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_2) ) end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):xy(-35,0):horizalign(left):playcommand("Update")
			end;
			CurrentStepsP1ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			CurrentStepsP2ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
					self:settext( DifficultyName("Steps", PLAYER_2) )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):xy(35,0):horizalign(right):playcommand("Update")
			end;
			CurrentStepsP1ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			CurrentStepsP2ChangedMessageCommand=function(self)
				self:playcommand("Update")
			end;
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},
		},

	},



	Def.Quad{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):diffuse(0,0,0,1):sleep(0.5):linear(0.5):diffusealpha(0)
	end;
	},
}