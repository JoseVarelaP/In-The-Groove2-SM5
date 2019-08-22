local function CreditsText( pn )
	local text = LoadFont(Var "LoadingScreen","credits") .. {
		InitCommand=function(self)
			self:name("Credits" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
		UpdateTextCommand=function(self)
			local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn);
			MESSAGEMAN:Broadcast("SYSTEMUpdateText")
			self:settext(str);
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end
			self:visible( bShow );
		end
	};
	return text;
end;

--[[ local function PlayerPane( PlayerNumber ) 
	t[#t+1] = Def.BitmapText{
		Font="Common Normal";
		Name = "PlayerText";
		InitCommand=cmd(x,-60;maxwidth,80/0.5;zoom,0.5;queuecommand,"On");
		OnCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			local profile = PROFILEMAN:GetProfile( PlayerNumber) or PROFILEMAN:GetMachineProfile()
			if profile then
				self:settext( profile:GetDisplayName() );
			else
				self:settext( "NoProf" );
			end
		end;
	};
	return t
end --]]
--
local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));
	-- Credits
t[#t+1] = Def.ActorFrame {
--[[  	PlayerPane( PLAYER_1 ) .. {
		InitCommand=cmd(x,scale(0.125,0,1,SCREEN_LEFT,SCREEN_WIDTH);y,SCREEN_BOTTOM-16)
	}; --]]
 	CreditsText( PLAYER_1 );
	CreditsText( PLAYER_2 ); 
};

-- MemoryCard management
local cardpos = {
	["PlayerNumber_P1"] = {WideScale(18,24),SCREEN_BOTTOM-14},
	["PlayerNumber_P2"] = {SCREEN_RIGHT-WideScale(18,24),SCREEN_BOTTOM-14},
}
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("MemoryCardDisplay ready", ToEnumShortString(player) ),
		InitCommand=function(s) s:xy( cardpos[player][1] ,cardpos[player][2]-2 ):visible(true) end;
		SYSTEMUpdateTextMessageCommand=function(self)
			-- Based on what the player contains, update the sprite accordingly.
			local status = {
				["ready"] = THEME:GetPathG("MemoryCardDisplay ready", ToEnumShortString(player) ),
				["checking"] = THEME:GetPathG("MemoryCardDisplay checking", ToEnumShortString(player) ),
				["late"] = THEME:GetPathG("MemoryCardDisplay late", ToEnumShortString(player) ),
				["error"] = THEME:GetPathG("MemoryCardDisplay error", ToEnumShortString(player) ),
				["removed"] = THEME:GetPathG("MemoryCardDisplay removed", ToEnumShortString(player) ),
			}
			if MEMCARDMAN:GetCardState(player) ~= "none" then
				self:visible(true):Load( status[ ToEnumShortString(MEMCARDMAN:GetCardState(player)) ] )
			else
				self:visible(false)
			end
		end;
	};
end
	-- Text
t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomtowidth,SCREEN_WIDTH;zoomtoheight,30;horizalign,left;vertalign,top;y,SCREEN_TOP;diffuse,color("0,0,0,0"));
		OnCommand=cmd(finishtweening;diffusealpha,0.85;);
		OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
	};
	Def.BitmapText{
		Font="Common Normal";
		Name="Text";
		InitCommand=cmd(maxwidth,750;horizalign,left;vertalign,top;y,SCREEN_TOP+10;x,SCREEN_LEFT+10;shadowlength,1;diffusealpha,0;);
		OnCommand=cmd(finishtweening;diffusealpha,1;zoom,0.5);
		OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
	};
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message );
		self:playcommand( "On" );
		if params.NoAnimate then
			self:finishtweening();
		end
		self:playcommand( "Off" );
	end;
	HideSystemMessageMessageCommand = cmd(finishtweening);
};

return t;
