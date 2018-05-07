function PlayerColor( pn )
	if pn == PLAYER_1 then return color("#FBBE03") end	-- orange
	if pn == PLAYER_2 then return color("#56FF48") end	-- green
	return color("1,1,1,1")
end

function DifficultyName( pn )
	if GAMESTATE:GetCurrentSteps(pn) then
		local steps = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
		local Shorten = ToEnumShortString( steps )
		return THEME:GetString("Difficulty", Shorten)
	end
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
            return "0.00%"
        end
        
    else
        return " "
    end
end

function PlayerScoreColor( pn )
	return PlayerColor( pn );
end

function DifficultyColor( dc )
	if dc == "Difficulty_Beginner"	then return color("#D05CF6") end
	if dc == "Difficulty_Easy"		then return color("#09FF10") end
	if dc == "Difficulty_Medium"		then return color("#F3F312") end
	if dc == "Difficulty_Hard"		then return color("#EA3548") end
	if dc == "Difficulty_Challenge"	then return color("#16AFF3") end
	if dc == "Difficulty_Edit"		then return color("#F7F7F7") end
	return color("1,1,1,1")
end

-- Get a color to show text on top of difficulty frames.
function ContrastingDifficultyColor( dc )
	if dc == "Difficulty_Beginner"	then return color("#E2ABF5") end
	if dc == "Difficulty_Easy"		then return color("#B2FFB5") end
	if dc == "Difficulty_Medium"		then return color("#F2F2AA") end
	if dc == "Difficulty_Hard"		then return color("#EBA4AB") end
	if dc == "Difficulty_Challenge"	then return color("#AADCF2") end
	if dc == "Difficulty_Edit"		then return color("#F7F7F7") end
	return color("1,1,1,1")
end

