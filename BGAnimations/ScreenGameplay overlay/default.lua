return Def.ActorFrame{
	Def.BitmapText{
	Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:GetPlayMode() == "PlayMode_Rave",
	Font="Common Normal",
	InitCommand=function(self)
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_1))
	end
	end,
	OnCommand=cmd(x,SCREEN_CENTER_X-224;y,SCREEN_TOP+53;shadowlength,0;diffuse,color("#000000");zoom,.5;maxwidth,180;addy,-100;sleep,0.5;decelerate,0.8;addy,100);
	OffCommand=cmd(accelerate,0.8;addy,-100);
	},

	Def.BitmapText{
	Condition=GAMESTATE:IsHumanPlayer(PLAYER_2) and GAMESTATE:GetPlayMode() == "PlayMode_Rave",
	Font="Common Normal",
	InitCommand=function(self)
	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
		self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_2))
	end
	end,
	OnCommand=cmd(x,SCREEN_CENTER_X+224;y,SCREEN_TOP+53;shadowlength,0;diffuse,color("#000000");zoom,.5;maxwidth,180;addy,-100;sleep,0.5;decelerate,0.8;addy,100);
	OffCommand=cmd(accelerate,0.8;addy,-100);
	},

	LoadActor("WideScreen SongMeter")..{ Condition=IsUsingWideScreen(); },

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+24;addy,-100;sleep,0.5;queuecommand, "TweenOn");
	OffCommand=cmd(sleep,1;queuecommand, "TweenOff");
	ShowGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOn");
	HideGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOff");
	TweenOnCommand=cmd(decelerate,0.8;addy,100);
	TweenOffCommand=cmd(accelerate,0.8;addy,-100);

		Def.SongMeterDisplay{
		Condition=not IsUsingWideScreen();
        InitCommand=cmd(SetStreamWidth,390);
        Stream=LoadActor("meter stream")..{InitCommand=cmd(diffusealpha,1)};
        Tip=LoadActor("tip")..{
            OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,0.6;effectcolor2,1,1,1,1.0);
        },
    },

    	LoadActor("meter frame")..{ Condition=not IsUsingWideScreen(); },

		Def.BitmapText{
		Font="_eurostile normal",
		OnCommand=cmd(y,1;zoom,.5;shadowlength,0);
		CurrentSongChangedMessageCommand=cmd(playcommand, "Update");
		UpdateCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
			self:settext( GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
		else
			self:settext( GAMESTATE:GetCurrentCourse():GetTranslitFullTitle().." - "..GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
		end
		self:maxwidth(SCREEN_WIDTH+20)
		end,
		},
	},

	-- Difficulty time
	Def.ActorFrame{
	OnCommand=cmd(sleep,0.5;queuecommand, "TweenOn");
	OffCommand=cmd(sleep,1;queuecommand, "TweenOff");
	ShowGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOn");
	HideGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOff");

		Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1),
		OnCommand=cmd(x,SCREEN_LEFT+66;y,SCREEN_TOP+25;addx,-250);
		TweenOnCommand=cmd(decelerate,0.8;addx,250);
		TweenOffCommand=cmd(accelerate,0.8;addx,-250);

			LoadActor( THEME:GetPathG('','_difficulty icons') )..{
				OnCommand=cmd(animate,0;playcommand, "Update");
				CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");

				UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_1) ) end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,-36,0;horizalign,left;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( DifficultyName("Steps", PLAYER_1) )
					self:maxwidth(100)
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,35,0;horizalign,right;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

		},

		Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2),
		OnCommand=cmd(x,SCREEN_RIGHT-66;y,SCREEN_TOP+25;addx,250);
		TweenOnCommand=cmd(decelerate,0.8;addx,-250);
		TweenOffCommand=cmd(accelerate,0.8;addx,250);

			LoadActor( THEME:GetPathG('','_difficulty icons') )..{
				OnCommand=cmd(animate,0;playcommand, "Update");
				CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
				UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_2) ) end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,-36,0;horizalign,left;playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
					self:settext( DifficultyName("Steps", PLAYER_2) )
					self:maxwidth(100)
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,35,0;horizalign,right;playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},
		},

	},

	-- Draw on top of the rest
	
	Def.Quad{
		OnCommand=cmd(diffuse,color("#000000");stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffusealpha,1;linear,0.3;diffusealpha,0)
	},
	
	LoadActor("../_song credit display")..{
		Condition=not GAMESTATE:IsDemonstration();
		OnCommand=cmd(sleep,2.5;linear,0.3;diffusealpha,0);
	},
	
	-- demonstration stuff
	Def.ActorFrame{
		Condition=GAMESTATE:IsDemonstration(),
	
		LoadActor("demonstration gradient")..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0.8);
		},
		LoadActor("demonstration logo")..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-180;pulse;effectmagnitude,1.0,0.9,0;effectclock,"bgm";effectperiod,1);
		},
	}

}
