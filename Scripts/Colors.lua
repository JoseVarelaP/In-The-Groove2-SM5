function PlayerColor( pn )
	if pn == PLAYER_1 then return color("#FBBE03") end	-- orange
	if pn == PLAYER_2 then return color("#56FF48") end	-- green
	return color("1,1,1,1")
end

function DifficultyColor( dc )
	if dc == "Difficulty_Beginner"	then return color("#D05CF6") end
	if dc == "Difficulty_Easy"		then return color("#09FF10") end
	if dc == "Difficulty_Medium"	then return color("#F3F312") end
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

