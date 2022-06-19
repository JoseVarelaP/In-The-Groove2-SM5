local t = Def.ActorFrame{}

local function IsAnyPlayerUsingMemoryCard()
	for player in ivalues(PlayerNumber) do
		if MEMCARDMAN:GetCardState(player) == "MemoryCardState_ready" then
			return true
		end
	end
	return false
end

t[#t+1] = Def.Sprite{
	Texture=THEME:GetPathG("ScreenEnding Items/GoodEnding/thank you for","playing"),
	OnCommand=function(self)
		self:Center():addy(-110):addx(-SCREEN_WIDTH):sleep(1):decelerate(0.5):addx(SCREEN_WIDTH)
		:linear(3.5):addx(20):linear(0.5):addx(5):diffusealpha(0)
	end
}
t[#t+1] = LoadActor( THEME:GetPathG("ScreenEnding Items/GoodEnding/in the","groove") )..{
	OnCommand=function(self)
		self:Center():hibernate(1):addy(20):addx(30):linear(4):addx(-5):accelerate(0.5)
		:addx(-SCREEN_WIDTH)
	end
}
t[#t+1] = LoadActor( THEME:GetPathG("ScreenEnding","Items/GoodEnding/credits") )..{
	OnCommand=function(self)
		self:Center():hibernate(1)
	end
}

for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsSideJoined(player),
		OnCommand=function(self)
			self:xy( player == PLAYER_1 and SCREEN_LEFT+80 or SCREEN_RIGHT-80 ,SCREEN_BOTTOM-100 )
		end,
		Def.Sprite{
			Texture=THEME:GetPathG("ScreenEnding","Items/GoodPlayerPane"),
		},

		Def.BitmapText{
			Font="Common Normal",
			OnCommand=function(self)
				local PlayerName = GAMESTATE:IsSideJoined(player) and (GAMESTATE:GetPlayerDisplayName(player) ~= "Player ".. string.sub(ToEnumShortString(player),-1) and GAMESTATE:GetPlayerDisplayName(player) or THEME:GetString("ScreenEnding","No Card") ) or THEME:GetString("ScreenEnding","No Card")
				self:diffuse(PlayerColor(player)):y(-40):zoom(0.6):settext(PlayerName)
			end
		},

		Def.Sprite{
			Condition=MEMCARDMAN:GetCardState(player) == "MemoryCardState_ready",
			Texture=THEME:GetPathG("ScreenEnding","Items/remove card "..ToEnumShortString(player)),
			OnCommand=function(self)
				self:zoom(0.7):y(20):glowshift()
			end
		}
	}
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