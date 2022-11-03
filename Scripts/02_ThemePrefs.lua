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
	
	HideSM5Options =
	{
		Default = false,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	
	HideStockNoteSkins =
	{
		Default = "Show",
		Choices = { OptionNameString("OnlyITG"), OptionNameString("On"), OptionNameString("Off") },
		Values = { "OnlyITG", "Hide", "Show" }
	},

	StockITGSpeeds =
	{
		Default = false,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},

	ExperimentalLifebar =
	{
		Default = false,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	
	StepArtist = 
	{
		Default = false,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	UseUnlockColor = 
	{
		Default = false,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	UseComboZoom = 
	{
		Default = true,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	ShowThemeCredits = 
	{
		Default = true,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	TitleMenuType = 
	{
		Default = false,
		Choices = { "ITGPC", "OpenITG" },
		Values = { true, false }
	},
	Legacy = 
	{
		Default = false,
		Choices = { OptionNameString("On"), OptionNameString("Off") },
		Values = { true, false }
	},
	ITG1 = 
	{
		Default = false,
		Choices = { "ITG1", "ITG2" },
		Values = { true, false }
	},
}

ThemePrefs.InitAll(Prefs)