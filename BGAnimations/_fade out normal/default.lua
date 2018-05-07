return Def.ActorFrame{
	Def.Quad{
	InitCommand=cmd(FullScreen;diffuse,0,0,0,1;);
	OnCommand=cmd(diffusealpha,0;linear,0.3;diffusealpha,1;sleep,0.5);
	},
}