return ThemePrefs.Get("Legacy") and THEME:GetPathS("ScreenCredits legacy","music") or (
    IsITG1Mode() and THEME:GetPathS("ITG1/ScreenEndingNormal","music") or THEME:GetPathS("ScreenEnding","music")
)