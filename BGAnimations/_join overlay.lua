function Get2PlayerJoinMessage()
	if not GAMESTATE:PlayersCanJoin() then return "" end
	if GAMESTATE:GetCoinMode()=='CoinMode_Free' or GAMESTATE:GetCoinMode()=='CoinMode_Home' then
		return "2 Player mode available"
	end
	local numSidesNotJoined = NUM_PLAYERS - GAMESTATE:GetNumSidesJoined()
	if GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit' then
		numSidesNotJoined = numSidesNotJoined - 1
	end
	local coinsRequiredToJoinRest = numSidesNotJoined * PREFSMAN:GetPreference("CoinsPerCredit")
	local remaining = coinsRequiredToJoinRest - GAMESTATE:GetCoins();

	-- xxx: credit type for arcade machines
	local s = "For 2 Players, insert " .. remaining .. " more coin(s)"
	if remaining > 1 then s = s.."s" end
	return s
end

return Def.ActorFrame{
	Def.BitmapText{
	Font="_eurostile outline",
	Text="???",
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-56;shadowlength,2;zoom,0.9;diffuseshift;effectcolor1,color("#FFE58BFF");effectcolor2,color("#FFE58B00");playcommand, "Refresh");
	RefreshCommand=function(self)
		self:settext(Get2PlayerJoinMessage())
	end;
	JoinedCommand=cmd(linear,.2;diffusealpha,0);
	PlayerJoinedMessageCommand=cmd(playcommand,"Joined");
	CurrentStyleChangedMessageCommand=cmd(playcommand,"Refresh");
	CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
	CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
	},
}