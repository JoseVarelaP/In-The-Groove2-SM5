function DifficultyName( name, pn )
	local ToGet = {
	["Steps"] = GAMESTATE:GetCurrentSteps(pn),
	["Trail"] = GAMESTATE:GetCurrentTrail(pn),
	}

	if ToGet[name] then
		local Shorten = ToEnumShortString( ToGet[name]:GetDifficulty() )
		return THEME:GetString("Difficulty", Shorten)
	end
end

function MenuTimerSet(self)
	self:draworder(101);
	self:zoom(1.1);
	if PREFSMAN:GetPreference("MenuTimer") or ThemePrefs.Get("TimerLabel") == "ITG" then
		self:visible(true);
	else
		self:visible(false);
	end
	self:addx(200);
	self:decelerate(0.3);
	self:addx(-200);
end

function SetFrameDifficulty( pn )
	if GAMESTATE:GetCurrentSteps(pn) then
		local steps = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
		local DifficultyToSet = 0;
		if steps == "Difficulty_Beginner" then DifficultyToSet = 0; end
		if steps == "Difficulty_Easy" then DifficultyToSet = 1; end
		if steps == "Difficulty_Medium" then DifficultyToSet = 2; end
		if steps == "Difficulty_Hard" then DifficultyToSet = 3; end
		if steps == "Difficulty_Challenge" then DifficultyToSet = 4; end
		if steps == "Difficulty_Edit" then DifficultyToSet = 5; end
		return DifficultyToSet
	else
		return 0
	end
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