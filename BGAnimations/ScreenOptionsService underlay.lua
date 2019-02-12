local t = Def.ActorFrame{};
InitUserPrefs();
t[#t+1] = Def.ActorFrame {
    OnCommand=function(self)
        if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
            Trace("ThemePrefs doesn't exist; creating file")
            ThemePrefs.ForceSave()
        end
        ThemePrefs.Save()
    end;

    LoadActor( "ScreenWithMenuElements underlay" ),

	LoadActor( THEME:GetPathG("","_options system page") )..{
	InitCommand=function(self)
		self:Center():addy(18)
	end;
	OnCommand=function(self)
		self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH)
	end;
	OffCommand=function(self)
		self:accelerate(0.3):addx(SCREEN_WIDTH)
	end;
	},

	LoadActor("ScreenOptions overlay/ScreenOptions frame")..{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):addy(18)
	end;
	OnCommand=function(self)
		self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH)
	end;
	OffCommand=function(self)
		self:accelerate(0.3):addx(SCREEN_WIDTH)
	end;
	},
};

return t;