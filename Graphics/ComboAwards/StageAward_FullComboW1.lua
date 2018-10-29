local t = Def.ActorFrame{}

t[#t+1] = Def.Model{
    Meshes="_award models/trophy meshes.txt",
    Materials="_award models/trophy materials bronze.txt",
    Bones="_award models/bones.txt",
    OnCommand=cmd(spin;effectmagnitude,0,40,0;effectperiod,8;x,110;y,-28;zoom,3/1.8);
};

t[#t+1] = Def.BitmapText{
    Text="Full Fantastic Combo";
    File="_eurostile normal";
    OnCommand=cmd(horizalign,right;zoom,0.5;y,12;x,135;shadowlength,2);
};

return t;

-- return Def.ActorFrame{
	
-- 	Def.Model{
-- 		Meshes="_award models/trophy meshes.txt",
-- 		Materials="_award models/trophy materials gold.txt",
-- 		Bones="_award models/bones.txt",
-- 		OnCommand=cmd(zoom,3;spin;effectmagnitude,0,40,0;effectperiod,8;x,-110;y,-28;zoom,3/1.8);
-- 	},

-- 	Def.BitmapText{
-- 		Font="_eurostile normal",
-- 		Text="7000 Peak Combo",
-- 		OnCommand=cmd(horizalign,left;zoom,0.5;y,12;x,-135;shadowlength,2);
-- 	},
-- }