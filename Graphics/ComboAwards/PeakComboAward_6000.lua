return Def.ActorFrame{
	
	Def.Model{
		Meshes="_award models/trophy meshes.txt",
		Materials="_award models/trophy materials silver.txt",
		Bones="_award models/bones.txt",
		OnCommand=cmd(zoom,3;spin;effectmagnitude,0,40,0;effectperiod,8;x,-110;y,-28;zoom,3/1.8);
	},

	Def.BitmapText{
		Font="_eurostile normal",
		Text="6000 Peak Combo",
		OnCommand=cmd(horizalign,left;zoom,0.5;y,12;x,-135;shadowlength,2);
	},
}