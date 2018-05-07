return Def.ActorFrame{
	LoadActor("f.txt")..{
	OnCommand=cmd(zoom,0.85;wag;EffectMagnitude,0,10,10);
	},
}