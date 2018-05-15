return Def.ActorFrame{
	LoadActor("_menu in"),
	-- my attempt at making input locking.
	Def.Quad{ OnCommand=cmd(diffusealpha,0;linear,0.8); },
}