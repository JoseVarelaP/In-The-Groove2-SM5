local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="ScreenGameplay overlay/demonstration gradient",
	OnCommand=function(self)
		self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.8)
	end
}

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:xy( SCREEN_CENTER_X,SCREEN_TOP+24 ):addy(-100):sleep(0.5):decelerate(0.8):addy(100) end,
	OffCommand=function(self) self:accelerate(0.8):addy(-100) end,

	Def.SongMeterDisplay{
        InitCommand=function(self) self:SetStreamWidth(SCREEN_WIDTH/1.17) end,
        Stream=Def.Sprite{ Texture="ScreenGameplay overlay/meter stream",
        	InitCommand=function(self) self:diffusealpha(1) end
        },
        Tip=Def.Sprite{ Texture="ScreenGameplay overlay/tip",
            OnCommand=function(self) self:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0) end,
		},
	},

	Def.BitmapText{
		Font="_eurostile normal",
		OnCommand=function(self) self:y(1):zoom(.5):shadowlength(0) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
		UpdateCommand=function(self)
			if not GAMESTATE:IsCourseMode() then
				self:settext( GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
			else
				self:settext( GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().." - "..GAMESTATE:GetCurrentSong():GetDisplayFullTitle() )
			end
			self:maxwidth(SCREEN_WIDTH+80)
		end
	}
}

local meterbar = { {0.5,0,SCREEN_WIDTH/5},{0,0.5,SCREEN_WIDTH/-5},{0.1,0.1,0} }
for v in ivalues(meterbar) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:xy( SCREEN_CENTER_X,24 ):addy(-100):sleep(0.5):decelerate(0.8):addy(100) end,
		OffCommand=function(self) self:accelerate(0.8):addy(-100) end,
		Def.Sprite{
			Texture="ScreenGameplay Overlay/meter frame",
			OnCommand=function(self) self:zoomtowidth(SCREEN_WIDTH/2):cropright(v[2]):cropleft(v[1]):x(v[3]) end
		}
	}
end

for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(player),
		OnCommand=function(self) self:xy( player == PLAYER_1 and SCREEN_LEFT-50 or SCREEN_RIGHT+50,SCREEN_TOP+60):queuecommand("TweenOn") end,
		TweenOnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx( player == PLAYER_1 and 250 or -250) end,
		OffCommand=function(self) self:accelerate(0.8):addx( player == PLAYER_1 and -250 or 250) end,

		Def.Sprite{
			Texture=THEME:GetPathG('','_difficulty icons'),
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:setstate( SetFrameDifficulty(player) ) end,
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self) self:zoom(0.5):x(-35):halign(0):playcommand("Update") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(player):GetDifficulty()
				self:settext( DifficultyName("Steps", player) ):diffuse( ContrastingDifficultyColor( steps ) )
			end
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):xy(35,0):horizalign(right):playcommand("Update")
			end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(player)
				self:settext( steps:GetMeter() ):diffuse( ContrastingDifficultyColor( steps:GetDifficulty() ) )
			end
		}
	}
end

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(0,0,0,1):sleep(0.5):linear(0.5):diffusealpha(0)
	end
}

return t