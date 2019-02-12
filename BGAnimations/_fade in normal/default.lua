return Def.ActorFrame{
	Def.Quad{
	InitCommand=function(self)
		self:FullScreen():diffuse(0,0,0,1)
	end;
	OnCommand=function(self)
		self:diffusealpha(1):linear(0.3):diffusealpha(0)
	end;
	},
}