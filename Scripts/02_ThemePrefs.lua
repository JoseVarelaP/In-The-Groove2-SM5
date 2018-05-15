local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

local Prefs =
{
	MarathonLabel =
	{
		Default = "ITG",
		Choices = { THEME:GetString("ITGThemeChoices","ITG"), THEME:GetString("ITGThemeChoices","OITG") },
		Values = { "ITG", "OITG" }
	},
}

ThemePrefs.InitAll(Prefs)