local args=...
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
	-- 'RadarCategory_Fakes'			13
	-- 'RadarCategory_Lifts'			12
	local SongOrCourse, StepsOrTrail;
	if GAMESTATE:IsCourseMode() then
		SongOrCourse = GAMESTATE:GetCurrentCourse();
		StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
	else
		SongOrCourse = GAMESTATE:GetCurrentSong();
		StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
	end;

	if GAMESTATE:IsPlayerEnabled(pn) and (SongOrCourse and StepsOrTrail) then
		return StepsOrTrail:GetRadarValues(pn):GetValue(n)
	end
	return 0
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
		if PROFILEMAN:IsPersistentProfile(pn) then
			-- args profile
			profile = PROFILEMAN:GetProfile(pn);
		else
			-- machine profile
			profile = PROFILEMAN:GetMachineProfile();
		end;
		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		local topscore = scores[1];
		if topscore then
			text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
			Rname = topscore:GetName()
			-- 100% hack
			if text == "100.00%" then
				text = "100%";
			end;
		else
			text = string.format("%.2f%%", 0);
		end;
	else
		text = "";
	end;
	return {text,Rname}
end


local t = Def.ActorFrame{}

if ThemePrefs.Get("ITG1") then
	t[#t+1] = LoadActor( THEME:GetPathB("","_frame 3x1") , {"footer",250});
else
	t[#t+1] = LoadActor( THEME:GetPathG('PaneDisplay','Frame') );
end

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
				InitCommand=function(s)
					s:zoom(0.5):xy(
						ObtainData[ind].xpos[1] + (args == PLAYER_2 and 55 or 0)
						,-24+14*(vind-1)):halign(0)
				end;
				["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					-- replace
					if GAMESTATE:GetCurrentSteps(args) and val[1] and type(val[1]) == "function" then
						s:settext( val[1]() )
					end
				end;
			};
			t[#t+1] = Def.BitmapText{
				Font="_eurostile normal",
				Text=val[2],
				InitCommand=function(s)
					s:zoom(0.5):xy(
						ObtainData[ind].xpos[2] + (args == PLAYER_2 and 55 or 0)
						,-24+14*(vind-1)):halign(1)
				end;
				["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentSteps(args) and val[2] then
						s:settext( val[2]() )
					end
				end;
			};
		end
	end
	t[#t+1] = Def.BitmapText{
		Font="_futurist normal",
		InitCommand=function(s) s:x(ObtainData.DiffPlacement):y(-24+13) end;
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
		if StepsOrCourse() then
			s:settext( StepsOrCourse():GetMeter() )
			:diffuse( DifficultyColor( StepsOrCourse():GetDifficulty() ) )
		end
	end
	};
	t[#t+1] = Def.BitmapText{
		Font="_eurostile normal",
		InitCommand=function(self) self:x(ObtainData.DiffPlacement):y(-24+38):maxwidth(90):zoom(0.6) end;
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
		if StepsOrCourse() then
			s:settext(
				string.upper( 
					THEME:GetString("Difficulty", ToEnumShortString( StepsOrCourse():GetDifficulty() ) )
				)
			)
			:diffuse( DifficultyColor( StepsOrCourse():GetDifficulty() ) )
		end
	end
	};
end

return t;