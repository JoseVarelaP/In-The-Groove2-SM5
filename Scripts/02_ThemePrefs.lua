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
}

ThemePrefs.InitAll(Prefs)