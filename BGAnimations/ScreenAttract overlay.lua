return Def.ActorFrame{
	Def.BitmapText{
	Font="_eurostile outline",
	Text="???",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_BOTTOM-86):shadowlength(2):zoom(1):playcommand("Refresh")
	end;
		CoinModeChangedMessageCommand=function(self)
			self:playcommand("Refresh")
		end;
		RefreshCommand=function(self) 
				if GAMESTATE:GetCoinMode()=='CoinMode_Home' then
					self:settext('');
				return
				end
				local coins=GAMESTATE:GetCoins()
				local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
				if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
					self:playcommand("PressStart");
				else
					self:playcommand("InsertCoin");
				end 
			end,
		InsertCoinCommand=function(self)
			self:settext("INSERT COIN"):diffuseshift():effectcolor1(1,1,1,0):effectcolor2(1,1,1,1):effectperiod(2):effectoffset(1)
		end;
		PressStartCommand=function(self)
				self:settext('PRESS &START;')
				self:diffuseblink()
				self:effectcolor1(1,1,1,0)
				self:effectcolor2(1,1,1,1)
				self:effectperiod((GAMESTATE:GetCoinMode() == 'CoinMode_Free') and 1.0 or 0.3)
			end,
	},

	Def.BitmapText{
	Font="_eurostile outline",
	Text="???",
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_BOTTOM-56):shadowlength(2):zoom(0.8):diffuse(0.7,0.7,0.7,1):diffusebottomedge(color("#DFB629D0")):playcommand("Refresh")
	end;
		RefreshCommand=function(self)
			if GAMESTATE:IsEventMode() and GAMESTATE:GetCoinMode() ~= 'CoinMode_Home' then self:settext('EVENT MODE') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Free' then self:settext('FREE PLAY') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:visible(false) end

			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local credits=math.floor(coins/coinsPerCredit)
			local remainder=math.mod(coins,coinsPerCredit)
			local s = "CREDIT(S)  "
			if credits > 0 then s = s..credits..'  ' end
			s = s..remainder..'/'..coinsPerCredit
			self:settext(s)
		end,
		CoinInsertedMessageCommand=function(self)
			self:playcommand("Refresh")
		end;
		CoinModeChangedMessageCommand=function(self)
			self:playcommand("Refresh")
		end;
	},
}
