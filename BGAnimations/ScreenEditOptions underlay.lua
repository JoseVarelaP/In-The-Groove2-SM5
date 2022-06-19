return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self)
			self:FullScreen():diffuse(0,0,0,0)
		end,
		OnCommand=function(self)
			self:diffusealpha(0.7)
		end,
		OffCommand=function(self)
			self:linear(0.5):diffusealpha(0)
		end
	},

	LoadActor("ScreenOptions underlay.lua")..{
		InitCommand=function(self) self:diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
	}
}