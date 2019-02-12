return Def.ActorFrame{
	
	Def.Model{
		Meshes="ribbon meshes.txt",
		Materials="ribbon materials purple.txt",
		Bones="bones.txt",
		OnCommand=function(self)
			self:zoom(0.6):wag():effectmagnitude(0,15,0):effectperiod(8)
		end;
	},
}