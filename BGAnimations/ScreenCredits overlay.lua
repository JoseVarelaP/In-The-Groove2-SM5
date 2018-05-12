return Def.ActorFrame{
	LoadActor("_scrolling ITG credits")..{
	OnCommand=cmd(addx,-SCREEN_WIDTH;decelerate,0.3;addx,SCREEN_WIDTH;sleep,42;accelerate,0.3;addx,SCREEN_WIDTH);
	OffCommand=cmd(stoptweening;accelerate,0.3;addx,SCREEN_WIDTH);
	},

	Def.Quad{
		OnCommand=function(self)
		self:visible(false):sleep(110):queuecommand("NextScreen")
		end,
		NextScreenCommand=function() SCREENMAN:SetNewScreen("ScreenTitleMenu") end;
		},

	Def.ActorScroller {
	SecondsPerItem = 2,
	NumItemsToDraw = 8,
	TransformFunction = function( self, offset, itemIndex, numItems) self:x(SCREEN_LEFT+50) self:y(offset*168) end,
	InitCommand=cmd(hibernate,37);
	OnCommand=cmd(scrollwithpadding,6,9),

			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(  1, 10), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 11, 20), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 21, 30), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 31, 40), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 41, 50), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 51, 60), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 61, 70), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 71, 80), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 81, 90), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText( 91,100), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(101,110), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(111,120), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(121,130), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(131,140), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(141,150), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(151,160), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(161,170), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(171,180), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(181,190), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(191,200), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(201,210), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(211,220), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(221,230), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(231,240), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(241,250), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(251,260), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(261,270), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(271,280), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(281,290), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(291,300), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(301,310), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(311,320), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(321,330), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
			Def.ActorFrame{ Def.BitmapText{ Text=GetLegalText(331,340), Font="_eurostile normal", OnCommand=cmd(horizalign,left;vertalign,top;zoom,0.7;shadowlength,0); OffCommand=cmd(linear,0.3;diffusealpha,0); }, },
	},
}