return Def.ActorFrame{
	
	Def.Model{
		Meshes="_award models/itg meshes.txt",
		Materials="_award models/itg materials gold.txt",
		Bones="_award models/bones.txt",
		OnCommand=cmd(zoom,3;spin;effectmagnitude,0,40,0;effectperiod,8;x,-110;y,-28;zoom,0.8/1.8);
	},

	Def.BitmapText{
		Font="_eurostile normal",
		Text="9000 Peak Combo",
		OnCommand=cmd(horizalign,left;zoom,0.5;y,12;x,-135;shadowlength,2);
	},
}