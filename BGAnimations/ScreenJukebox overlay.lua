local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="ScreenGameplay overlay/demonstration gradient",
	OnCommand=function(self)
		self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.8)
	end;
};

t[#t+1] = Def.ActorFrame{
	OnCommand=function(s) s:xy( SCREEN_CENTER_X,SCREEN_TOP+24 ):addy(-100):sleep(0.5):decelerate(0.8):addy(100) end;
	OffCommand=function(s) s:accelerate(0.8):addy(-100) end;

	Def.SongMeterDisplay{
        InitCommand=function(s) s:SetStreamWidth(SCREEN_WIDTH/1.17) end;
        Stream=Def.Sprite{ Texture="ScreenGameplay overlay/meter stream",
        	InitCommand=function(s) s:diffusealpha(1) end
        },
        Tip=Def.Sprite{ Texture="ScreenGameplay overlay/tip",
            OnCommand=function(s) s:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0) end;
		},
	};

	Def.BitmapText{
		Font="_eurostile normal",
		OnCommand=function(s) s:y(1):zoom(.5):shadowlength(0) end;
		CurrentSongChangedMessageCommand=function(s) s:playcommand("Update") end;
		UpdateCommand=function(s)
		if not GAMESTATE:IsCourseMode() then
			s:settext( GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
		else
			s:settext( GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().." - "..GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
		end
		s:maxwidth(SCREEN_WIDTH+80)
		end,
	};
};

local meterbar = { {0.5,0,SCREEN_WIDTH/5},{0,0.5,SCREEN_WIDTH/-5},{0.1,0.1,0} }
for v in ivalues(meterbar) do
	t[#t+1] = Def.Sprite{
		Texture="meter frame",
		OnCommand=function(s) s:zoomtowidth(SCREEN_WIDTH/2):cropright(v[2]):cropleft(v[1]):x(v[3]) end
	}
end

for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(player),
		OnCommand=function(s) s:xy( player == PLAYER_1 and SCREEN_LEFT-50 or SCREEN_RIGHT+50,SCREEN_TOP+60):queuecommand("TweenOn") end;
		TweenOnCommand=function(s) s:sleep(0.5):decelerate(0.8):addx( player == PLAYER_1 and 250 or -250) end;
		OffCommand=function(s) s:accelerate(0.8):addx( player == PLAYER_1 and -250 or 250) end;

		Def.Sprite{
			Texture=THEME:GetPathG('','_difficulty icons'),
			OnCommand=function(s) s:animate(0):playcommand("Update") end;
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(s) s:playcommand("Update") end;
			UpdateCommand=function(s) s:setstate( SetFrameDifficulty(player) ) end,
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(s) s:zoom(0.5):x(-35):halign(0):playcommand("Update") end;
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(s) s:playcommand("Update") end;
			UpdateCommand=function(s)
				local steps = GAMESTATE:GetCurrentSteps(player):GetDifficulty();
				s:settext( DifficultyName("Steps", player) ):diffuse( ContrastingDifficultyColor( steps ) )
			end,
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(s)
				s:zoom(0.5):xy(35,0):horizalign(right):playcommand("Update")
			end;
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(s) s:playcommand("Update") end;
			UpdateCommand=function(s)
				local steps = GAMESTATE:GetCurrentSteps(player):GetDifficulty();
				s:settext( GAMESTATE:GetCurrentSteps(player):GetMeter() ):diffuse( ContrastingDifficultyColor( steps ) )
			end,
		},
	}
end

t[#t+1] = Def.Quad{
	OnCommand=function(s)
		s:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(0,0,0,1):sleep(0.5):linear(0.5):diffusealpha(0)
	end;
};

return t;