local t = Def.ActorFrame{
	Def.StepsDisplayList{
		Name="StepsDisplayList";
		SetCommand=function(self)
			self:visible(GAMESTATE:GetCurrentSong() ~= nil)
		end;
		CurrentSongChangedMessageCommand=function(self)
			self:queuecommand("Set")
		end;

		CursorP1=LoadActor(THEME:GetPathG('DifficultyList', 'cursor p1'))..{
			Name='CursorP1';
			InitCommand=function(self)
				self:x(-50):y(1):player(PLAYER_1):bounce():effectmagnitude(-10,0,0):effectclock("bgm"):effectperiod(1):effectoffset(0.2)
			end;
			ChangeCommand=function(self)
				self:stoptweening():decelerate(0.15)
			end;
		};
		CursorP1Frame=Def.ActorFrame{
			Name='CursorP1Frame';
			ChangeCommand=function(self)
				self:stoptweening():decelerate(0.15)
			end;
		};
		CursorP2=LoadActor(THEME:GetPathG('DifficultyList', 'cursor p2'))..{
			Name='CursorP2';
			InitCommand=function(self)
				self:x(175):y(1):player(PLAYER_2):bounce():effectmagnitude(10,0,0):effectclock("bgm"):effectperiod(1):effectoffset(0.2)
			end;
			ChangeCommand=function(self)
				self:stoptweening():decelerate(0.15)
			end;
		};
		CursorP2Frame=Def.ActorFrame {
			Name='CursorP2Frame';
			ChangeCommand=function(self)
				self:stoptweening():decelerate(0.15)
			end;
		};
	};
};

return t;
