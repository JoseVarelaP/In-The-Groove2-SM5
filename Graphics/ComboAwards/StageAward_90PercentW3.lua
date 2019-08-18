local t = Def.ActorFrame{}

t[#t+1] = Def.Model{
    Meshes="_award models/plaque meshes.txt",
    Materials="_award models/plaque materials green.txt",
    Bones="_award models/bones.txt",
    OnCommand=function(self)
    	self:wag():effectmagnitude(0,20,0):effectperiod(8):x(110):y(-25):zoom(1/1.8)
    end;
};

t[#t+1] = Def.BitmapText{
    Text=THEME:GetString("PerDifficultyAward","Percent90W3"),
    File="_eurostile normal";
    OnCommand=function(self)
    	self:horizalign(right):zoom(0.5):y(12):x(135):shadowlength(2)
    end;
};

return t;