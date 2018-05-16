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

	Def.BitmapText{ Font="_eurostile normal", Text="Steps", InitCommand=cmd(x,-125;y,-24+14*0); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=cmd(x,-25;y,-24+14*0); OnCommand=cmd(horizalign,right;zoom,.5;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 5) ) else self:settext("?") end end, },

	Def.BitmapText{ Font="_eurostile normal", Text="Holds", InitCommand=cmd(x,-125;y,-24+14*1); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=cmd(x,-25;y,-24+14*1); OnCommand=cmd(horizalign,right;zoom,.5;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 8) ) else self:settext("?") end end, },

	Def.BitmapText{ Font="_eurostile normal", Text="Best", InitCommand=cmd(x,-125;y,-24+14*2); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="Card", InitCommand=cmd(x,-125;y,-24+14*3); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },

	Def.BitmapText{ Font="_futurist normal", Text="number", InitCommand=cmd(x,100;y,-24+13); OnCommand=cmd(zoom,1;shadowlength,2;queuemessage, "CurrentStepsP1Changed");
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
	Def.BitmapText{ Font="_eurostile normal", Text="diff", InitCommand=cmd(x,100;y,-24+38); OnCommand=cmd(zoom,0.6;zoomy,0.55;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self)
	self:maxwidth(90)
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

	Def.BitmapText{ Font="_eurostile normal", Text="Jumps", InitCommand=cmd(x,-15;y,-24+14*0); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=cmd(x,70;y,-24+14*0); OnCommand=cmd(horizalign,right;zoom,.5;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 7) ) else self:settext("?") end end, },

	Def.BitmapText{ Font="_eurostile normal", Text="Mines", InitCommand=cmd(x,-15;y,-24+14*1); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=cmd(x,70;y,-24+14*1); OnCommand=cmd(horizalign,right;zoom,.5;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 9) ) else self:settext("?") end end, },

	Def.BitmapText{ Font="_eurostile normal", Text="Hands", InitCommand=cmd(x,-15;y,-24+14*2); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=cmd(x,70;y,-24+14*2); OnCommand=cmd(horizalign,right;zoom,.5;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 10) ) else self:settext("?") end end, },

	Def.BitmapText{ Font="_eurostile normal", Text="Rolls", InitCommand=cmd(x,-15;y,-24+14*3); OnCommand=cmd(horizalign,left;zoom,.5;shadowlength,0); },
	Def.BitmapText{ Font="_eurostile normal", Text="number", InitCommand=cmd(x,70;y,-24+14*3); OnCommand=cmd(horizalign,right;zoom,.5;shadowlength,0);
	CurrentStepsP1ChangedMessageCommand=function(self) if GAMESTATE:GetCurrentSteps(PLAYER_1) then self:settext( RadarValue(PLAYER_1, 11) ) else self:settext("?") end end, },

}