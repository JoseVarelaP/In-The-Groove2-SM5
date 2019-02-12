return Def.CourseContentsList {
	MaxSongs = 4;
    NumItemsToDraw = 8;
	ShowCommand=function(self)
		self:linear(0.3):zoomy(1)
	end;
	HideCommand=function(self)
		self:linear(0.3):zoomy(0)
	end;
	SetCommand=function(self)
		self:SetFromGameState();
		self:PositionItems();
		self:SetTransformFromHeight(22);
		self:SetCurrentAndDestinationItem(0);
		self:SetLoop(false);
		self:SetMask(270,0);
	end;
	CurrentTrailP1ChangedMessageCommand=function(self)
		self:playcommand("Set")
	end;
	CurrentTrailP2ChangedMessageCommand=function(self)
		self:playcommand("Set")
	end;

	Display = Def.ActorFrame { 

		LoadFont("DifficultyListRow number") .. {
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);
			InitCommand=function(self)
				self:x(-145):zoom(0.8):shadowlength(0)
			end;
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:diffuse( DifficultyColor(params.Difficulty) );
				self:finishtweening():y(-20):diffusealpha(0):sleep(0.125*params.Number):linear(0.125):y(0):diffusealpha(1);
			end;
		};

		LoadFont("DifficultyListRow number") .. {
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
			InitCommand=function(self)
				self:x(145):zoom(0.8):shadowlength(0)
			end;
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:diffuse( DifficultyColor(params.Difficulty) );
				self:finishtweening():y(-20):diffusealpha(0):sleep(0.125*params.Number):linear(0.125):y(0):diffusealpha(1);
			end;
		};

		Def.TextBanner{
			InitCommand=function(self)
				self:Load("CourseTextBanner"):zoom(0.75):halign(0):SetFromString("", "", "", "", "", "")
			end;
			SetSongCommand=function(self, params)
				if params.Song then
					self:SetFromSong( params.Song );
				else
					self:SetFromString( "??????????", "??????????", "", "", "", "" );
				end
				self:finishtweening():y(-20):diffusealpha(0):sleep(0.125*params.Number):linear(0.125):y(0):diffusealpha(1);
			end;
		};
	};
};