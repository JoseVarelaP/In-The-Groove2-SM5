return Def.ActorFrame{
	
	Def.Model{
		Meshes="_award models/plaque meshes.txt",
		Materials="_award models/plaque materials silver.txt",
		Bones="_award models/bones.txt",
		OnCommand=function(self)
			self:zoom(0.6):wag():effectmagnitude(0,15,0):effectperiod(8):x(-110):y(-28):zoom(1/1.8)
		end;
	},

	Def.BitmapText{
		Font="_eurostile normal",
		Text=THEME:GetString("PeakComboAward","Peak4000Combo"),
		OnCommand=function(self)
			self:horizalign(left):zoom(0.5):y(12):x(-135):shadowlength(2)
		end;
	},
}