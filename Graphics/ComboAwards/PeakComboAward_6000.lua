return Def.ActorFrame{
	
	Def.Model{
		Meshes="_award models/trophy meshes.txt",
		Materials="_award models/trophy materials silver.txt",
		Bones="_award models/bones.txt",
		OnCommand=function(self)
			self:zoom(3):spin():effectmagnitude(0,40,0):effectperiod(8):x(-110):y(-28):zoom(3/1.8)
		end;
	},

	Def.BitmapText{
		Font="_eurostile normal",
		Text=THEME:GetString("PeakComboAward","Peak6000Combo"),
		OnCommand=function(self)
			self:horizalign(left):zoom(0.5):y(12):x(-135):shadowlength(2)
		end;
	},
}