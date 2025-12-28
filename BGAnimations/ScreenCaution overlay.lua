local t = Def.ActorFrame{}
t[#t+1] = LoadActor("ScreenWarning overlay")
t[#t+1] = LoadActor("_join overlay")

if NETMAN and NETMAN:IsConnectionEstablished() then
	t[#t+1] = LoadActor("_menu out")..{
		OnCommand=function(self)
			if ThemePrefs.Get("ITG1") then
				self:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8))
			else
				self:Center()
			end
			self:diffusealpha(1):linear(0.3):diffusealpha(0)
		end
	}
end

return t