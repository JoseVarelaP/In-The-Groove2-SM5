return Def.ActorFrame{
	
	LoadActor("star.txt")..{
		 OnCommand=function(self)
			self:x(-19):y(20):zoom(0.6):wag():effectmagnitude(0,4,10)
		end
	},
	
	LoadActor("star.txt")..{
		 OnCommand=function(self)
			self:x(19):y(-20):zoom(0.6):wag():effectmagnitude(0,4,10)
		end
	},
}