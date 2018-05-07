local PlayerState = GAMESTATE:GetPlayerState(PLAYER_1)
local PlayerOptions = PlayerState:GetPlayerOptionsArray(0)
local optionslist = ""

for k,option in ipairs(PlayerOptions) do
	if option ~= "FailAtEnd" and option ~= "FailImmediateContinue" and option ~= "FailImmediate" then
		if k < #PlayerOptions then
			optionslist = optionslist..option..", "
		else
			optionslist = optionslist..option
		end
	end
end

return Def.ActorFrame{
	LoadActor("base frame"),

	LoadActor( THEME:GetPathG('','_difficulty icons') )..{
		OnCommand=cmd(xy,-95,-149;animate,0;playcommand, "Update");
		UpdateCommand=function(self,parent) self:setstate( SetFrameDifficulty(PLAYER_1) ) end,
	},

		Def.GraphDisplay{
			InitCommand=cmd(y,-36),
			BeginCommand=function(self)
				self:Load("GraphDisplayP1")
				local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
				local stageStats = STATSMAN:GetCurStageStats()
				self:Set(stageStats, playerStageStats)
			end,
		},

		Def.ComboGraph{
			InitCommand=cmd(y,-7),
			BeginCommand=function(self)
				self:Load("ComboGraphP1")
				local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
				local stageStats = STATSMAN:GetCurStageStats()
				self:Set(stageStats, playerStageStats)
			end,
		},

	-- Grade time

	Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,-134,-149.5;horizalign,left;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( DifficultyName(PLAYER_1) )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

	Def.BitmapText{
			Font="Common Normal",
			OnCommand=cmd(zoom,0.5;xy,-57,-149.5;horizalign,right;playcommand, "Update");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand, "Update");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand, "Update");
			UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
					self:settext( GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter() )
					self:diffuse( ContrastingDifficultyColor( steps ) )
				end,
			},

	Def.BitmapText{ Font="_futurist metalic", Text=CalculatePercentage(PLAYER_1), OnCommand=cmd(horizalign,right;xy,115,-82;diffuse,PlayerColor(PLAYER_1)); },

	Def.BitmapText{ Font="_eurostile normal", Text=optionslist, OnCommand=cmd(xy,45,-112;zoom,0.5;shadowlength,2;wrapwidthpixels,400); },

	-- labels
	Def.ActorFrame{
		OnCommand=cmd(x,-128;y,31);
		Def.BitmapText{ Font="_eurostile normal", Text="Fantastic", 	OnCommand=cmd(y,16*0;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Excellent", 	OnCommand=cmd(y,16*1;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Great", 		OnCommand=cmd(y,16*2;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Decent", 	OnCommand=cmd(y,16*3;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Way Off", 	OnCommand=cmd(y,16*4;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Miss", 		OnCommand=cmd(y,16*5;zoom,0.5;horizalign,left;shadowlength,0); };
	},

	-- scores
	Def.ActorFrame{
		OnCommand=cmd(x,-18;y,31);
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d", GetPSStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W1") ), OnCommand=cmd(y,16*0;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d", GetPSStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W2") ), OnCommand=cmd(y,16*1;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d", GetPSStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W3") ), OnCommand=cmd(y,16*2;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d", GetPSStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W4") ), OnCommand=cmd(y,16*3;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d", GetPSStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W5") ), OnCommand=cmd(y,16*4;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d", GetPSStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_Miss") ), OnCommand=cmd(y,16*5;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
	},

	-- additional labels
	Def.ActorFrame{
		OnCommand=cmd(x,4;y,31);
		Def.BitmapText{ Font="_eurostile normal", Text="Jumps", 		OnCommand=cmd(y,16*0;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Holds", 		OnCommand=cmd(y,16*1;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Mines", 		OnCommand=cmd(y,16*2;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Hands", 		OnCommand=cmd(y,16*3;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Rolls", 		OnCommand=cmd(y,16*4;zoom,0.5;horizalign,left;shadowlength,0); };
		Def.BitmapText{ Font="_eurostile normal", Text="Max Combo", 	OnCommand=cmd(y,16*5;zoom,0.5;horizalign,left;shadowlength,0;maxwidth,130); };
	},

	-- additional scores
	Def.ActorFrame{
		OnCommand=cmd(x,128;y,31);
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 3d",20).."/"..string.format("% 3d",90), 	OnCommand=cmd(y,16*0;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 3d",20).."/"..string.format("% 3d",90), 	OnCommand=cmd(y,16*1;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 3d",20).."/"..string.format("% 3d",90), 	OnCommand=cmd(y,16*2;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 3d",20).."/"..string.format("% 3d",90), 	OnCommand=cmd(y,16*3;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 3d",20).."/"..string.format("% 3d",90), 	OnCommand=cmd(y,16*4;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
		Def.BitmapText{ Font="ScreenEvaluation judge", Text=string.format("% 4d",20), 	OnCommand=cmd(y,16*5;zoom,0.5;horizalign,right;shadowlength,0;diffuse,PlayerColor(PLAYER_1)); };
	},
}

