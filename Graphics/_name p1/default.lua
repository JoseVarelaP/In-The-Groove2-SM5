local player = ...
local itgmarginspace = ThemePrefs.Get("ITG1") and 2 or 0
assert(player)
return Def.ActorFrame{
	LoadActor( "_name frame" )..{ Condition=not ThemePrefs.Get("ITG1"); };
	LoadActor( THEME:GetPathB("","_frame 3x1"), {"small name",98} )..{ Condition=ThemePrefs.Get("ITG1"); };
	
	Def.BitmapText{
	Font="_eurostile normal",
	OnCommand=function(self)
		self:shadowlength(2):zoom(0.5):x(-16):y(-2+itgmarginspace)
		if GAMESTATE:IsSideJoined(player) then
			self:diffuse(PlayerColor(player))
			self:settext(GAMESTATE:GetPlayerDisplayName(player))
		end
	end
	},
	
	LoadActor( "icon ".. ToEnumShortString(player) )..{
		 OnCommand=function(self)
			self:shadowlength(2):x(44):y(-4+itgmarginspace)
		end
	},
}