local t = Def.ActorFrame{}

local items = {
	{"chris", "Chris Danford\nSeattle, WA"},
	{"kyle", "Kyle Ward\nSeattle, WA"},
	{"foy", "Chris Foy\nSeattle, WA"},
	{"ryan", "Ryan McKanna\nNaperville, IL"},
	{"mj", "Matthew Emirzian\nToronto, ON"},
	{"matt", "Matt Puls\nCorvallis, OR"},
	{"glenn", "Glenn Maynard\nBoston, MA"},
	{"heather", "Heather Dority\nAustin, TX"},
	{"jason", "Jason Asbahr\nAustin, TX"},
	{"john", "John Cooney\nAustin, TX"},
	{"illusionz", "Illusionz\nIssaquah, WA" },
	{"8otb", "8 on the Break\nDunellen, NJ"},
};

for i,v in ipairs(items) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(s) s:hibernate(3*i):sleep(5):queuecommand("h") end;
		hCommand=function(s) s:visible(false) end;

		Def.ActorFrame{
			OnCommand=function(s) s:z(1):zoomy(0.5):linear(1):zoomy(2.5):linear(3):zoomy(2.2):linear(0.7):zoomy(1.5) end;
			Def.Quad{ OnCommand=function(s)
				s:clearzbuffer(true):zwrite(1):blend(Blend.NoEffect):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):cropright(0):linear(1):cropright(1)
				:sleep(0):cropright(0):cropleft(1):linear(3):linear(0.7):cropleft(0)
			end; },
			Def.Quad{ OnCommand=function(s) s:zwrite(1):blend(Blend.NoEffect):vertalign("bottom"):zoomto(SCREEN_WIDTH,400):y(-80):linear(3) end; },
			Def.Quad{ OnCommand=function(s) s:zwrite(1):blend(Blend.NoEffect):vertalign("top"):zoomto(SCREEN_WIDTH,400):y(80):linear(3) end; },
		};

		Def.Quad{ OnCommand=function(s) s:ztest(1):zoomto(SCREEN_WIDTH,400):diffuse(Color.Black) end; },

		Def.Sprite{ Texture=v[1].."_pic",
			OnCommand=function(s) s:ztest(1):fadeleft(0.1):faderight(0.1):linear(5):zoom(1.1):queuecommand("h") end;
			hCommand=function(s) s:visible(false) end;
		};

		Def.Sprite{
			Texture="streak",
			OnCommand=function(s)
				s:zoomtowidth(SCREEN_WIDTH):zoomy(0.5):cropleft(1):linear(1):cropleft(0):zoomy(2.5):linear(3):zoomy(2.2):linear(0.7):cropright(1):zoomy(1.5)
			end;
		};

		Def.BitmapText{
			Text=v[2],
			Font=_eurostileColorPick(),
			OnCommand=function(s)
				s:hibernate(1):halign(0):addx(-SCREEN_WIDTH-10):addy(130):decelerate(0.5):addx(SCREEN_WIDTH):linear(2)
				:addx(-12):linear(0.5):addx(-8):diffusealpha(0)
			end;
		};
	};
end

return t;