local player = ...
assert( player );

-- This is to obtain data from the options the player has selected.
-- First we get the state. Then the option array, which is a bunch of strings that later give a table.
local PlayerState = GAMESTATE:GetPlayerState(player)
local PlayerOptions = PlayerState:GetPlayerOptionsArray(0)
-- We begin with an empty set.
local optionslist = ""

-- Now set a ipairs instance to get all things.
for k,option in ipairs(PlayerOptions) do
	if k < #PlayerOptions then
		optionslist = optionslist..option..", "
	else
		optionslist = optionslist..option
	end
end

-- This is to set the Combo award.
-- We begin with an empty set.
local ComboAward = "_empty"
local DiffAward = "_empty"

-- If we do get an award, then return the value it gives.
-- I know this is a shit method, but I've tried some others with no success.
if GetPSStageStats(player):GetPeakComboAward() ~= nil then
	if string.len( GetPSStageStats(player):GetPeakComboAward() ) > 1 then
		ComboAward = GetPSStageStats(player):GetPeakComboAward()
	end
end

-- time for checks for each PerDifficulty award.
if GetPSStageStats(player):GetStageAward() ~= nil then
	DiffAward = GetPSStageStats(player):GetStageAward()
end

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

local t = Def.ActorFrame{};

local DoublesIsOn = GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_OnePlayerTwoSides"
local pathtogo = ThemePrefs.Get("ITG1") and "ITG1/" or ""
local itgstylemargin = ThemePrefs.Get("ITG1") and -10 or 0
t[#t+1] = Def.ActorFrame{
	Def.Sprite{ Texture=GAMESTATE:Env()["WorkoutMode"] and pathtogo.."workout frame" or ( GAMESTATE:GetPlayMode() == "PlayMode_Rave" and "battle/".. pathtogo.."base frame battle" or pathtogo.."base frame") }..{
		OnCommand=function(s)
			s:y(itgstylemargin*1.8)
			:x( GAMESTATE:GetPlayMode() == "PlayMode_Rave" and 0 or 0 )
		end
	},

	Def.ActorFrame{
	OnCommand=function(self)
		self:xy( ((DoublesIsOn and -170 or ( GAMESTATE:GetPlayMode() == "PlayMode_Rave" and -75 or -95))+(itgstylemargin*-1)*3)*side(player), (DoublesIsOn and -190 or -149)+itgstylemargin*6 )
	end,
		Def.Sprite{
			Texture=THEME:GetPathG('',ThemePrefs.Get("ITG1") and '_evaluation difficulty icons' or '_difficulty icons'),
			OnCommand=function(self)
				self:animate(0):playcommand("Update")
			end,
			UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(player,true) ) end,
		},

		LoadActor( THEME:GetPathG("_name","frame"), player )..{
			Condition=ThemePrefs.Get("ITG1"),
			OnCommand=function(self) self:y(30) end
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):x( -38*side(player) )
				:halign( pnum(player)-1 ):playcommand("Update")
			end,
			UpdateCommand=function(self)
				local steps = TrailOrSteps(player):GetDifficulty()
				if GAMESTATE:IsCourseMode() then
					self:settext( DifficultyName("Trail", player) )
				else
					self:settext( DifficultyName("Steps", player) )
				end
				self:diffuse( ThemePrefs.Get("ITG1") and Color.Black or ContrastingDifficultyColor( steps ) )
				:shadowlength( ThemePrefs.Get("ITG1") and 1 or 0 )
			end
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):x(36*side(player)):horizalign(player == PLAYER_1 and right or left):playcommand("Update")
			end;
			UpdateCommand=function(self)
				self:settext( TrailOrSteps(player):GetMeter() )
				self:diffuse( ThemePrefs.Get("ITG1") and Color.Black or ContrastingDifficultyColor( TrailOrSteps(player):GetDifficulty() ) )
				:shadowlength( ThemePrefs.Get("ITG1") and 1 or 0 )
			end
		}
	};

		Def.GraphDisplay{
			InitCommand=function(self)
				self:y(-36+(itgstylemargin*1.3))
				if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
					self:xy( 163*side(player), 6+itgstylemargin*1.3 ):rotationz( 90*side(player) )
					:zoomx( 0.85*side(player) )
				end
			end,
			OnCommand=function(self)
				self:Load("GraphDisplayP"..pnum(player))
				local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
				local stageStats = STATSMAN:GetCurStageStats()
				self:Set(stageStats, playerStageStats)
				if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
					self:zoomy(0):sleep(3.2):decelerate(0.5)
					:zoomy(1.6)
				end
			end,
			OffCommand=function(self)
				self:accelerate(0.1):zoomy(0)
			end
		},

		Def.ComboGraph{
			Condition=GAMESTATE:GetPlayMode() ~= "PlayMode_Rave",
			InitCommand=function(self)
				self:y(-7+(itgstylemargin*1.3))
			end,
			OnCommand=function(self)
				self:Load("ComboGraphP"..pnum(player))
				local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
				local stageStats = STATSMAN:GetCurStageStats()
				self:Set(stageStats, playerStageStats)
			end,
		},

	-- Grade time
	Def.Sprite{
		Condition=GAMESTATE:GetPlayMode() == "PlayMode_Rave",
		Texture="battle/Event/win",
		OnCommand=function(self)
		   self:animate(0):xy(0,-114+(itgstylemargin*2.7)):zoom(0.9)
		   :setstate( GAMESTATE:IsDraw() and 2 or ( GAMESTATE:IsWinner(player) and 0 or 1 ) )
	   end
   },

	Def.BitmapText{
		 Font="_futurist metalic", Text=CalculatePercentage(player), OnCommand=function(self)
			self:horizalign(right):xy(115,-82+(itgstylemargin*2.7)):diffuse(PlayerColor(player))
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:xy(60,-88+(itgstylemargin*2.7)):zoom(0.8)
			end
		end
	},

	
	Def.BitmapText{
		Condition=GAMESTATE:GetPlayMode() ~= "PlayMode_Rave",
		 Font="_eurostile normal", Text=optionslist, OnCommand=function(self)
			self:xy(45,-112+(itgstylemargin*2.7)):zoom(0.5):shadowlength(2):wrapwidthpixels(400)
		end
	},

	Def.BitmapText{ Font=_eurostileColorPick(), Text=THEME:GetString("ScreenEvaluation","Disqualified"),
	Condition=GetPSStageStats(player):IsDisqualified();
	OnCommand=function(self)
		self:xy(45,-65+(itgstylemargin*2.5)):zoom(0.5):shadowlength(2):wrapwidthpixels(400)
	end,
	},

	LoadActor( "../ComboAwards/"..ComboAward..".lua" )..{ OnCommand=function(s) s:y(itgstylemargin*1.2) end; };
	LoadActor( "../ComboAwards/"..DiffAward..".lua" )..{ OnCommand=function(s) s:y(itgstylemargin*1.2) end; };
};

-- Info regarding all judgment data
local JudgmentInfo = {
	Types = { 'W1', 'W2', 'W3', 'W4', 'W5', 'Miss' },
	Names = { "Fantastic", "Excellent", "Great", "Decent", "Way Off", "Miss" },
	RadarVal = { "Jumps", "Holds", "Mines", "Hands", "Rolls" },
};

for index, ValTC in ipairs(JudgmentInfo.Types) do
	t[#t+1] = Def.ActorFrame{
		Condition=not GAMESTATE:Env()["WorkoutMode"],
		OnCommand=function(self) self:xy(-128,31-18+itgstylemargin) end;
		Def.BitmapText{ Font="_eurostile normal", Text=THEME:GetString("TapNoteScore",ValTC),
		OnCommand=function(s)
			s:y(16*index):zoom(0.5):horizalign(left):shadowlength(0):maxwidth(130)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				s:xy(60,-94+15.8*index)
			end
		end;
		};
	};
end

local PColor = {
	["PlayerNumber_P1"] = color("#836002"),
	["PlayerNumber_P2"] = color("#2F8425"),
};

for index, ScWin in ipairs(JudgmentInfo.Types) do
	t[#t+1] = Def.ActorFrame{
		Condition=not GAMESTATE:Env()["WorkoutMode"],
		OnCommand=function(self) self:xy(-18,31-16+itgstylemargin) end;
		Def.BitmapText{ Font="ScreenEvaluation judge",
		OnCommand=function(self)
			self:y(16*index):zoom(0.5):halign(1):diffuse( PlayerColor(player) )
			local sco = GetPSStageStats(player):GetTapNoteScores("TapNoteScore_"..ScWin)
			self:settext(("%04.0f"):format( sco )):diffuse( PlayerColor(player) )
			local leadingZeroAttr = { Length=4-tonumber(tostring(sco):len()); Diffuse=PColor[player] }
			self:AddAttribute(0, leadingZeroAttr )
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:xy(84,-96+15.8*index)
			end
		end;
		};
	};
end


for index, RCType in ipairs(JudgmentInfo.RadarVal) do
	local performance = GetPSStageStats(player):GetRadarActual():GetValue( "RadarCategory_"..RCType )
	local possible = GetPSStageStats(player):GetRadarPossible():GetValue( "RadarCategory_"..RCType )

	t[#t+1] = Def.ActorFrame{
		Condition=not GAMESTATE:Env()["WorkoutMode"],
		OnCommand=function(self)
			self:xy(128,31-16+itgstylemargin)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:xy(66,32-18+itgstylemargin)
			end
		end;

		Def.BitmapText{ Font="ScreenEvaluation judge",
		OnCommand=function(self)
			self:xy( -40, 16*index ):zoom(0.5):halign(1)
			self:settext(("%03.0f"):format(performance)):diffuse( PlayerColor(player) )
			local leadingZeroAttr = { Length=3-tonumber(tostring(performance):len()); Diffuse=PColor[player] }
			self:AddAttribute(0, leadingZeroAttr )
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then self:y(15.8*index) end
		end;
		};
		
		Def.BitmapText{ Font="ScreenEvaluation judge",
		OnCommand=function(self)
			self:y( 16*index ):zoom(0.5):halign(1)
			self:settext(("%03.0f"):format(possible)):diffuse( PlayerColor(player) )
			local leadingZeroAttr = { Length=3-tonumber(tostring(possible):len()); Diffuse=PColor[player] }
			self:AddAttribute(0, leadingZeroAttr )
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then self:y(15.8*index) end
		end;
		};

		Def.BitmapText{ Font="Common Normal", Text=THEME:GetString("RadarCategory",RCType),
		OnCommand=function(self)
			self:xy( -125, 16*index -1 ):zoom(0.5):halign(0)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then self:xy(-134,-1+15.8*index) end
		end;
		};

		Def.BitmapText{ Font="ScreenEvaluation judge", Text="/",
		OnCommand=function(self)
			self:xy( -40, 16*index -1 ):zoom(0.5):halign(0):diffuse( PlayerColor(player) )
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then self:y(15.8*index) end
		end;
		};

	};
end

-- Max Combo
t[#t+1] = Def.ActorFrame{
	Condition=not GAMESTATE:Env()["WorkoutMode"],
	OnCommand=function(s)
		if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
			s:xy(-71,-4)
		end
	end;
	Def.BitmapText{ Font="Common Normal", Text="Max Combo",
	OnCommand=function(self)
		self:xy( 3, 16*7-2+itgstylemargin ):zoom(0.5):halign(0):maxwidth(140)
	end;
	};

	Def.BitmapText{ Font="ScreenEvaluation judge";
	OnCommand=function(self)
		self:xy( 128, 16*7-1+itgstylemargin ):zoom(0.5):halign(1)
		local combo = GetPSStageStats(player):MaxCombo()
		self:settext( ("%05.0f"):format( combo ) )

		local leadingZeroAttr = { Length=5-tonumber(tostring(combo):len()); Diffuse=PColor[player] }
		self:AddAttribute(0, leadingZeroAttr )

		:diffuse( PlayerColor(player) )
		if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
			self:x(137)
		end
	end;
	};
}

-- Workout Information Frame
local WorkoutData = {
	Strings = { "Calories Burned", "Total Cals Burned", "Total Play Time", "Fitness Goal" },
	Conditions = { false, false, false, PROFILEMAN:GetProfile(player):GetGoalType() ~= 2 },
	DataLabel = {  "cals", "cals", "mins",
	function()
		if PROFILEMAN:GetProfile(player) then
			local goals = { "cals", "mins", "cals" }
			for i,v in ipairs(goals) do if PROFILEMAN:GetProfile(player):GetGoalType() == i-1 then return v end end
		end
	end },
	DataStructure = {
		STATSMAN:GetCurStageStats(player):GetPlayerStageStats(player):GetCaloriesBurned(),
		STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetCaloriesBurned(),
		(STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetAliveSeconds()/60),
		function()
			if PROFILEMAN:GetProfile(player) then
				local prof = PROFILEMAN:GetProfile(player)
				local goals = { prof:GetGoalCalories(), (prof:GetGoalSeconds()/60), 0 }
				for i,v in ipairs(goals) do
					if prof:GetGoalType() == i-1 then return goals[i] end
				end
			end
		end,
	},
	CompletePercentage = function()
		if PROFILEMAN:GetProfile(player) and PROFILEMAN:GetProfile(player):GetGoalType() ~= 2 then
			local goals = {
				{ PROFILEMAN:GetProfile(player):GetGoalCalories(),STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetCaloriesBurned()},
				{ PROFILEMAN:GetProfile(player):GetGoalSeconds(),STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetAliveSeconds()},
			}
			for i,v in ipairs(goals) do
				if PROFILEMAN:GetProfile(player):GetGoalType() == i-1 then
					return (v[2]/v[1])*100
				end
			end
		end
		return 0
	end,
}

local WorkoutActors = Def.ActorFrame{}
for i,v in ipairs(WorkoutData.Strings) do
	WorkoutActors[#WorkoutActors+1] = Def.BitmapText{ Font="Common Normal",
		Condition=WorkoutData.Conditions[i],
		Text=THEME:GetString("ScreenEvaluation",v),
		OnCommand=function(s) s:xy( -130, (PROFILEMAN:GetProfile(player):GetGoalType() ~= 2 and 16+(16*i) or 16+(20*i))+itgstylemargin ):zoom(0.5):halign(0):maxwidth(300) end;
	}
end
for i,v in ipairs(WorkoutData.DataLabel) do
	WorkoutActors[#WorkoutActors+1] = Def.BitmapText{
		Condition=WorkoutData.Conditions[i],
		Font="Common Normal", Text=THEME:GetString("ScreenEvaluation",type(v) == "function" and v() or v),
		OnCommand=function(s) s:xy( 96, (PROFILEMAN:GetProfile(player):GetGoalType() ~= 2 and 16+(16*i) or 16+(20*i))+itgstylemargin ):zoom(0.5):halign(0) end;
	}
end
for i,v in ipairs(WorkoutData.DataStructure) do
	WorkoutActors[#WorkoutActors+1] = Def.BitmapText{ Font="Common Normal",
		Condition=WorkoutData.Conditions[i],
		Text=string.format( "%.2f", type(v) == "function" and v() or v),
		OnCommand=function(s)
			s:xy( 90, (PROFILEMAN:GetProfile(player):GetGoalType() ~= 2 and 16+(16*i) or 16+(20*i))+itgstylemargin ):zoom(0.5):halign(1):diffuse( PlayerColor(player) )
		end;
	}
end

WorkoutActors[#WorkoutActors+1] = Def.BitmapText{ Font="Common Normal",
	Condition=WorkoutData.Conditions[4],
	Text=string.format( THEME:GetString("ScreenEvaluation","Percent Complete"), WorkoutData.CompletePercentage() ),
	OnCommand=function(s)
		s:xy( 130, 16*7-2+itgstylemargin ):zoom(0.6):halign(1):diffuse( PlayerColor(player) ):maxwidth(210)
	end;
};

WorkoutActors[#WorkoutActors+1] = Def.BitmapText{ Font="Common Normal",
	Text=GAMESTATE:Env()["WorkoutComplete"..player] and WorkoutData.Conditions[4] and THEME:GetString("ScreenEvaluation","Goal Complete!") or THEME:GetString("ScreenEvaluation","Keep Going!"),
	OnCommand=function(s)
		s:xy( -130, 16*7-2+itgstylemargin ):zoom(0.6):halign(0):maxwidth(210)
		if PROFILEMAN:GetProfile(player):GetGoalType() == 2 then s:x( 0 ):halign(0.5) end
		if GAMESTATE:Env()["WorkoutComplete"..player] then s:diffuseshift() end
	end;
};

if GAMESTATE:Env()["WorkoutMode"] then t[#t+1] = WorkoutActors end

return t;