return Def.ActorFrame{
	
	Def.Quad{
		 OnCommand=function(self)
			self:FullScreen():diffusealpha(0):linear(0.3):diffusealpha(0.75)
		end
	},
}
