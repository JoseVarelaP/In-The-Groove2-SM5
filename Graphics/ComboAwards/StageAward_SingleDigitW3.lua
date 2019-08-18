local t = Def.ActorFrame{}

t[#t+1] = Def.Model{
    Meshes="_award models/ribbon meshes.txt",
    Materials="_award models/ribbon materials pink.txt",
    Bones="_award models/bones.txt",
    OnCommand=function(self)
    	self:zoom(0.6):wag():effectmagnitude(0,15,0):effectperiod(8):x(110):y(-30):zoom(0.35/1.8)
    end;
};

t[#t+1] = Def.BitmapText{
    Text=THEME:GetString("PerDifficultyAward","SingleDigitW3"),
    File="_eurostile normal";
    OnCommand=function(self)
    	self:horizalign(right):zoom(0.5):y(12):x(135):shadowlength(2)
    end;
};

return t;