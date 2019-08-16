function DifficultyName( name, pn )
	local ToGet = {
	["Steps"] = GAMESTATE:GetCurrentSteps(pn),
	["Trail"] = GAMESTATE:GetCurrentTrail(pn),
	}

	if ToGet[name] then
		local Shorten = ToEnumShortString( ToGet[name]:GetDifficulty() )
		return name == "Trail" and THEME:GetString("CourseDifficulty", Shorten) or THEME:GetString("Difficulty", Shorten)
	end
end

function MenuTimerSet(self)
	self:draworder(101):zoom(1.1)
	:visible( (PREFSMAN:GetPreference("MenuTimer") or ThemePrefs.Get("TimerLabel") == "ITG") and true or false )
	:addx(200):decelerate(0.3):addx(-200)
end

function SetFrameDifficulty( pn, ResultsScreen )
	local data = {
		difficulties = {"Beginner","Easy","Medium","Hard","Challenge","Edit"},
		result = {nil,nil},
		types = {GAMESTATE:GetCurrentSteps(pn),GAMESTATE:GetCurrentTrail(pn)}
	}
	for a,t in ipairs(data.types) do
		for i,v in ipairs(data.difficulties) do
			if t then if t:GetDifficulty() == "Difficulty_"..v then data.result[a] = i-1 end end
		end
	end
	return ResultsScreen and data.result[2] or (data.result and data.result[1] or 0)
end

function PlayerOptionsList()
	local list = "1,2,3A,3B,4,5,6,R1,R2,7,8,9,10,11".. (ThemePrefs.Get("HideSM5Options") and "" or ",12") .. ",13,14,16" .. (ThemePrefs.Get("HideSM5Options") and "" or ",17")
	return list
end

function SpeedMods()
	local t = {
		Name="Speed",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		ExportOnChange = true,
		Choices = {"X1","X1.5","X2","X2.5","X3","X4","X5","X6","C300","C450"},
		Values = {1,1.5,2,2.5,3,4,5,6,300,450},
		LoadSelections = function(s, list, pn)
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			for i, val in ipairs(s.Values) do
				-- Someone knows a better way for this?
				local speedfound = false
				local checkspeeds = {playeroptions:XMod(),playeroptions:CMod()}
				for sm in ivalues(checkspeeds) do
					if sm ~= nil then if val == sm then list[i] = true speedfound = true end end
				end
				if not speedfound then list[i] = false end
			end
		end,
		SaveSelections = function(s, list, pn)
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			for i, val in ipairs(s.Values) do
				if list[i] then
					if i > 8 then
						playeroptions:CMod( tonumber(val) )
					else
						playeroptions:XMod( tonumber(val) )
					end
				end
			end
		end
	}
	setmetatable(t, t)
	return ThemePrefs.Get("StockITGSpeeds") and t or ArbitrarySpeedMods()
end

function NoteSkinList()
	local function getNoteSkinList()
		-- From Dbk's Simply Love theme.
		local all = NOTESKIN:GetNoteSkinNames()
			
		if ThemePrefs.Get("HideStockNoteSkins") == "Hide" then

			-- Apologies, midiman. :(
			local stock = {
				"default", "delta", "easyv2", "exactv2", "lambda", "midi-note",
				"midi-note-3d", "midi-rainbow", "midi-routine-p1", "midi-routine-p2",
				"midi-solo", "midi-vivid", "midi-vivid-3d", "retro",
				"retrobar", "retrobar-splithand_whiteblue"
			}

			for stock_noteskin in ivalues(stock) do
				for i=1,#all do
					if stock_noteskin == all[i] then
						table.remove(all, i)
						break
					end
				end
			end
		end

		-- It's possible a user might want to hide stock notesksins
		-- but only have stock noteskins.  If so, just return all noteskins.
		if #all == 0 then all = NOTESKIN:GetNoteSkinNames() end
		
		return ThemePrefs.Get("HideStockNoteSkins") == "OnlyITG" and {"metal","cel","flat","vivid","robot"} or all
	end
	local t = {
		Name="NoteSkins",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = true,
		Choices = getNoteSkinList(),
		LoadSelections = function(s, list, pn)
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			for i, val in ipairs(s.Choices) do
				if val == playeroptions:NoteSkin() then list[i] = true end
			end
		end,
		SaveSelections = function(s, list, pn)
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			for i, choice in ipairs(s.Choices) do
				if list[i] then playeroptions:NoteSkin( choice ) break end
			end
		end
	}
	setmetatable(t, t)
	return t
end

function StageIndexBySegment(toggleless)
	local CurrentStage = {
		S = GAMESTATE:GetCurrentStage(),
		I = GAMESTATE:GetCurrentStageIndex()
	}

	if CurrentStage.S == "Stage_Event" then return "event" end
	if CurrentStage.S == "Stage_Final" then return ToEnumShortString(CurrentStage.S) end
	return toggleless and CurrentStage.I or CurrentStage.I+1
end

-- Get Specific Tap Note Score for Normal Evaluation
function GetPSStageStats( pn ) return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn) end

function CalculatePercentage( pn )
	local CalcPerNames = STATSMAN:GetCurStageStats()

    if GAMESTATE:IsPlayerEnabled(pn) then
        local GPSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
        local ScoreToCalculate = GPSS:GetActualDancePoints()/GPSS:GetPossibleDancePoints()

        if ScoreToCalculate > 0 then
            return FormatPercentScore( ScoreToCalculate )
        else
            return " 0.00%"
        end
        
    else
        return " "
    end
end

function CalPerNum(pn)
	if GAMESTATE:IsPlayerEnabled(pn) then
        local GPSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
        local ScoreToCalculate = GPSS:GetActualDancePoints()/GPSS:GetPossibleDancePoints()

        return ScoreToCalculate
	end
	return 0
end

-- Branch Overrides
Branch.StartGame = function()
	-- Check to see if there are 0 songs installed. Also make sure to check
	-- that the additional song count is also 0, because there is
	-- a possibility someone will use their existing StepMania simfile
	-- collection with sm-ssc via AdditionalFolders/AdditionalSongFolders.
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	if PROFILEMAN:GetNumLocalProfiles() >= 2 then
		return "ScreenSelectProfile"
	else
		if IsNetConnected() then
			return "ITG_StyleSelect"
		else
			if THEME:GetMetric("Common","AutoSetStyle") == false then
				return "ITG_StyleSelect"
			else
				return "ScreenProfileLoad"
			end
		end
	end
end

Branch.AfterSelectProfile = function()
	if ( THEME:GetMetric("Common","AutoSetStyle") == true ) then
		-- use SelectStyle in online...
		return IsNetConnected() and "ITG_StyleSelect" or "ScreenSelectPlayMode"
	else
		return "ITG_StyleSelect"
	end
end