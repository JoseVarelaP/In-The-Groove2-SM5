return Def.ActorFrame{
	Def.Sprite{
		InitCommand=(Center);
		BeforeLoadingNextCourseSongMessageCommand=function(self) self:LoadFromSongBackground( SCREENMAN:GetTopScreen():GetNextCourseSong() ) end;
		StartCommand=function(self)
			self:scale_or_crop_background():diffusealpha(0):sleep(0.3):linear(0.3):diffusealpha(1)
		end;
		FinishCommand=function(self)
			self:sleep(0.3):linear(0.3):diffusealpha(0)
		end;
	},
}