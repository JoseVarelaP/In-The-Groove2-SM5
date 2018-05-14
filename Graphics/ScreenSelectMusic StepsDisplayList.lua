local t = Def.ActorFrame{
	Def.StepsDisplayList{
		Name="StepsDisplayList";
		SetCommand=function(self)
			self:visible(GAMESTATE:GetCurrentSong() ~= nil)
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");

		CursorP1=LoadActor(THEME:GetPathG('DifficultyList', 'cursor p1'))..{
			Name='CursorP1';
			InitCommand=cmd(x,-50;player,PLAYER_1;bounce;effectmagnitude,-10,0,0;effectclock,"bgm";effectperiod,1);
			ChangeCommand=cmd(stoptweening;decelerate,0.15);
		};
		CursorP1Frame=Def.ActorFrame{
			Name='CursorP1Frame';
			ChangeCommand=cmd(stoptweening;decelerate,0.15);
		};
		CursorP2=LoadActor(THEME:GetPathG('DifficultyList', 'cursor p2'))..{
			Name='CursorP2';
			InitCommand=cmd(x,175;player,PLAYER_2;bounce;effectmagnitude,10,0,0;effectclock,"bgm";effectperiod,1);
			ChangeCommand=cmd(stoptweening;decelerate,0.15);
		};
		CursorP2Frame=Def.ActorFrame {
			Name='CursorP2Frame';
			ChangeCommand=cmd(stoptweening;decelerate,0.15);
		};
	};
};

return t;
