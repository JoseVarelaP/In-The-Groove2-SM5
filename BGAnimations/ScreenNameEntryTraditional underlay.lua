local t = Def.ActorFrame{
	CodeMessageCommand=function(self,param)
		local ts = SCREENMAN:GetTopScreen()
		-- check if player is done entering name, or if screen is transitioning
		if ts:GetFinalized(param.PlayerNumber) or ts:IsTransitioning() then
			return
		end

		-- otherwise, handle inputs.
		-- param.PlayerNumber
		-- param.Name: "Left","Right","Backspace","Enter"

		if param.Name == "Left" or param.Name == "AltLeft" then
			MESSAGEMAN:Broadcast("KeyboardLeft",{Player=param.PlayerNumber})
		elseif param.Name == "Right" or param.Name == "AltRight" then
			MESSAGEMAN:Broadcast("KeyboardRight",{Player=param.PlayerNumber})
		elseif param.Name == "Backspace" then
			ts:Backspace(param.PlayerNumber)
			MESSAGEMAN:Broadcast("UpdateSelection",{Player=param.PlayerNumber})
		elseif param.Name == "Enter" then
			MESSAGEMAN:Broadcast("KeyboardEnter",{Player=param.PlayerNumber})

			-- todo: run any checks needed here?
		end
	end
}

t[#t+1] = LoadActor("ScreenWithMenuElements underlay")

local stages,stgindex = {},1
for i,v in ipairs( STATSMAN:GetAccumPlayedStageStats():GetPlayedSongs() ) do
	stages[#stages+1] = v
end

t[#t+1] = Def.Sprite{
	Texture=THEME:GetPathG("Evaluation","banner frame mask"),
	Condition=not ThemePrefs.Get("ITG1"),
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
	OnCommand=function(self)
		self:zwrite(1):z(1):blend("BlendMode_NoEffect"):y(SCREEN_TOP-100):decelerate(0.5):y(SCREEN_CENTER_Y-138):zoom(1.02)
	end,
	OffCommand=function(self)
		self:accelerate(0.5):addy(-SCREEN_CENTER_X)
	end
}

t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1"), {"banner mask",194,1} )..{
	Condition=ThemePrefs.Get("ITG1"),
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-38) end,
	OnCommand=function(self)
		-- self:zwrite(1):z(1):blend("BlendMode_NoEffect")
		self:addy(-200):decelerate(0.5):addy(200)
	end,
	OffCommand=function(self)
		self:accelerate(0.3):addy(-SCREEN_CENTER_X)
	end
}

local ni=0 
t[#t+1] = Def.Banner{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126)
		self:LoadFromSong( stages[stgindex] )
	end,
	OnCommand=function(self)
		self:setsize(418/2,164/2):ztest(1):y(-100):decelerate(0.5):y(SCREEN_CENTER_Y-138)
	end,
	OffCommand=function(self)
		self:accelerate(0.5):addy(-SCREEN_CENTER_X)
	end,
	ChangeDisplayedFeatMessageCommand=function(self,param)
		stgindex = param.CurrentIndex
		ni = param.NewIndex
		self:linear(0.1):diffusealpha(0):queuecommand("UpdateImage")
	end,
	UpdateImageCommand=function(self)
		self:LoadFromSong( stages[ni] ):setsize(438/2,164/2):linear(0.5):diffusealpha(1)
	end
}

t[#t+1] = Def.Sprite{
	Texture=THEME:GetPathG("ScreenEvaluation banner","frame"),
	Condition=not ThemePrefs.Get("ITG1"),
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-138)
		:addy(-200):decelerate(0.5):addy(200)
	end,
	OffCommand=function(self)
		self:accelerate(0.5):addy(-SCREEN_CENTER_X)
	end
}

t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1"), {"banner frame",194} )..{
	Condition=ThemePrefs.Get("ITG1"),
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-138) end,
	OnCommand=function(self)
		self:addy(-200):decelerate(0.5):addy(200)
	end,
	OffCommand=function(self)
		self:accelerate(0.3):addy(-SCREEN_CENTER_X)
	end
}

local function side(pn)
	local s = 1
	if pn == PLAYER_1 then return s end
	return s*(-1)
end

local function pnum(pn)
	if pn == PLAYER_2 then return 2 end
	return 1
end

local function TrailOrSteps(pn)
	if GAMESTATE:IsCourseMode() then return GAMESTATE:GetCurrentTrail(pn) end
	return GAMESTATE:GetCurrentSteps(pn)
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "Keyboard" .. PlayerNumberToString(pn)
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Keyboard"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
		end,
		OnCommand=function(self)
			self:xy(
				pn == PLAYER_1 and SCREEN_CENTER_X-157 or SCREEN_CENTER_X+157,
				SCREEN_CENTER_Y-10
			)
			:addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH )
			:decelerate(0.5):addx( pn == PLAYER_1 and SCREEN_WIDTH or -SCREEN_WIDTH )
		end,
		OffCommand=function(self) self:accelerate(0.5):addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH ) end
	}

	t[#t+1] = LoadActor( THEME:GetPathG("ScreenNameEntryTraditional","Wheel"),pn)..{
		InitCommand=function(self) self:player(pn) end,
		OnCommand=function(self)
			self:xy(
				pn == PLAYER_1 and SCREEN_CENTER_X-157 or SCREEN_CENTER_X+157,
				SCREEN_CENTER_Y+90
			)
			:addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH )
			:decelerate(0.5):addx( pn == PLAYER_1 and SCREEN_WIDTH or -SCREEN_WIDTH )
		end,
		OffCommand=function(self) self:accelerate(0.5):addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH ) end
	}

	t[#t+1] = LoadFont("ScreenNameEntryTraditional entry")..{
		InitCommand=function(self)
			self:halign(0):zoom(1.1)
			:xy(
				pn == PLAYER_1 and SCREEN_CENTER_X-255 or SCREEN_CENTER_X+255,
				SCREEN_CENTER_Y-65
			)
		end,
		EntryChangedMessageCommand=function(self,param)
			if param.PlayerNumber == pn then
				self:settext(param.Text)
			end
		end,
		OffCommand=function(s) s:accelerate(0.5):addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH ) end
	}

	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
			self:xy(
			pn == PLAYER_1 and SCREEN_CENTER_X-214 or SCREEN_CENTER_X+214,
			SCREEN_CENTER_Y-118
			)
			:addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH )
			:decelerate(0.5):addx( pn == PLAYER_1 and SCREEN_WIDTH or -SCREEN_WIDTH )
		end,
		OffCommand=function(self) self:accelerate(0.5):addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH ) end,
		
		Def.Sprite{ Texture=THEME:GetPathG("NameEntry","Items/BGA score frame") },

		Def.BitmapText{
			Font="_futurist metal",
			OnCommand=function(self)
				self:diffuse(PlayerColor(pn))
				if STATSMAN:GetPlayedStageStats( ni ) and STATSMAN:GetPlayedStageStats( ni ):GetPlayerStageStats(pn) then
					self:settext( string.format( "%.2f%%", STATSMAN:GetPlayedStageStats( ni ):GetPlayerStageStats(pn):GetPercentDancePoints()*100 ) )
				end
			end,
			ChangeDisplayedFeatMessageCommand=function(self,param)
				if STATSMAN:GetPlayedStageStats( ni ) and STATSMAN:GetPlayedStageStats( ni ):GetPlayerStageStats(pn) then
					self:settext( string.format( "%.2f%%", STATSMAN:GetPlayedStageStats( ni ):GetPlayerStageStats(pn):GetPercentDancePoints()*100 ) )
				end
			end
		}
	}

	t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:xy(
			pn == PLAYER_1 and SCREEN_CENTER_X-214 or SCREEN_CENTER_X+214,
			SCREEN_CENTER_Y-160
		)
	end,
	OffCommand=function(self) self:accelerate(0.5):addx( pn == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH ) end,
	ChangeDisplayedFeatMessageCommand=function(self)
		self:stoptweening():linear(0.2):diffusealpha(0.4):linear(0.2):diffusealpha(1)
	end,
		Def.Sprite{
			Texture=THEME:GetPathG('','_difficulty icons'),
			OnCommand=function(self)
				self:xy(0,0):animate(0):playcommand("Update")
			end,
			UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(pn,true) ) end,
		},	
		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):x( -38*side(pn) )
				:halign( pnum(pn)-1 ):playcommand("Update")
			end,
			ChangeDisplayedFeatMessageCommand=function(self,param)
				local stats = STATSMAN:GetPlayedStageStats( stgindex ):GetPlayerStageStats(pn):GetPlayedSteps()
				self:settext( THEME:GetString("Difficulty",ToEnumShortString(stats[1]:GetDifficulty()) ) )
				:diffuse( ContrastingDifficultyColor( stats[1]:GetDifficulty() ) )
			end
		},	
		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):x(36*side(pn)):horizalign(pn == PLAYER_1 and right or left):playcommand("Update")
			end,
			ChangeDisplayedFeatMessageCommand=function(self,param)
				local stats = STATSMAN:GetPlayedStageStats( stgindex ):GetPlayerStageStats(pn):GetPlayedSteps()
				self:settext( stats[1]:GetMeter() )
				:diffuse( ContrastingDifficultyColor( stats[1]:GetDifficulty() ) )
			end
		}
	}
end

local function IsAnyPlayerUsingMemoryCard()
	for player in ivalues(PlayerNumber) do
		if MEMCARDMAN:GetCardState(player) == "MemoryCardState_ready" then
			return true
		end
	end
	return false
end

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:xy(35,38)
	end,

	Def.BitmapText{
		Font=_eurostileColorPick(),
		Text=string.upper(THEME:GetString("ScreenNameEntryTraditional","HeaderText")),
		InitCommand=function(self) self:shadowlength(4):x(self:GetWidth()/2):skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
		end,
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end
	}
}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(color("0,0,0,0"))
	end,
	OffCommand=function(self)
		self:linear(0.5):diffuse(Color.Black)
	end
}

if IsAnyPlayerUsingMemoryCard() then
	t[#t+1] = Def.Sprite{
		Texture="_red streak",
		OnCommand=function(self)
			self:Center():zoom(0.5):fadeleft(0.3):cropleft(1.3):cropright(-0.3)
		end,
		OffCommand=function(self)
			self:linear(0.5):cropleft(-0.3):zoom(1.5)
		end
	}
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("","_saving"),
		OnCommand=function(self)
			self:Center():addx(SCREEN_WIDTH)
		end,
		OffCommand=function(self)
			self:decelerate(0.5):addx(-SCREEN_WIDTH)
		end
	}
end


return t