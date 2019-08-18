local t = Def.ActorFrame{}

t[#t+1] = Def.Model{
    Meshes="_award models/trophy meshes.txt",
    Materials="_award models/trophy materials bronze.txt",
    Bones="_award models/bones.txt",
    OnCommand=function(self)
    	self:spin():effectmagnitude(0,40,0):effectperiod(8):x(110):y(-28):zoom(3/1.8)
    end;
};

t[#t+1] = Def.BitmapText{
    Text=THEME:GetString("PerDifficultyAward","FullComboW1"),
    File="_eurostile normal";
    OnCommand=function(self)
    	self:horizalign(right):zoom(0.5):y(12):x(135):shadowlength(2):maxwidth(300)
    end;
};

return t;