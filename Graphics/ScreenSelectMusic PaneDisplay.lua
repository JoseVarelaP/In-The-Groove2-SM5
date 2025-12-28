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
	return Result and (Result >= 0 and Result or "???") or 0
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
	local profile, scorelist, profilechoose;
	local text,Rname = "",THEME:GetString("PaneDisplay","Best");
	if SongOrCourse and StepsOrTrail then
		-- args profile
		profile = {PROFILEMAN:IsPersistentProfile(pn) and PROFILEMAN:GetProfile(pn),PROFILEMAN:GetMachineProfile()};
		profilechoose = scoremethod and profile[1] or profile[2]
		scorelist = profilechoose:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		local topscore = scores[1];
		if topscore then
			text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
			Rname = topscore:GetName() ~= "" and topscore:GetName() or THEME:GetString("PaneDisplay","Best")
			text = text == "100.00%" and "100%" or text -- 100% hack
		else
			text = string.format("%.2f%%", 0);
		end;
	else
		text = "";
	end;
	return {text,Rname}
end

local style = ThemePrefs.Get("ITG1") and LoadActor( THEME:GetPathB("","_frame 3x1") , {"pane",250}) or LoadActor( THEME:GetPathG('PaneDisplay','Frame') )
local t = Def.ActorFrame{
	style..{
		OnCommand=function(s) s:y( ThemePrefs.Get("ITG1") and -2 or 0 ) end;
	}
}

local levelcolors = { color("#FFFFFF"), color("#00FF00"), color("#FFDD23"), color("#DB6073") }

local scoreCache = {}

if GAMESTATE:IsPlayerEnabled(args) then
	local StepsOrCourse = function() return GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(args) or GAMESTATE:GetCurrentSteps(args) end
	local ObtainData = {
		--LEFT SIDE
		{
			{"Steps", function() return StepsOrCourse() and RadarValue(args, 5) or 0 end, {1,200,350,550} },
			{"Holds", function() return StepsOrCourse() and RadarValue(args, 8) or 0 end, {1,15,30,50} },
			{function() return PercentScore(args)[2] end, function() return PercentScore(args)[1] end },
			{"Card", function() return PercentScore(args,true)[1] end },
			xpos = {-125,-25},
		},
		--RIGHT SIDE
		{
			{"Jumps", function() return StepsOrCourse() and RadarValue(args, 7) or 0 end, {1,25,50,100} },
			{"Mines", function() return StepsOrCourse() and RadarValue(args, 9) or 0 end },
			{"Hands", function() return StepsOrCourse() and RadarValue(args, 10) or 0 end, {1,10,35,75} },
			{"Rolls", function() return StepsOrCourse() and RadarValue(args, 11) or 0 end, {1,10,35,75} },
			xpos = {-15,70},
		},
		DiffPlacement = args == PLAYER_1 and 102 or -102
	}

	t[#t+1] = Def.Actor{
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSteps(args) then
				if NETMAN and NETMAN:IsConnectionEstablished() then
					-- Invalidate the card info to leave way for the online score,
					-- If that's not available, then we can restore back to the local high score.
					local key = GAMESTATE:GetCurrentSteps(args):GetChartKey()
					if scoreCache[key] then
						SCREENMAN:SystemMessage("Using cache for ".. key)
						if scoreCache[key].username then
							SCREENMAN:SystemMessage("Using cache for ".. key .. " - " .. scoreCache[key].username)
							self:GetParent():GetChild("Card"):settext( scoreCache[key].username )
							self:GetParent():GetChild("CardValue"):settext( FormatPercentScore(scoreCache[key].score) )
						end
						return
					end

					NETMAN:FuncHighScoresForChart({
						ChartKey = key,
						Timing = "original",
						Rate = GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate(),
						PlayerNumber = args,
						OnResponse = function (data)
							-- scoresActorFrame:GetChild("LoadIcon"):visible(false)
							local scoredata = data.response.scores
							if not scoredata or #scoredata == 0 then
								scoreCache[key] = {}
								self:GetParent():GetChild("Card"):settext( "N/A" )
								self:GetParent():GetChild("CardValue"):settext( PercentScore(args,true)[1] )
								return
							end

							if key == data.response.metadata.chart_key then
								scoreCache[key] = scoredata[1]
							end

							self:GetParent():GetChild("Card"):settext( scoredata[1].username )
							self:GetParent():GetChild("CardValue"):settext( FormatPercentScore(scoredata[1].score) )
						end
					})
				end
			end
		end;
	}

	for ind,content in ipairs(ObtainData) do
		for vind,val in ipairs( ObtainData[ind] ) do
			t[#t+1] = Def.BitmapText{
				Font="_eurostile normal",
				Name=type(val[1]) == "function" and "Local" or val[1],
				Text=val[1],
				InitCommand=function(self)
					self:zoom(0.5):xy(
						ObtainData[ind].xpos[1] + (args == PLAYER_2 and 55 or 0)
						,-24+14*(vind-1)):halign(0):maxwidth(80)
				end;
				["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentSteps(args) then
						if val[1] and type(val[1]) == "function" then
							s:settext( val[1]() )
						else
							s:settext(THEME:GetString("PaneDisplay",val[1]))
						end
					end
				end;
				["CurrentTrail"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentTrail(args) then
						if val[1] and type(val[1]) == "function" then s:settext( val[1]() ) else s:settext(THEME:GetString("PaneDisplay",val[1])) end
					end
				end;
			};
			t[#t+1] = Def.BitmapText{
				Font="_eurostile normal",
				Name=(type(val[1]) == "function" and "Local" or val[1]).."Value",
				Text=val[2],
				InitCommand=function(self)
					self:zoom(0.5):xy(
						ObtainData[ind].xpos[2] + (args == PLAYER_2 and 55 or 0)
						,-24+14*(vind-1)):halign(1)
				end;
				CurrentSongChangedMessageCommand=function(s) s:diffuse(Color.White):settext("") end;
				["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					s:diffuse(Color.White)
					if GAMESTATE:GetCurrentSteps(args) and val[2] then
						s:settext( val[2]() )
						if val[3] then
							for aqs,v in ipairs( ObtainData[ind][vind][3] ) do
								local meterValue = val[2]()
								if meterValue ~= "???" then
									if meterValue > v then
										s:diffuse( levelcolors[aqs] )
									end
								end
							end
						end

						if val[1] == "Card" then
							s:diffuse(Color.White):stopeffect()
							if (PercentScore(args,true)[1] == PercentScore(args)[1] and PercentScore(args,true)[1] ~= "0.00%") then
								s:diffuseshift():effectcolor1( color("0,1,1,1") )
							end
						end
					end
				end;
				["CurrentTrail"..ToEnumShortString(args).."ChangedMessageCommand"]=function(s)
					if GAMESTATE:GetCurrentTrail(args) and val[2] then
						s:settext( val[2]() )
						if val[3] then
							for aqs,v in ipairs( ObtainData[ind][vind][3] ) do
								if val[2]() ~= "???" and val[2]() > v then
									s:diffuse( levelcolors[aqs] )
								end
							end
						end
					end
				end,
			};
		end
	end
	t[#t+1] = Def.BitmapText{
		Font="_futurist normal",
		InitCommand=function(self) self:x(ObtainData.DiffPlacement):y(-24+13):maxwidth(60) end;
		CurrentSongChangedMessageCommand=function(s) s:settext("") end;
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSong() and not GAMESTATE:IsCourseMode() then
				if GAMESTATE:GetCurrentSteps(args) then
					self:settext( GAMESTATE:GetCurrentSteps(args):GetMeter() )
					self:diffuse( DifficultyColor( GAMESTATE:GetCurrentSteps(args):GetDifficulty() ) )
				end
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
		CurrentSongChangedMessageCommand=function(s) s:settext("") end;
		["CurrentSteps"..ToEnumShortString(args).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSong() and not GAMESTATE:IsCourseMode() then
				if GAMESTATE:GetCurrentSteps(args) then
					self:settext(
						string.upper( 
							THEME:GetString("Difficulty", ToEnumShortString( GAMESTATE:GetCurrentSteps(args):GetDifficulty() ) )
						)
					)
					self:diffuse( DifficultyColor( GAMESTATE:GetCurrentSteps(args):GetDifficulty() ) )
				end
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