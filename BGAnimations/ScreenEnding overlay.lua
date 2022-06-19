local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
	LoadActor("_scrolling ITG credits",true),
	Def.Sprite{
		Texture=THEME:GetPathG("ScreenEnding","Items/playagainsoon"),
		OnCommand=function(self)
			self:xy(SCREEN_CENTER_X,30)
		end
	}
}

local DifficultyBasedItems = {"Easy","Medium","Hard","Challenge"}
for player in ivalues(PlayerNumber) do
	local CardData = {
		{"Calories Today", string.format( "%.2f Cal", STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetCaloriesBurned() ) },
		{"Current Combo", STATSMAN:GetAccumPlayedStageStats(player):GetPlayerStageStats(player):GetCurrentCombo() },
		{
			THEME:GetString("StepsType",
			string.lower(
				string.gsub(
					ToEnumShortString( GAMESTATE:GetCurrentStyle():GetStepsType() ) , "_", "-"
					)
				)
			) .. " Songs %",
			string.format( "%.2f%%", PROFILEMAN:GetProfile(player):GetSongsAndCoursesPercentCompleteAllDifficulties( GAMESTATE:GetCurrentStyle():GetStepsType() ) ) },
	}
	local itembox = Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(player),
		OnCommand=function(self)
			self:xy( player == PLAYER_1 and SCREEN_CENTER_X-320+74 or SCREEN_CENTER_X+320-74, SCREEN_CENTER_Y+18 )
		end
	}

	itembox[#itembox+1] = Def.Sprite{
		Texture=THEME:GetPathG("ScreenEnding","Items/PlayerPane")
	}

	itembox[#itembox+1] = Def.BitmapText{
		Font="Common Normal",
		InitCommand=function(self)
			local PlayerName = GAMESTATE:IsSideJoined(player) and (GAMESTATE:GetPlayerDisplayName(player) ~= "Player ".. string.sub(ToEnumShortString(player),-1) and GAMESTATE:GetPlayerDisplayName(player) or THEME:GetString("ScreenEnding","No Card") )
			self:settext(PlayerName):y( -18-140):zoom(0.7):diffuse( PlayerColor(player) )
			:shadowlength(2)
		end
	}

	for i,v in ipairs(DifficultyBasedItems) do
		itembox[#itembox+1] = Def.BitmapText{
			Font="_eurostile normal",
			Text=THEME:GetString("Difficulty",v),
			OnCommand=function(self)
				self:diffuse( DifficultyColor( "Difficulty_"..v ) ):zoom(0.5)
				:xy( -30,(41-18)+20*(i-1))
			end
		}

		itembox[#itembox+1] = Def.BitmapText{
			Font="_eurostile normal",
			Text=string.format( "%.2f%%",
				PROFILEMAN:GetProfile(player):GetSongsPercentComplete( GAMESTATE:GetCurrentStyle():GetStepsType(), "Difficulty_"..v )
			),
			OnCommand=function(self)
				self:diffuse( PlayerColor(player) ):zoom(0.5)
				:xy( 30,(41-18)+20*(i-1)):shadowlength(2)
			end
		}
	end

	for i,v in ipairs(CardData) do
		itembox[#itembox+1] = Def.ActorFrame{
			OnCommand=function(self)
				self:y( -180+50*i )
			end,

			Def.BitmapText{
				Font="Common Normal",
				Text=v[1],
				OnCommand=function(self)
					self:diffuse( PlayerColor(player) ):zoom(0.5)
				end
			},

			Def.BitmapText{
				Font="Common Normal",
				Text=v[2],
				OnCommand=function(self)
					self:diffuse( PlayerColor(player) ):zoom(0.7):y(20)
				end
			}
		}
	end

	if ToEnumShortString(MEMCARDMAN:GetCardState(player)) ~= "none" then
		itembox[#itembox+1] = Def.Sprite{
			Texture=THEME:GetPathG("ScreenEnding","Items/remove card ".. ToEnumShortString(player) ),
			OnCommand=function(self)
				self:y( 162-18 ):glowshift():zoom(0.7)
			end
		}
	end

	t[#t+1] = itembox
end

local function IsAnyPlayerUsingMemoryCard()
	for player in ivalues(PlayerNumber) do
		if MEMCARDMAN:GetCardState(player) == "MemoryCardState_ready" then
			return true
		end
	end
	return false
end

if IsAnyPlayerUsingMemoryCard() then
	t[#t+1] = LoadActor("_fade in normal")
	t[#t+1] = Def.Sprite{
		Texture="_red streak",
		OnCommand=function(self)
			self:Center():fadeleft(0.3):faderight(0.3):cropleft(-0.3):cropright(-0.3)
			:zoom(1.5):linear(0.5):cropright(1.3):zoom(0.5)
		end
	}
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("","_saving"),
		OnCommand=function(self)
			self:Center():accelerate(0.5):addx(-SCREEN_WIDTH)
		end
	}
end

return t