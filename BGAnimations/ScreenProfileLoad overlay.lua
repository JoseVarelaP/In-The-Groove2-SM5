local t = Def.ActorFrame{
	LoadActor("_menu out")..{
		OnCommand=function(self)
			if ThemePrefs.Get("ITG1") then
				self:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8))
			else
				self:Center()
			end
			self:diffusealpha(0):linear(0.3):diffusealpha(1)
		end
	}
}

t[#t+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1) end
		self:queuecommand("Load")
	end,
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
}

return t