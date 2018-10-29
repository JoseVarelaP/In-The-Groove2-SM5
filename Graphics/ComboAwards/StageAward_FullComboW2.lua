local t = Def.ActorFrame{}

t[#t+1] = Def.Model{
    Meshes="_award models/plaque meshes.txt",
    Materials="_award models/plaque materials bronze.txt",
    Bones="_award models/bones.txt",
    OnCommand=cmd(wag;effectmagnitude,0,20,0;effectperiod,8;x,110;y,-28;zoom,1/1.8);
};

t[#t+1] = Def.BitmapText{
    Text="Full Excellent Combo";
    File="_eurostile normal";
    OnCommand=cmd(horizalign,right;zoom,0.5;y,12;x,135;shadowlength,2);
};

return t;