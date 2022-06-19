return Def.ActorFrame{
	Def.Quad{
		 OnCommand=function(self)
			self:diffusealpha(0):linear(2)
		end
	}
}