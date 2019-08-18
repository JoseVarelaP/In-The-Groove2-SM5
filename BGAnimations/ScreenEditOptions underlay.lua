return Def.ActorFrame{
	Def.Quad{
	InitCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0)
	end;
	OnCommand=function(self)
		self:diffusealpha(0.7)
	end;
	OffCommand=function(s)
		s:linear(0.5):diffusealpha(0)
	end;
	},

	LoadActor("ScreenOptions underlay.lua")..{
		InitCommand=function(s) s:diffusealpha(0) end;
		OnCommand=function(s) s:linear(0.5):diffusealpha(1) end;
		OffCommand=function(s) s:linear(0.5):diffusealpha(0) end;
	}
}