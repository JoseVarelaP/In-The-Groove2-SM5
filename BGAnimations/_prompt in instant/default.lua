return Def.ActorFrame{
	LoadActor("../_prompt.ogg")..{
		OnCommand=cmd(play);
	},
}
