local args=...
function RadarValue(pn,n)
	-- Maybe categorize this in another format

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
	-- 'RadarCategory_Fakes'			13
	-- 'RadarCategory_Lifts'			12
	local SongOrCourse, StepsOrTrail, Result;
	if GAMESTATE:IsCourseMode() then
		SongOrCourse = GAMESTATE:GetCurrentCourse();
		StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
	else
		SongOrCourse = GAMESTATE:GetCurrentSong();
		StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
	end;

	if GAMESTATE:IsPlayerEnabled(pn) and (SongOrCourse and StepsOrTrail) then
		Result = StepsOrTrail:GetRadarValues(pn):GetValue(n)
	end
	return Result and (Result > 0 and Result or "???") or 0
end

local function PercentScore(pn,scoremethod)
	local SongOrCourse, StepsOrTrail;
	if GAMESTATE:IsCourseMode() then
		SongOrCourse = GAMESTATE:GetCurrentCourse();
		StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
	else
		SongOrCourse = GAMESTATE:GetCurrentSong();
		StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
	end;
	local profile, scorelist;
	local text,Rname = "","Best";
	if SongOrCourse and StepsOrTrail then
		-- args profile
		profile = PROFILEMAN:IsPersistentProfile(pn) and PROFILEMAN:GetProfile(pn) or PROFILEMAN:GetMachineProfile();
		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		local topscore = scores[1];
		if topscore then
			text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
			Rname = topscore:GetName()
			text = text == "100.00%" and "100%" or text -- 100% hack
		else
			text = string.format("%.2f%%", 0);
		end;
	else
		text = "";
	end;
	return {text,Rname}
end

local t = Def.ActorFrame{
	LoadActor( THEME:GetPathG('PaneDisplay','Frame') ),
}

if GAMESTATE:IsPlayerEnabled(args) then
	local StepsOrCourse = function() return GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(args) or GAMESTATE:GetCurrentSteps(args) end
	local ObtainData = {
		--LEFT SIDE
		{
			{"Steps", function() return StepsOrCourse() and RadarValue(args, 5) or 0 end },
			{"Holds", function() return StepsOrCourse() and RadarValue(args, 8) or 0 end },
			{function() return PercentScore(args)[2] end, function() return PercentScore(args)[1] end },
			{"Card", function() return PercentScore(args)[1] end },
			xpos = {-125,-25},
		},
		--RIGHT SIDE
		{
			{"Jumps", function() return StepsOrCourse() and RadarValue(args, 7) or 0 end },
			{"Mines", function() return StepsOrCourse() and RadarValue(args, 9) or 0 end },
			{"Hands", function() return StepsOrCourse() and RadarValue(args, 10) or 0 end },
			{"Rolls", function() return StepsOrCourse() and RadarValue(args, 11) or 0 end },
			xpos = {-15,70},
		},
		DiffPlacement = args == PLAYER_1 and 102 or -102
	}
	for ind,content in ipairs(ObtainData) do
		for vind,val in ipairs( ObtainData[ind] ) do
			t[#t+1] = Def.BitmapText{
				Font="_eurostile normal",
				Text=val[1],
				InitCommand=function(self)
					self:zoom(0.5):xy(
						ObtainData[ind].xpos[1] + (args == PLAYER_2 and 55 or 0)
						,-24+14*(vind-1)):halign(0)
				end;
				["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentSteps(args) and val[1] and type(val[1]) == "function" then s:settext( val[1]() ) end
				end;
				["CurrentTrail"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentTrail(args) and val[1] and type(val[1]) == "function" then s:settext( val[1]() ) end
				end;
			};
			t[#t+1] = Def.BitmapText{
				Font="_eurostile normal",
				Text=val[2],
				InitCommand=function(self)
					self:zoom(0.5):xy(
						ObtainData[ind].xpos[2] + (args == PLAYER_2 and 55 or 0)
						,-24+14*(vind-1)):halign(1)
				end;
				["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentSteps(args) and val[2] then s:settext( val[2]() ) end
				end;
				["CurrentTrail"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentTrail(args) and val[2] then s:settext( val[2]() ) end
				end;
			};
		end
	end
	t[#t+1] = Def.BitmapText{
		Font="_futurist normal",
		InitCommand=function(self) self:x(ObtainData.DiffPlacement):y(-24+13) end;
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSong() and not GAMESTATE:IsCourseMode() then
				self:settext( GAMESTATE:GetCurrentSteps(args):GetMeter() )
				self:diffuse( DifficultyColor( GAMESTATE:GetCurrentSteps(args):GetDifficulty() ) )
			end
		end;
		["CurrentTrail"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentCourse() then
				self:settext( GAMESTATE:GetCurrentTrail(args):GetMeter() )
				self:diffuse( DifficultyColor( GAMESTATE:GetCurrentTrail(args):GetDifficulty() ) )
			end
		end;
	};
	t[#t+1] = Def.BitmapText{
		Font="_eurostile normal",
		InitCommand=function(self) self:x(ObtainData.DiffPlacement):y(-24+38):maxwidth(90):zoom(0.6) end;
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSong() and not GAMESTATE:IsCourseMode(9) then
				self:settext(
					string.upper( 
						THEME:GetString("Difficulty", ToEnumShortString( GAMESTATE:GetCurrentSteps(args):GetDifficulty() ) )
					)
				)
				self:diffuse( DifficultyColor( GAMESTATE:GetCurrentSteps(args):GetDifficulty() ) )
			end
		end;
		["CurrentTrail"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentCourse() then
				self:settext(
					string.upper( 
						THEME:GetString("CourseDifficulty", ToEnumShortString( GAMESTATE:GetCurrentTrail(args):GetDifficulty() ) )
					)
				)
				self:diffuse( DifficultyColor( GAMESTATE:GetCurrentTrail(args):GetDifficulty() ) )
			end
		end;
	};
end

return t;