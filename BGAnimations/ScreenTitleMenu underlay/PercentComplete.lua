local Args=...

return Def.ActorFrame{
	Def.BitmapText{
		Font="_futurist metalic";
		Text=FormatPercentScore( PROFILEMAN:GetMachineProfile():GetSongsAndCoursesPercentCompleteAllDifficulties( Args ) );
		OnCommand=function(self)
			self:halign(1):zoom(0.8):zoomy(0.75)
		end;
	};
	Def.BitmapText{
		Font="_eurostile outline";
		Text=GAMEMAN:StepsTypeToLocalizedString(Args);
		OnCommand=function(self)
			self:halign(0):zoom(0.7):xy(5,-3):maxwidth(100)
		end;
	}
}