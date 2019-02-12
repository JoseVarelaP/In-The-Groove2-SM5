local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

local Prefs =
{
	MarathonLabel =
	{
		Default = "ITG",
		Choices = { "ITG", "OITG" },
		Values = { "ITG", "OITG" }
	},
	
	TimerLabel =
	{
		Default = "ITG",
		Choices = { "Always Show", "Hide When Disabled (OITG)" },
		Values = { "ITG", "OITG" }
	},

	ShowAttackList =
	{
		Default = true,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},

	CompareScores =
	{
		Default = true,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
}

ThemePrefs.InitAll(Prefs)