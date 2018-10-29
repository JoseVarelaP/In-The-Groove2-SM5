local t = Def.ActorFrame{}

t[#t+1] = Def.Model{
    Meshes="_award models/ribbon meshes.txt",
    Materials="_award models/ribbon materials blue.txt",
    Bones="_award models/bones.txt",
    OnCommand=cmd(zoom,0.6;wag;effectmagnitude,0,15,0;effectperiod,8;x,110;y,-30;zoom,0.4/1.8);
};

t[#t+1] = Def.BitmapText{
    Text="Full Great Combo";
    File="_eurostile normal";
    OnCommand=cmd(horizalign,right;zoom,0.5;y,12;x,135;shadowlength,2);
};

return t;