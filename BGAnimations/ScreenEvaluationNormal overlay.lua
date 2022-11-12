local t = Def.ActorFrame{}
local itgstylemargin = ThemePrefs.Get("ITG1") and -10 or 0

local function side(pn)
	local s = 1
	if pn == PLAYER_1 then return s end
	return s*(-1)
end

local function Gradeside(pn)
	local s = -230+(itgstylemargin*1.2)
	if pn == PLAYER_2 then s = 56+(itgstylemargin*-1.3) end
	return s
end

local function pnum(pn)
	if pn == PLAYER_2 then return 2 end
	return 1
end

local itgstylemargin = ThemePrefs.Get("ITG1") and -10 or 0
local battlegraphloc = ThemePrefs.Get("ITG1") and "ITG1/" or ""
t[#t+1] = Def.Sprite{
	Condition=GAMESTATE:GetPlayMode() == "PlayMode_Rave",
	Texture=THEME:GetPathG("ScreenEvaluation grade frame/battle/"..battlegraphloc.."graph","frame"),
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+500)
		:sleep(2.8):decelerate(0.5)
		:y(SCREEN_CENTER_Y+54+itgstylemargin*1.8)
	end,
	OffCommand=function(self)
		self:accelerate(0.3):addy(500)
	end
}

-- Grade and Frame Info
local DoublesIsOn = GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_OnePlayerTwoSides"
for player in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(player) then
		t[#t+1] = Def.ActorFrame{
			LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame"), player )..{
				InitCommand=function(self)
					local margin = GAMESTATE:GetPlayMode() == "PlayMode_Rave" and 164 or 145
					self:xy( DoublesIsOn and SCREEN_CENTER_X or ( SCREEN_CENTER_X+((-margin+itgstylemargin*1.2)*side(player)) ),SCREEN_CENTER_Y+54)
				end,
				OnCommand=function(self)
					self:addx( (DoublesIsOn and -SCREEN_WIDTH/1.2 or -SCREEN_WIDTH/2)*side(player) )
					:sleep(3):decelerate(0.3)
					:addx( (DoublesIsOn and SCREEN_WIDTH/1.2 or SCREEN_WIDTH/2)*side(player) )
				end,
				OffCommand=function(self)
					self:accelerate(0.3):addx( (DoublesIsOn and -SCREEN_WIDTH/1.2 or -SCREEN_WIDTH/2)*side(player) )
				end,
			}
		}

		t[#t+1] = Def.ActorFrame{
			Condition=GAMESTATE:GetPlayMode() ~= "PlayMode_Rave",
			OnCommand=function(self)
				self:xy( DoublesIsOn and SCREEN_CENTER_X or (SCREEN_CENTER_X+(-145*side(player)) ),SCREEN_CENTER_Y-60)
				:zoom(2):addx( (-SCREEN_WIDTH)*side(player) ):decelerate(0.5)
				:addx( SCREEN_WIDTH*side(player) ):sleep(2.2):decelerate(0.5):zoom(0.9)
				self:xy( DoublesIsOn and SCREEN_CENTER_X-80 or (SCREEN_CENTER_X+Gradeside(player) ) ,SCREEN_CENTER_Y-38+(itgstylemargin*2))
			end,
			OffCommand=function(self)
				self:accelerate(0.3):addx((DoublesIsOn and -SCREEN_WIDTH/1.2 or -SCREEN_WIDTH/2)*side(player))
			end,
			
			LoadActor( THEME:GetPathG("", "_grade models/"..STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetGrade()..".lua" ) )
		}
	end
end

t[#t+1] = Def.ActorFrame{
	-- The biggest challenge here was to compesate the positions because of SM5's TextureFiltering.
	-- It is different from 3.95/OpenITG's filters, which differ a lot with the original positions.
	-- IN ADDITION of the different x and y handling anyways.
	-- 																			Jose_Varela
	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(35,38)
		end,

		Def.BitmapText{
		Font=_eurostileColorPick(),
		Text=string.upper(THEME:GetString("ScreenEvaluation","HeaderText")),
			InitCommand=function(self) self:shadowlength(4):x(self:GetWidth()/2):skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(0.3):zoom(1)
			end,
			OffCommand=function(self)
				self:accelerate(0.2):zoomx(2):zoomy(0):diffusealpha(0)
				SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start") or THEME:GetPathS("_ITGCommon","start") )
			end
		},

		Def.Sprite{
			Texture=THEME:GetPathG("ScreenWithMenuElements Items/stage",""..StageIndexBySegment(true)),
			Condition=not ThemePrefs.Get("ITG1"),
			OnCommand=function(self)
				if GAMESTATE:GetCurrentStage() == "Stage_Final" then
					self:Load( THEME:GetPathG("ScreenWithMenuElements Items/stage","final") )
				end
				self:x(30):y(34):addx(-SCREEN_WIDTH):sleep(3):decelerate(0.3):addx(SCREEN_WIDTH)
			end,
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end
		},
	
		LoadActor( THEME:GetPathG("ScreenWithMenuElements","Items/ITG1"), true )..{
			Condition=ThemePrefs.Get("ITG1"),
			OnCommand=function(self)
				self:xy(SCREEN_RIGHT-140,0):addx(SCREEN_WIDTH):sleep(0.2):decelerate(0.6):addx(-SCREEN_WIDTH)
			end,
			OffCommand=function(self) self:accelerate(.5):addx(SCREEN_WIDTH) end
		}
	},

	-- Banner frame
	LoadActor( THEME:GetPathG("Evaluation","banner frame mask") )..{
		Condition=not ThemePrefs.Get("ITG1"),
		InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
		OnCommand=function(self)
			self:zwrite(1):z(1):blend("BlendMode_NoEffect"):y(SCREEN_TOP-100):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-125):zoom(1.02)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end
	},

	LoadActor( THEME:GetPathB("","_frame 3x1"), {"banner mask",194,1} )..{
		Condition=ThemePrefs.Get("ITG1"),
		InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
		OnCommand=function(self)
			-- self:zwrite(1):z(1):blend("BlendMode_NoEffect")
			self:y(-100):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-148)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end
	},

	Def.Sprite{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126)
			local bannerPath = THEME:GetPathG( (ThemePrefs.Get("ITG1") and "ITG1/" or "ITG2 ") .."Common fallback", "banner")
			if GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetBannerPath() ~= nil then
				bannerPath = GAMESTATE:GetCurrentCourse():GetBannerPath()
			end
			if GAMESTATE:GetCurrentSong() and not GAMESTATE:IsCourseMode() then
				if GAMESTATE:GetCurrentSong():GetBannerPath() ~= nil then 
					bannerPath = GAMESTATE:GetCurrentSong():GetBannerPath()
				end
				for pn in ivalues(PlayerNumber) do
					if GAMESTATE:GetCurrentSong():GetGroupName() == PROFILEMAN:GetProfile(pn):GetDisplayName() then
						bannerPath = THEME:GetPathG("Banner","custom")
					end
				end
			end

			self:Load( bannerPath )
		end,
		OnCommand=function(self)
			self:scaletoclipped( ThemePrefs.Get("ITG1") and 418/1.6 or 418/2,164/2):ztest(1):y(SCREEN_TOP-100):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-124+(itgstylemargin*2.4))
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end
	},

	LoadActor( THEME:GetPathB("","_frame 3x1"), {"banner frame",194} )..{
		Condition=ThemePrefs.Get("ITG1"),
		InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
		OnCommand=function(self)
			self:y(SCREEN_TOP-100):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-148)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end
	},
	
	LoadActor( THEME:GetPathG("","ScreenEvaluation banner frame") )..{
		Condition=not ThemePrefs.Get("ITG1"),
		InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
		OnCommand=function(self)
			self:y(SCREEN_TOP-100):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-124)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end
	},

	Def.HelpDisplay {
		File="_eurostile normal",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink():maxwidth(SCREEN_WIDTH/0.8)
			:zoomy(0):sleep(2.5):linear(0.5):zoomy(0.7)
		end,
		InitCommand=function(self)
			local s = THEME:GetString("ScreenEvaluation","HelpTextNormal") .. "::" .. THEME:GetString("ScreenEvaluation","TakeScreenshotHelpTextAppend")
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(s)
		end,
		OffCommand=function(self)
			self:linear(0.5):zoomy(0)
		end
	}
}

collectgarbage()
return t
