return Def.ActorFrame{
	Def.Quad{
	InitCommand=cmd(FullScreen;diffuse,0,0,0,1;);
	OnCommand=cmd(diffusealpha,1;linear,0.3;diffusealpha,0);
	},
}