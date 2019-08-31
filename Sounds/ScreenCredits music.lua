return ThemePrefs.Get("Legacy") and THEME:GetPathS("ScreenCredits legacy","music") or (
    ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/ScreenEndingNormal","music") or THEME:GetPathS("ScreenEnding","music")
)