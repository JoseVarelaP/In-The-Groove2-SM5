return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.7):wag():effectmagnitude(0,10,0)
	end;

	LoadActor("c.txt")..{ OnCommand=function(s) s:x(-25) end};
	Def.Model{
		Meshes="minus.txt",
		Materials="c.txt",
		Bones="minus.txt",
		OnCommand=function(self)
			self:x(35)
		end
	},
}