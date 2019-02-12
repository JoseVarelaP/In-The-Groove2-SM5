return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.8):rotationy(-90):spin():effectmagnitude(0,40,0)
	end;
	
	LoadActor("s.txt")..{
		 OnCommand=function(self)
			self:x(-25)
		end
	},
	
	LoadActor("smooth plus.txt")..{
		 OnCommand=function(self)
			self:x(30)
		end
	},
}