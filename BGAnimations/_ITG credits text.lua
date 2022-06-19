local stopatframe=...

local ITGThemeCredits = {
	{0},
	{0},
	{0},
	{0},
	{1,"IN THE GROOVE 2"},
	{1,"STEPMANIA 5 CONVERSION"},
	{0},
	{0},
	{2,THEME:GetString("Credits","Programming")},
	{3,"Jose_Varela"},
	{0},
	{2,"ADDITIONAL HELP"},
	{3,"dbk2"},
	{3,"Melody"},
	{3,"MadkaT"},
	{0},
	{2,"FEEDBACK"},
	{3,"dbk2"},
	{3,"Telperion"},
	{3,"Moru Zerinho"},
	{3,"willycel123"},
	{3,"Melody"},
	{3,"MadkaT"},
	{0},
	{2,THEME:GetString("Credits","SpecialThanks")},
	{3,"UKSRT Discord"},
	{0},
}

local ITGCredits_Table = {
	-- 0 is nothing.
	-- 1 is Header.
	-- 2 is Subheader.
	-- 3 is Normal text.
	{0},
	{0},
	{0},
	{0},
	{1,"IN THE GROOVE TEAM"},
	{0},
	{0},
	{2,THEME:GetString("Credits","Producer")},
	{3,"Jason Asbahr"},
	{0},
	{2,THEME:GetString("Credits","Programming")},
	{3,"Glenn Maynard"},
	{3,"Chris Danford"},
	{0},
	{2,THEME:GetString("Credits","Sound")},
	{3,"Kyle Ward"},
	{0},
	{2,THEME:GetString("Credits","StepArtists")},
	{3,"Kyle Ward"},
	{3,"Chris Foy"},
	{3,"Matthew Emirzian"},
	{3,"Ryan McKanna"},
	{3,"Matt Puls"},
	{3,"Jonas Casarino"},
	{3,"Christopher Emirzian"},
	{0},
	{2,THEME:GetString("Credits","ThemeGraphics")},
	{3,"Heather Dority"},
	{3,"Ryan McKanna"},
	{3,"Chris Danford"},
	{3,"Glenn Maynard"},
	{0},
	{2,THEME:GetString("Credits","SongGraphics")},
	{3,"Ryan McKanna"},
	{3,"Matt Puls"},
	{3,"Heather Dority"},
	{0},
	{2,THEME:GetString("Credits","Business")},
	{3,"Jason Asbahr"},
	{3,"John Cooney"},
	{0},
	{2,THEME:GetString("Credits","Sysadmin")},
	{3,"Travis B. Hartwell"},
	{0},
	{2,THEME:GetString("Credits","Hardware")},
	{3,"John Cooney"},
	{0},
	{2,THEME:GetString("Credits","Illustrator")},
	{3,"Beth Schultz"},
	{0},
	{2,THEME:GetString("Credits","TestLocations")},
	{3,"8 on the Break - Dunellen, NJ"},
	{0},
	{2,THEME:GetString("Credits","SpecialThanks")},
	{3,"Kevin McKanna"},
	{3,"Jennifer Putzier"},
	{3,"Rhea Dysangco"},
	{3,"Cinnamon Cooney"},
	{3,"Lee Search"},
	{3,"Gina “Lou” Hall"},
	{3,"Aaron Shafer"},
	{3,"Kristy Bowden"},
	{3,"Koley Porter"},
	{3,"Audrey Maker"},
	{3,"Andrew Locko"},
	{0},
	{1,"RED OCTANE SOFTWARE"},
	{3,"John Tam"},
	{3,"Ted Lange"},
	{3,"Mark Johnson"},
	{3,"Raul Renteria"},
	{3,"Jordan Dodge"},
	{3,"Daniyel Garcia"},
	{0},
	{1,"STEPMANIA PROGRAMMERS"},
	{3,"Frieza"},
	{3,"Peter “Dro Kulix” May"},
	{3,"Jared “nmspaz” Roberts"},
	{3,"Brendan “binarys” Walker"},
	{3,"Lance “Neovanglist” Gilbert"},
	{3,"Michel Donais"},
	{3,"Ben “Mantis” Nordstrom"},
	{3,"Chris “Parasyte” Gomez"},
	{3,"Michael “dirkthedaring” Patterson"},
	{3,"Sauleil “angedelamort” Lamarre"},
	{3,"Edwin Evans"},
	{3,"Brian “Bork” Bugh"},
	{3,"Joel “Elvis314” Maher"},
	{3,"Garth “Kefabi” Smith"},
	{3,"Pkillah"},
	{3,"Robert Kemmetmueller"},
	{3,"Ben “Shabach” Andersen"},
	{3,"Will “SlinkyWizard” Valladao"},
	{3,"TheChip"},
	{3,"David “WarriorBob” H"},
	{3,"Mike Waltson"},
	{3,"Kevin “Miryokuteki” Slaughter"},
	{3,"Thad “Coderjoe” Ward"},
	{3,"Steve Checkoway"},
	{3,"Sean Burke"},
	{3,"XPort"},
	{0},
	{0},
	{0},
	{0},
	{0},
	{0},
	{0},
	{0},
	{1,"IN THANKS AND MEMORY OF"},
	-- If you don't know:
	-- Steve Blattspieler worked on Andamiro USA, but past away due to lung cancer during the development of ITG2.	
	{3,"Steve Blattspieler"},
	{0},
	{0},
}

local af = Def.ActorScroller {
	SecondsPerItem = 0.28,
	NumItemsToDraw = 21,
	TransformFunction = function( self, offset, itemIndex, numItems) self:y(offset*24) end,
	OnCommand=function(self)
		self:scrollwithpadding(6,stopatframe and -2 or 921)
	end
}

if ThemePrefs.Get("ShowThemeCredits") then
	for i=1,table.getn(ITGThemeCredits) do
		af[#af+1] = Def.ActorFrame{  Def.BitmapText{ Text=ITGThemeCredits[i][2] or "", Font="_eurostile outline",
			InitCommand=function(self)
			self:zoom(0.7):ztest(1)
				if ITGThemeCredits[i][1] == 1 then self:diffuse( color("#D57676") ) end
				if ITGThemeCredits[i][1] == 2 then self:diffuse( color("#76B1D5") ):zoom(0.6) end
			end
		}
	}
	end
end
for i=1,table.getn(ITGCredits_Table) do
	af[#af+1] = Def.ActorFrame{  Def.BitmapText{ Text=ITGCredits_Table[i][2] or "", Font="_eurostile outline",
	InitCommand=function(self)
		self:zoom(0.7):ztest(1)
			if ITGCredits_Table[i][1] == 1 then self:diffuse( color("#D57676") ) end
			if ITGCredits_Table[i][1] == 2 then self:diffuse( color("#76B1D5") ):zoom(0.6) end
		end
	},
}
end

return af
