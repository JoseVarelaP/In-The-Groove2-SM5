return Def.ActorFrame{
	Def.Quad{
	InitCommand=cmd(diffuse,color("#000000");FullScreen);
	OnCommand=cmd(cropleft,1;fadeleft,.5;linear,0.5;cropleft,-0.5;sleep,0.5);
	},

	LoadActor( THEME:GetPathS("","_screen cancel") )..{
		StartTransitioningCommand=cmd(play);
	},
}
