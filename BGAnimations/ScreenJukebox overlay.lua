return Def.ActorFrame{
	LoadActor("ScreenGameplay overlay/demonstration gradient")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0.8);
	},

	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+24;addy,-100;sleep,0.5;queuecommand, "TweenOn");
	OffCommand=cmd(queuecommand, "TweenOff");
	ShowGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOn");
	HideGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOff");
	TweenOnCommand=cmd(decelerate,0.8;addy,100);
	TweenOffCommand=cmd(accelerate,0.8;addy,-100);

		Def.SongMeterDisplay{
        InitCommand=cmd(SetStreamWidth,SCREEN_WIDTH/1.17);
        Stream=LoadActor("ScreenGameplay overlay/meter stream")..{InitCommand=cmd(diffusealpha,1)};
        Tip=LoadActor("ScreenGameplay overlay/tip")..{
            OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,0.6;effectcolor2,1,1,1,1.0);
        },
    },

    Def.BitmapText{
		Font="_eurostile normal",
		OnCommand=cmd(y,1;zoom,.5;shadowlength,0);
		CurrentSongChangedMessageCommand=cmd(playcommand, "Update");
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

    	LoadActor("ScreenGameplay overlay/meter frame")..{ OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2;cropleft,0.5;x,SCREEN_WIDTH/5); },
    	LoadActor("ScreenGameplay overlay/meter frame")..{ OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2;cropright,0.5;x,SCREEN_WIDTH/-5); },
    	LoadActor("ScreenGameplay overlay/meter frame")..{ OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2;cropright,0.1;cropleft,0.1;x,0); },
	},



	-- Difficulty time
	Def.ActorFrame{
	OnCommand=cmd(sleep,0.5;queuecommand, "TweenOn");
	OffCommand=cmd(queuecommand, "TweenOff");
	ShowGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOn");
	HideGameplayTopFrameMessageCommand=cmd(playcommand, "TweenOff");

		Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1),
		OnCommand=cmd(x,SCREEN_LEFT+150;y,SCREEN_TOP+60;addx,-250);
		TweenOnCommand=cmd(decelerate,0.8;addx,250);
		TweenOffCommand=cmd(accelerate,0.8;addx,-250);

			LoadActor( THEME:GetPathG('','_difficulty icons') )..{
				OnCommand=cmd(animate,0;playcommand, "Update");
				CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
				CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
				UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_1) ) end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,-35,0;horizalign,left;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( DifficultyName("Steps", PLAYER_1) )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,35,0;horizalign,right;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

		},

		Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2),
		OnCommand=cmd(x,SCREEN_RIGHT-150;y,SCREEN_TOP+60;addx,250);
		TweenOnCommand=cmd(decelerate,0.8;addx,-250);
		TweenOffCommand=cmd(accelerate,0.8;addx,250);

			LoadActor( THEME:GetPathG('','_difficulty icons') )..{
				OnCommand=cmd(animate,0;playcommand, "Update");
				CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
				CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
				UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_2) ) end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,-35,0;horizalign,left;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
					self:settext( DifficultyName("Steps", PLAYER_2) )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

			Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,35,0;horizalign,right;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},
		},

	},



	Def.Quad{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffuse,0,0,0,1;sleep,0.5;linear,0.5;diffusealpha,0);
	},
}