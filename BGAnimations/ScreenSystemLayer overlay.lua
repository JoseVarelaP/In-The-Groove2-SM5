local function CreditsText( pn )
	local text = LoadFont(Var "LoadingScreen","credits") .. {
		InitCommand=function(self)
			self:name("Credits" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end,
		UpdateTextCommand=function(self)
			local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn)
			MESSAGEMAN:Broadcast("SYSTEMUpdateText")
			self:settext(str)
		end,
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			local bShow = true
			if screen then
				local sClass = screen:GetName()
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" )
			end
			self:visible( bShow )
		end
	}
	return text
end

local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"))
	-- Credits
t[#t+1] = Def.ActorFrame {
 	CreditsText( PLAYER_1 ),
	CreditsText( PLAYER_2 )
}

-- MemoryCard management
local cardpos = {
	["PlayerNumber_P1"] = {WideScale(18,18),SCREEN_BOTTOM-14},
	["PlayerNumber_P2"] = {SCREEN_RIGHT-WideScale(18,18),SCREEN_BOTTOM-14},
}
for player in ivalues(PlayerNumber) do
	local shortplr = ToEnumShortString(player)
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("MemoryCardDisplay ready", shortplr ),
		InitCommand=function(s) s:xy( cardpos[player][1] ,cardpos[player][2]-2 ):visible(true) end,
		SYSTEMUpdateTextMessageCommand=function(self)
			self:visible(false)
			-- Based on what the player contains, update the sprite accordingly.
			local status = {
				["ready"] = THEME:GetPathG("MemoryCardDisplay ready", shortplr ),
				["checking"] = THEME:GetPathG("MemoryCardDisplay checking", shortplr ),
				["late"] = THEME:GetPathG("MemoryCardDisplay late", shortplr ),
				["error"] = THEME:GetPathG("MemoryCardDisplay error", shortplr ),
				["removed"] = THEME:GetPathG("MemoryCardDisplay removed", shortplr ),
			}
			local CardStatus = ToEnumShortString(MEMCARDMAN:GetCardState(player))
			if CardStatus ~= "none" then
				self:visible(true):Load( status[ CardStatus ] )
			end
		end
	}
end

	-- Text
t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self)
			self:zoomtowidth(SCREEN_WIDTH):zoomtoheight(30):align(0,0):diffuse(color("0,0,0,0"))
		end,
		OnCommand=function(self)
			self:finishtweening():diffusealpha(0.85)
		end,
		OffCommand=function(self)
			self:sleep(3):linear(0.5):diffusealpha(0)
		end
	},
	Def.BitmapText{
		Font="Common Normal",
		Name="Text",
		InitCommand=function(self)
			self:maxwidth(750):align(0,0):xy(10,10):shadowlength(1):diffusealpha(0)
		end,
		OnCommand=function(self)
			self:finishtweening():diffusealpha(1):zoom(0.5)
		end,
		OffCommand=function(self)
			self:sleep(3):linear(0.5):diffusealpha(0)
		end
	},
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message )
		self:playcommand( "On" )
		if params.NoAnimate then
			self:finishtweening()
		end
		self:playcommand( "Off" )
	end,
	HideSystemMessageMessageCommand = function(self) self:finishtweening() end
}

return t
