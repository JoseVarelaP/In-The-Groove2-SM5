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

t[#t+1] = Def.ActorFrame{
	Def.Sprite{ Texture="base frame" },

	Def.ActorFrame{
	OnCommand=function(self)
		self:xy(-95*side(player),-149)
	end;
		Def.Sprite{
			Texture=THEME:GetPathG('','_difficulty icons'),
			OnCommand=function(self)
				self:xy(0,0):animate(0):playcommand("Update")
			end;
			UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(player,true) ) end,
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):x( -38*side(player) )
				:halign( pnum(player)-1 ):playcommand("Update");
			end;
			UpdateCommand=function(self)
					local steps = TrailOrSteps(player):GetDifficulty();
						if GAMESTATE:IsCourseMode() then
							self:settext( DifficultyName("Trail", player) )
						else
							self:settext( DifficultyName("Steps", player) )
						end
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				self:zoom(0.5):x(36*side(player)):horizalign(player == PLAYER_1 and right or left):playcommand("Update")
			end;
			UpdateCommand=function(self)
					self:settext( TrailOrSteps(player):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( TrailOrSteps(player):GetDifficulty() ) )
				end,
			},
	};

		Def.GraphDisplay{
			InitCommand=function(self)
				self:y(-36)
			end,
			BeginCommand=function(self)
				self:Load("GraphDisplayP"..pnum(player))
				local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
				local stageStats = STATSMAN:GetCurStageStats()
				self:Set(stageStats, playerStageStats)
			end,
		},

		Def.ComboGraph{
			InitCommand=function(self)
				self:y(-7)
			end,
			BeginCommand=function(self)
				self:Load("ComboGraphP"..pnum(player))
				local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
				local stageStats = STATSMAN:GetCurStageStats()
				self:Set(stageStats, playerStageStats)
			end,
		},

	-- Grade time

	
	Def.BitmapText{
		 Font="_futurist metalic", Text=CalculatePercentage(player), OnCommand=function(self)
			self:horizalign(right):xy(115,-82):diffuse(PlayerColor(player))
		end
	},

	
	Def.BitmapText{
		 Font="_eurostile normal", Text=optionslist, OnCommand=function(self)
			self:xy(45,-112):zoom(0.5):shadowlength(2):wrapwidthpixels(400)
		end
	},

	Def.BitmapText{ Font="_eurostile blue glow", Text="Disqualified from ranking",
	Condition=GetPSStageStats(player):IsDisqualified();
	OnCommand=function(self)
		self:xy(45,-65):zoom(0.5):shadowlength(2):wrapwidthpixels(400)
	end,
	},

	LoadActor( "../ComboAwards/"..ComboAward..".lua" ),
	LoadActor( "../ComboAwards/"..DiffAward..".lua" ),
};

-- Info regarding all judgment data
local JudgmentInfo = {
	Types = { 'W1', 'W2', 'W3', 'W4', 'W5', 'Miss' },
	Names = { "Fantastic", "Excellent", "Great", "Decent", "Way Off", "Miss" },
	RadarVal = { "Jumps", "Holds", "Mines", "Hands", "Rolls" },
};

for index, ValTC in ipairs(JudgmentInfo.Names) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:xy(-128,31-18) end;
		Def.BitmapText{ Font="_eurostile normal", Text=ValTC,
		OnCommand=function(self)
			self:y(16*index):zoom(0.5):horizalign(left):shadowlength(0)
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
		OnCommand=function(self) self:xy(-18,31-16) end;
		Def.BitmapText{ Font="ScreenEvaluation judge",
		OnCommand=function(self)
			self:y(16*index):zoom(0.5):halign(1):diffuse( PlayerColor(player) )
			local sco = GetPSStageStats(player):GetTapNoteScores("TapNoteScore_"..ScWin)
			self:settext(("%04.0f"):format( sco )):diffuse( PlayerColor(player) )
			local leadingZeroAttr = { Length=4-tonumber(tostring(sco):len()); Diffuse=PColor[player] }
			self:AddAttribute(0, leadingZeroAttr )
		end;
		};
	};
end


for index, RCType in ipairs(JudgmentInfo.RadarVal) do
	local performance = GetPSStageStats(player):GetRadarActual():GetValue( "RadarCategory_"..RCType )
	local possible = GetPSStageStats(player):GetRadarPossible():GetValue( "RadarCategory_"..RCType )

	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:xy(128,31-16) end;

		Def.BitmapText{ Font="ScreenEvaluation judge",
		OnCommand=function(self)
			self:xy( -40, 16*index ):zoom(0.5):halign(1)
			self:settext(("%03.0f"):format(performance)):diffuse( PlayerColor(player) )
			local leadingZeroAttr = { Length=3-tonumber(tostring(performance):len()); Diffuse=PColor[player] }
			self:AddAttribute(0, leadingZeroAttr )
		end;
		};
		
		Def.BitmapText{ Font="ScreenEvaluation judge",
		OnCommand=function(self)
			self:y( 16*index ):zoom(0.5):halign(1)
			self:settext(("%03.0f"):format(possible)):diffuse( PlayerColor(player) )
			local leadingZeroAttr = { Length=3-tonumber(tostring(possible):len()); Diffuse=PColor[player] }
			self:AddAttribute(0, leadingZeroAttr )
		end;
		};

		Def.BitmapText{ Font="Common Normal", Text=RCType,
		OnCommand=function(self)
			self:xy( -125, 16*index -1 ):zoom(0.5):halign(0)
		end;
		};

		Def.BitmapText{ Font="ScreenEvaluation judge", Text="/",
		OnCommand=function(self)
			self:xy( -40, 16*index -1 ):zoom(0.5):halign(0):diffuse( PlayerColor(player) )
		end;
		};

	};
end

-- Max Combo
t[#t+1] = Def.ActorFrame{
	Def.BitmapText{ Font="Common Normal", Text="Max Combo",
	OnCommand=function(self)
		self:xy( 3, 16*7-2 ):zoom(0.5):halign(0):maxwidth(140)
	end;
	};

	Def.BitmapText{ Font="ScreenEvaluation judge";
	OnCommand=function(self)
		self:xy( 128, 16*7-1 ):zoom(0.5):halign(1)
		local combo = GetPSStageStats(player):MaxCombo()
		self:settext( ("%05.0f"):format( combo ) )

		local leadingZeroAttr = { Length=5-tonumber(tostring(combo):len()); Diffuse=PColor[player] }
		self:AddAttribute(0, leadingZeroAttr )

		:diffuse( PlayerColor(player) )
	end;
	};
}


return t;