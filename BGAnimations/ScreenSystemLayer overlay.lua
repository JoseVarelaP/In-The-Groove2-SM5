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

local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));
	-- Credits
t[#t+1] = Def.ActorFrame {
 	CreditsText( PLAYER_1 );
	CreditsText( PLAYER_2 ); 
};

-- MemoryCard management
local cardpos = {
	["PlayerNumber_P1"] = {WideScale(18,18),SCREEN_BOTTOM-14},
	["PlayerNumber_P2"] = {SCREEN_RIGHT-WideScale(18,18),SCREEN_BOTTOM-14},
}
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("MemoryCardDisplay ready", ToEnumShortString(player) ),
		InitCommand=function(s) s:xy( cardpos[player][1] ,cardpos[player][2]-2 ):visible(true) end;
		SYSTEMUpdateTextMessageCommand=function(self)
			self:visible(false)
			-- Based on what the player contains, update the sprite accordingly.
				local status = {
					["ready"] = THEME:GetPathG("MemoryCardDisplay ready", ToEnumShortString(player) ),
					["checking"] = THEME:GetPathG("MemoryCardDisplay checking", ToEnumShortString(player) ),
					["late"] = THEME:GetPathG("MemoryCardDisplay late", ToEnumShortString(player) ),
					["error"] = THEME:GetPathG("MemoryCardDisplay error", ToEnumShortString(player) ),
					["removed"] = THEME:GetPathG("MemoryCardDisplay removed", ToEnumShortString(player) ),
				}
				if ToEnumShortString(MEMCARDMAN:GetCardState(player)) ~= "none" then
					self:visible(true):Load( status[ ToEnumShortString(MEMCARDMAN:GetCardState(player)) ] )
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
