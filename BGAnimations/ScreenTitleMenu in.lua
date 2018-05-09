return Def.ActorFrame{
	LoadActor("_logo.ogg")..{
		OnCommand=cmd(play);
	},
	
	Def.Quad{
		OnCommand=cmd(FullScreen;linear,0.3;diffusealpha,0);
	},
}