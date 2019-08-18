return Def.ActorFrame{
	
	Def.Model{
		Meshes="_award models/ribbon meshes.txt",
		Materials="_award models/ribbon materials red.txt",
		Bones="_award models/bones.txt",
		OnCommand=function(self)
			self:zoom(0.6):wag():effectmagnitude(0,15,0):effectperiod(8):x(-110):y(-30):zoom(0.35/1.8)
		end;
	},

	Def.BitmapText{
		Font="_eurostile normal",
		Text=THEME:GetString("PeakComboAward","Peak2000Combo"),
		OnCommand=function(self)
			self:horizalign(left):zoom(0.5):y(12):x(-135):shadowlength(2)
		end;
	},
}