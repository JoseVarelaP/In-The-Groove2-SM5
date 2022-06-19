local t = Def.ActorFrame{
	LoadActor("_menu in"),
	-- my attempt at making input locking.
	
	Def.Quad{
		 OnCommand=function(self)
			self:diffusealpha(0):linear(0.8)
		end
	}
}

local function IsAnyPlayerUsingMemoryCard()
	for player in ivalues(PlayerNumber) do
		if GAMESTATE:IsEventMode() and MEMCARDMAN:GetCardState(player) == "MemoryCardState_ready" then
			return true
		end
	end
	return false
end

if IsAnyPlayerUsingMemoryCard() and GAMESTATE:Env()["GameplayMemoryCardTransition"] then
	t[#t+1] = Def.Sprite{
		Texture="_red streak",
		OnCommand=function(self)
			self:Center():fadeleft(0.3):faderight(0.3):cropleft(-0.3):cropright(-0.3)
			:zoom(1.5):linear(0.5):cropright(1.3):zoom(0.5)
			GAMESTATE:Env()["GameplayMemoryCardTransition"] = false
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