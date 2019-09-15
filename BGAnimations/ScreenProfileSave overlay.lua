local function IsAnyPlayerUsingMemoryCard()
	for player in ivalues(PlayerNumber) do
		if GAMESTATE:IsEventMode() and MEMCARDMAN:GetCardState(player) == "MemoryCardState_ready" then
			return true
		end
	end
	return false
end

local t = Def.ActorFrame{
	LoadActor("_moveon")..{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y)
	end;
	},
	Def.Actor{
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToSave() then
			MESSAGEMAN:Broadcast("ShowMemoryFrame")
			self:sleep(1)
		end
		self:queuecommand("Load")
	end,
	LoadCommand=function()
		SCREENMAN:GetTopScreen():Continue()
		if IsAnyPlayerUsingMemoryCard() then
			MESSAGEMAN:Broadcast("HideMemoryFrame")
		end
	end,
	},
}

if IsAnyPlayerUsingMemoryCard() then
	t[#t+1] = Def.Sprite{
		Texture="_red streak",
		InitCommand=function(s)
			s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y):zoom(0.5):fadeleft(0.3):cropleft(1.3):cropright(-0.3)
			GAMESTATE:Env()["GameplayMemoryCardTransition"] = true
		end;
		ShowMemoryFrameMessageCommand=function(s) s:linear(0.5):cropleft(-0.3):zoom(1.5) end;
	}
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("","_saving"),
		InitCommand=function(s)
			s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y):addx(SCREEN_WIDTH)
		end;
		ShowMemoryFrameMessageCommand=function(s) s:decelerate(0.5):addx(-SCREEN_WIDTH) end;
	}
end

return t;
