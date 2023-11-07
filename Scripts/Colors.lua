function PlayerColor( pn )
	local colors = {
		[PLAYER_1] = color("#FBBE03"), -- orange
		[PLAYER_2] = color("#FBBE03"), -- green
	}
	return colors[pn] or color("1,1,1,1")
end

function DifficultyColor( dc )
	local colors = {
		["Difficulty_Beginner"] = color("#D05CF6"),
		["Difficulty_Easy"] = color("#09FF10"),
		["Difficulty_Medium"] = color("#F3F312"),
		["Difficulty_Hard"] = color("#EA3548"),
		["Difficulty_Challenge"] = color("#16AFF3"),
		["Difficulty_Edit"] = color("#F7F7F7"),
	}
	return colors[dc] or color("1,1,1,1")
end

-- Get a color to show text on top of difficulty frames.
function ContrastingDifficultyColor( dc )
	local colors = {
		["Difficulty_Beginner"] = color("#E2ABF5"),
		["Difficulty_Easy"] = color("#B2FFB5"),
		["Difficulty_Medium"] = color("#F2F2AA"),
		["Difficulty_Hard"] = color("#EBA4AB"),
		["Difficulty_Challenge"] = color("#AADCF2"),
		["Difficulty_Edit"] = color("#F7F7F7"),
	}
	return colors[dc] or color("1,1,1,1")
end

