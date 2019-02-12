return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.7):rotationy(-90):spin():effectmagnitude(0,40,0)
	end;
	
	LoadActor("a.txt")..{
		 OnCommand=function(self)
			self:x(-20)
		end
	},
	Def.Model{
		Meshes="minus.txt",
		Materials="a.txt",
		Bones="minus.txt",
		OnCommand=function(self)
			self:x(35)
		end
	},
}