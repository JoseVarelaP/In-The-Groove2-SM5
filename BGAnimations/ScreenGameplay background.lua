local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	--Condition=not GAMESTATE:GetCurrentSong():HasBGChanges(),
	Texture=ThemePrefs.Get("ITG1") and THEME:GetPathG("ITG1/Common fallback","background") or THEME:GetPathG("ITG2 Common fallback","background"),
	OnCommand=function(self)
		self:scale_or_crop_background()
	end
}

return t