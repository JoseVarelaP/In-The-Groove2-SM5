return Def.ActorFrame{
	Def.Quad{
	InitCommand=cmd(diffuse,color("#000000");FullScreen);
	OnCommand=cmd(cropleft,1;fadeleft,.5;linear,0.5;cropleft,-0.5);
	},

	LoadActor("_menu out")..{ OnCommand=cmd(hibernate,0.1); },
}
