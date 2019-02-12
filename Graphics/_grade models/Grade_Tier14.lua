return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.7):wag():effectmagnitude(0,10,0)
	end;
	
	LoadActor("c.txt")..{
		 OnCommand=function(self)
			self:x(-25)
		end
	},
	Def.Model{
		Meshes="plus.txt",
		Materials="c.txt",
		Bones="plus.txt",
		OnCommand=function(self)
			self:x(35)
		end
	},
}