return Def.ActorFrame{
	OnCommand=cmd(zoom,0.7;wag;effectmagnitude,0,10,0);
	LoadActor("c.txt")..{ OnCommand=cmd(x,-25) },
	Def.Model{
		Meshes="plus.txt",
		Materials="c.txt",
		Bones="plus.txt",
		OnCommand=cmd(x,35)
	},
}