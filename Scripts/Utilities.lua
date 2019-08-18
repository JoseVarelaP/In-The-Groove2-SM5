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

Branch.AfterProfileLoad = function()
	if PREFSMAN:GetPreference("ShowCaution") or GAMESTATE:GetCoinMode() == "CoinMode_Pay" then
		return "ScreenCaution"
	else
		return Branch.StartGame()
	end
end

Branch.TitleMenu = function()
	if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
		if GAMESTATE:Env()["WorkoutMode"] then
			return "ScreenWorkoutMenu"
		else
			return "ScreenTitleMenu"
		end
	end
	-- arcade junk:
	if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
		-- if no credits are inserted, don't show the Join screen. SM4 has
		-- this as the initial screen, but that means we'd be stuck in a
		-- loop with ScreenInit. No good.
		return "ScreenTitleJoin"
	else
		return "ScreenTitleJoin"
	end
end

Branch.AfterTitleMenu = function() return Branch.AfterProfileLoad() end

-- Branch Overrides
Branch.StartGame = function()
	-- Check to see if there are 0 songs installed. Also make sure to check
	-- that the additional song count is also 0, because there is
	-- a possibility someone will use their existing StepMania simfile
	-- collection with sm-ssc via AdditionalFolders/AdditionalSongFolders.
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	if ThemePrefs.Get("ShowProfileSelect") and PROFILEMAN:GetNumLocalProfiles() >= 2 then
		return "ScreenSelectProfile"
	else
		if IsNetConnected() then
			return "ITG_StyleSelect"
		else
			if (THEME:GetMetric("Common","AutoSetStyle") == false or GAMESTATE:GetCoinMode() == "CoinMode_Pay") and not GAMESTATE:GetPlayMode() and not GAMESTATE:Env()["WorkoutMode"] then
				return "ITG_PlayModeSelect"
			else
				return "ITG_StyleSelect"
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

Branch.AfterEvaluation = function()
	if GAMESTATE:IsCourseMode() then
		return "ScreenProfileSave"
	else
		local maxStages = PREFSMAN:GetPreference("SongsPerPlay")
		local stagesLeft = GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer()
		local allFailed = STATSMAN:GetCurStageStats():AllFailed()
		local song = GAMESTATE:GetCurrentSong()

		if GAMESTATE:IsEventMode() or stagesLeft >= 1 then
			return "ScreenProfileSave"
		elseif song:IsLong() and maxStages <= 2 and stagesLeft < 1 and allFailed then
			return GAMESTATE:AnyPlayerHasRankingFeats() and "ScreenNameEntryTraditional" or "ScreenGameOver"
		elseif song:IsMarathon() and maxStages <= 3 and stagesLeft < 1 and allFailed then
			return GAMESTATE:AnyPlayerHasRankingFeats() and "ScreenNameEntryTraditional" or "ScreenGameOver"
		elseif maxStages >= 2 and stagesLeft < 1 and allFailed then
			return GAMESTATE:AnyPlayerHasRankingFeats() and "ScreenNameEntryTraditional" or "ScreenGameOver"
		elseif allFailed then
			return GAMESTATE:AnyPlayerHasRankingFeats() and "ScreenNameEntryTraditional" or "ScreenGameOver"
		else
			return GAMESTATE:AnyPlayerHasRankingFeats() and "ScreenNameEntryTraditional" or "ScreenGameOver"
		end
	end
end

-- Workout Mode Selection Choices
function WorkoutSelector(OptionToSelect)
	local function IndexToPounds(i)
		return i*5
	end
	
	local function WeightLbs()
		local ret = { }
		for i = 1,100 do ret[i] = IndexToPounds(i).." Lbs" end
		return ret
	end

	local function IndexToCalories(i)
		return i*10+20
	end
	
	local function CaloriesList()
		local ret = { }
		for i = 1,98 do ret[i] = IndexToCalories(i).." cals" end
		return ret
	end

	local function IndexToSeconds(i)
		return i*60+4*60
	end
	
	local function SecondsList()
		local ret = { }
		for i = 1,56 do ret[i] = (IndexToSeconds(i)/60).." mins" end
		return ret
	end

	function GetPlayersWithGoalType( gt )
		local t = { }
		for pn = PLAYER_1,NUM_PLAYERS-1 do 
			if GAMESTATE:IsHumanPlayer(pn) and WorkoutGetProfileGoalType(pn) == gt then 
				t[pn] = pn 
			end
		end
		return t
	end

	local Choices = {
		["GoalType"] = {
			Name="GoalType",
			LayoutType = "ShowOneInRow",
			SelectType = "SelectOne",
			OneChoiceForAllPlayers = false,
			ExportOnChange = true,
			Choices = { THEME:GetString("OptionNames","CalorieBurn"), THEME:GetString("OptionNames","PlayTime"), THEME:GetString("OptionNames","None") },
			Values = { "calories","time","none" },
			NotifyOfSelection= function(self, pn, choice)
				GAMESTATE:Env()["NewTimingMode"] = self.Values[choice]
				MESSAGEMAN:Broadcast("GoalTypeChanged")
			end,
			LoadSelections = function(s, list, pn)
				if PROFILEMAN:GetProfile(pn):GetGoalType() ~= 2 then
					list[ PROFILEMAN:GetProfile(pn):GetGoalType()+1 ] = true
					return
				end
				list[1] = true
				return
			end,
			SaveSelections = function(s, list, pn)
			end
		},
		----------------------------------------------------
		["GoalAmount"] = {
			Name="GoalCalories",
			LayoutType = "ShowOneInRow",
			SelectType = "SelectOne",
			OneChoiceForAllPlayers = false,
			ExportOnChange = true,
			GoToFirstOnStart= true,
			Choices = CaloriesList(),
			ReloadRowMessages = { "GoalTypeChanged" },
			LoadSelections = function(s, list, pn)
				if GAMESTATE:Env()["NewTimingMode"] == "time" then
					local val = PROFILEMAN:GetProfile(pn):GetGoalSeconds()
					for i = 1,table.getn(s.Choices) do
						if val == IndexToSeconds(i) then
							list[i] = true
							return
						end
					end
					list[6] = true	-- 10 mins
				end
				if GAMESTATE:Env()["NewTimingMode"] == "calories" then
					local val = PROFILEMAN:GetProfile(pn):GetGoalCalories()
					for i = 1,table.getn(s.Choices) do
						if val == IndexToCalories(i) then
							list[i] = true
							return
						end
					end
					list[13] = true	-- 150 cals
				end
				if GAMESTATE:Env()["NewTimingMode"] == "none" then
					list[1] = true
				end
			end,
			SaveSelections = function(s, list, pn)
				local profile = PROFILEMAN:GetProfile(pn)
				for i = 1,table.getn(s.Choices) do
					if list[i] then
						if GAMESTATE:Env()["NewTimingMode"] == "calories" then
							PROFILEMAN:GetProfile(pn):SetGoalType(0):SetGoalCalories( IndexToCalories(i) )
						end
						if GAMESTATE:Env()["NewTimingMode"] == "time" then
							PROFILEMAN:GetProfile(pn):SetGoalType(1):SetGoalSeconds( IndexToSeconds(i) )
						end
						if GAMESTATE:Env()["NewTimingMode"] == "none" then
							PROFILEMAN:GetProfile(pn):SetGoalType(2)
						end
						return
					end
				end
				GAMESTATE:Env()["WorkoutComplete"..pn] = false
			end,
			Reload = function(self)
				-- Get the original values
				local origVals = self.Choices
				local Types = {
					["calories"] = CaloriesList(),
					["time"] = SecondsList(),
					["none"] = { THEME:GetString("OptionNames","None") },
				}

				self.Choices = Types[ GAMESTATE:Env()["NewTimingMode"] ]
				self.Values = Types[ GAMESTATE:Env()["NewTimingMode"] ]
				if GAMESTATE:Env()["NewTimingMode"] == "time" then self.Name = "GoalTime" end
				if GAMESTATE:Env()["NewTimingMode"] == "calories" then self.Name = "GoalCalories" end
				if #origVals ~= #self.Choices then
					return "ReloadChanged_All"
				end
				return "ReloadChanged_None"
			end,
		},
		----------------------------------------------------
		["Weight"] = {
			-- Name is used to retrieve the header and explanation text.
			Name = "Weight",
			LayoutType = "ShowOneInRow",
			SelectType = "SelectOne",
			OneChoiceForAllPlayers = false,
			ExportOnChange = false,
			Choices = WeightLbs(),
			LoadSelections = function(self, list, pn)
				local val = PROFILEMAN:GetProfile(pn):GetWeightPounds()
				if val <= 0 then val = 100 end
				for i = 1,table.getn(self.Choices) do
					if val == IndexToPounds(i) then
						list[i] = true
						return
					end
				end
				list[20] = true -- 100 lbs
			end,
			SaveSelections = function(self, list, pn)
				for i = 1,table.getn(self.Choices) do
					if list[i] then
						PROFILEMAN:GetProfile(pn):SetWeightPounds( IndexToPounds(i) )
						return
					end
				end
			end,
		},
		----------------------------------------------------
		["SimpleSteps"] = {
			Name="SimpleSteps",
			LayoutType = "ShowOneInRow",
			SelectType = "SelectOne",
			OneChoiceForAllPlayers = false,
			ExportOnChange = true,
			Choices = { THEME:GetString("OptionNames","No"), THEME:GetString("OptionNames","Yes") },
			Values = { false, true },
			LoadSelections = function(s, list, pn)
				list[1] = true
			end,
			SaveSelections = function(s, list, pn)
				for i, choice in ipairs(s.Choices) do
					if list[2] == true then
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):Little(true)
					end
				end
			end
		},
		----------------------------------------------------
		["SelectType"] = {
			Name="SelectType",
			LayoutType = "ShowAllInRow",
			SelectType = "SelectOne",
			OneChoiceForAllPlayers = true,
			ExportOnChange = true,
			Choices = { THEME:GetString("OptionNames","Songs"), THEME:GetString("OptionNames","Courses"), THEME:GetString("OptionNames","RandomEndless") },
			Values = { 1, 2, 3 },
			LoadSelections = function(s, list, pn)
				list[1] = true
			end,
			SaveSelections = function(s, list, pn)
				local chnew = {
					"playmode,regular",
					"playmode,nonstop",
					"playmode,endless;setenv,sMode,Endless"
				}
				for i, choice in ipairs(s.Choices) do
					if list[i] then
						GAMESTATE:ApplyGameCommand( chnew[i] )
					end
				end
			end
		},
	}

	if Choices[OptionToSelect] then
		local t = Choices[OptionToSelect]
		setmetatable(t,t)
		return t
	end
end