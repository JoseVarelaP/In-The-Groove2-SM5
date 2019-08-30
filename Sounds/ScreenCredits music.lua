local toplay = "ScreenEnding music"
return ThemePrefs.Get("Legacy") and THEME:GetPathS("ScreenCredits legacy","music") or THEME:GetPathS("ScreenEnding","music")