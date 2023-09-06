local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	--Condition=not GAMESTATE:GetCurrentSong():HasBGChanges(),
	Texture=ThemePrefs.Get("ITG1") and THEME:GetPathG("ITG1/Common fallback","background") or THEME:GetPathG("ITG2 Common fallback","background"),
	OnCommand=function(self)
		self:playcommand("Check")
	end,
	CheckCommand=function(self)
		self:visible(false):scale_or_crop_background()
		local song = GAMESTATE:GetCurrentSong()
		if song then
			self:visible( not song:HasBGChanges() and not song:HasBackground() )
		end
	end,
	CurrentSongChangedMessageCommand=function(self)
		self:playcommand("Check")
	end
}

return t