local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture=ThemePrefs.Get("ITG1") and THEME:GetPathG("ITG1/Common fallback","background") or THEME:GetPathG("ITG2 Common fallback background","background"),
	OnCommand=function(s)
		s:scale_or_crop_background()
	end;
}

return t;