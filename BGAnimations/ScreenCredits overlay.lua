local LegalText = LoadModule("Legal.lua")()

return Def.ActorFrame{
	LoadActor("_scrolling ITG credits",false)..{
		OnCommand=function(self)
			self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH):sleep( ThemePrefs.Get("ShowThemeCredits") and 42 or 35 )
			:accelerate(0.3):addx(SCREEN_WIDTH)
		end,
		OffCommand=function(self)
			self:stoptweening():accelerate(0.3):addx(SCREEN_WIDTH)
		end
	},

	Def.Quad{
		OnCommand=function(self)
			self:visible(false):sleep(110):queuecommand("NextScreen")
		end,
		NextScreenCommand=function() SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end
	},

	Def.ActorScroller {
		SecondsPerItem = 2,
		NumItemsToDraw = 8,
		TransformFunction = function( self, offset, itemIndex, numItems) self:x(SCREEN_LEFT+50) self:y(offset*168) end,
		InitCommand=function(self)
			-- Apply commands to all text actors.
			self:RunCommandsRecursively(
				function(self)
					if self.settext then
						self:align(0,0):zoom(0.7):shadowlength(0)
					end
				end
			)
			self:hibernate( ThemePrefs.Get("ShowThemeCredits") and 37 or 31)
		end,
		OnCommand=function(self)
			self:scrollwithpadding(6,9)
		end,
			
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(  1, 10), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 11, 20), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 21, 30), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 31, 40), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 41, 50), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 51, 60), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 61, 70), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 71, 80), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 81, 90), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get( 91,100), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(101,110), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(111,120), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(121,130), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(131,140), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(141,150), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(151,160), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(161,170), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(171,180), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(181,190), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(191,200), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(201,210), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(211,220), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(221,230), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(231,240), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(241,250), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(251,260), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(261,270), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(271,280), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(281,290), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(291,300), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(301,310), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(311,320), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(321,330), Font="_eurostile normal" } },
			Def.ActorFrame{ Def.BitmapText{ Text=LegalText:Get(331,340), Font="_eurostile normal" } }
	}
}