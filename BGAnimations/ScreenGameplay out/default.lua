return Def.ActorFrame{
	Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(0,0,0,0):sleep(1):linear(0.8):diffusealpha(1)
	end;
	},
}