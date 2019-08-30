local frame = ThemePrefs.Get("ITG1") and "_options" or "options"
return Def.ActorFrame{
	LoadActor(frame.. " page")..{
	OnCommand=function(self)
		self:addy(-1)
	end;
	},

	LoadActor("line highlight mask right")..{
	OnCommand=function(self)
		self:addy(-135):x(290):zwrite(1):blend(Blend.NoEffect)
	end;
	},
}