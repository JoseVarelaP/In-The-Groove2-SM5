return Def.ActorFrame{
	
	Def.Quad{
		 OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(color("0,0,0,0")):linear(0.3):diffusealpha(1)
		end
	}
}