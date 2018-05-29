return Def.ActorFrame{
	OnCommand=cmd(zoom,0.7;rotationy,-90;spin;effectmagnitude,0,40,0);
	LoadActor("a.txt")..{ OnCommand=cmd(x,-20) },
	Def.Model{
		Meshes="minus.txt",
		Materials="a.txt",
		Bones="minus.txt",
		OnCommand=cmd(x,35)
	},
}