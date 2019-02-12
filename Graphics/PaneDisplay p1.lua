function RadarValue(pn,n)
	-- 'RadarCategory_Stream'			0
	-- 'RadarCategory_Voltage'			1
	-- 'RadarCategory_Air'				2
	-- 'RadarCategory_Freeze'			3
	-- 'RadarCategory_Chaos'			4
	-- 'RadarCategory_Notes'			5
	-- 'RadarCategory_TapsAndHolds'		6
	-- 'RadarCategory_Jumps'			7
	-- 'RadarCategory_Holds'			8
	-- 'RadarCategory_Mines'			9
	-- 'RadarCategory_Hands'			10
	-- 'RadarCategory_Rolls'			11
	-- 'RadarCategory_Lifts'			12
	-- 'RadarCategory_Fakes'			13
	if GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:IsHumanPlayer(pn) then
		return GAMESTATE:GetCurrentSteps(pn):GetRadarValues(pn):GetValue(n)
	else
		return 0
	end
end

return Def.ActorFrame{
	LoadActor( THEME:GetPathG('PaneDisplay','Frame') ),

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Steps", InitCommand=function(self)
			self:x(-125):y(-24+14*0)
		end
	},
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=function(self)
		self:x(-25):y(-24+14*0)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 5) ) else self:settext("?") end end, },

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Holds", InitCommand=function(self)
			self:x(-125):y(-24+14*1)
		end
	},
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=function(self)
		self:x(-25):y(-24+14*1)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 8) ) else self:settext("?") end end, },

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Best", InitCommand=function(self)
			self:x(-125):y(-24+14*2)
		end
	},
	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Card", InitCommand=function(self)
			self:x(-125):y(-24+14*3)
		end
	},

	Def.BitmapText{ Font="_futurist normal", Text="number", InitCommand=function(self)
		self:x(100):y(-24+13)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self)
	if GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetCurrentTrail(PLAYER_1) then
			self:settext( GAMESTATE:GetCurrentTrail(PLAYER_1):GetMeter() )
			self:diffuse( DifficultyColor( GAMESTATE:GetCurrentTrail(PLAYER_1):GetDifficulty() ) )
		end
	else
		if GAMESTATE:GetCurrentSteps(PLAYER_1) then
			self:settext( GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter() )
			self:diffuse( DifficultyColor( GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() ) )
		end
	end
	end,
	},
	Def.BitmapText{ Font="_eurostile normal", Text="diff", InitCommand=function(self)
		self:x(100):y(-24+38)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self)
	self:maxwidth(90)
	if GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetCurrentTrail(PLAYER_1) then
			self:settext( string.upper( DifficultyName( "Trail", PLAYER_1 ) ) )
			self:diffuse( DifficultyColor( GAMESTATE:GetCurrentTrail(PLAYER_1):GetDifficulty() ) )
		end
	else
		if GAMESTATE:GetCurrentSteps(PLAYER_1) then
			self:settext( string.upper( DifficultyName( "Steps", PLAYER_1 ) ) )
			self:diffuse( DifficultyColor( GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() ) )
		end
	end
	end,

	},

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Jumps", InitCommand=function(self)
			self:x(-15):y(-24+14*0)
		end
	},
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=function(self)
		self:x(70):y(-24+14*0)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 7) ) else self:settext("?") end end, },

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Mines", InitCommand=function(self)
			self:x(-15):y(-24+14*1)
		end
	},
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=function(self)
		self:x(70):y(-24+14*1)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 9) ) else self:settext("?") end end, },

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Hands", InitCommand=function(self)
			self:x(-15):y(-24+14*2)
		end
	},
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=function(self)
		self:x(70):y(-24+14*2)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 10) ) else self:settext("?") end end, },

	
	Def.BitmapText{
		 Font="_eurostile normal", Text="Rolls", InitCommand=function(self)
			self:x(-15):y(-24+14*3)
		end
	},
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=function(self)
		self:x(70):y(-24+14*3)
	end;
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 11) ) else self:settext("?") end end, },

}