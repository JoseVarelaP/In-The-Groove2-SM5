return Def.ActorFrame{
	
	Def.Model{
		Meshes="_award models/ribbon meshes.txt",
		Materials="_award models/ribbon materials purple.txt",
		Bones="_award models/bones.txt",
		OnCommand=cmd(zoom,0.6;wag;effectmagnitude,0,15,0;effectperiod,8;x,-110;y,-30;zoom,0.35/1.8);
	},

	Def.BitmapText{
		Font="_eurostile normal",
		Text="1000 Peak Combo",
		OnCommand=cmd(horizalign,left;zoom,0.5;y,12;x,-135;shadowlength,2);
	},
}