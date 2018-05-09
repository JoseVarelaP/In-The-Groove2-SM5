return Def.ActorFrame{
	Def.Sprite{
		InitCommand=(Center);
		BeforeLoadingNextCourseSongMessageCommand=function(self) self:LoadFromSongBackground( SCREENMAN:GetTopScreen():GetNextCourseSong() ) end;
		StartCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffusealpha,0;sleep,0.3;linear,0.3;diffusealpha,1);
		FinishCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,0);
	},
}