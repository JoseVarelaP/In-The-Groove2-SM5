local function Unlock(name)
	local codenumber = tonumber(string.sub(name, 6))
	local Series = string.sub(name, 0,-3)
	local codes = {
		["ITG1_"] = {
			"Disconnected -Hyper-", -- Left,Right,Up,Down,Left,Left,Right,Right
			"Disconnected -Mobius-", -- Left,Down,Right,Down,Up,Right,Down,Left
			"Infection", -- Up,Down,Up,Down,Up,Down,Right,Right,Up
			"Xuxa", -- Right,Up,Down,Down,Right,Down,Up,Left,Down
			"Tell", -- Down,Left,Up,Up,Right,Right,Down,Left,Down
			"Bubble Dancer", -- Right,Left,Left,Right,Up,Down,Down,Left,Left
			"Don't Promise Me ~Happiness~", -- Up,Right,Up,Left,Down,Left,Right,Left,Right
			"Anubis", -- Left,Down,Up,Left,Down,Down,Right,Right,Up
			"DJ Party", -- Left,Right,Right,Left,Up,Down,Right,Left,Down
			"Pandemonium", -- Left,Up,Left,Down,Up,Down,Right,Down,Left
		},
		["ITG2_"] = {
			"Disconnected Disco", -- Up,Down,Down,Up,Left,Left,Down,Right,Down,Up,Right
			"VerTex^2", -- Left,Down,Right,Right,Right,Down,Left,Up,Up,Down,Right
			"Wanna Do", -- Right,Right,Up,Up,Up,Right,Left,Left,Up,Up,Up
			"Know Your Enemy", -- Right,Left,Down,Down,Down,Up,Left,Down,Left,Left,Right
			"Hardcore Symphony", -- Down,Up,Up,Left,Down,Right,Down,Right,Right,Down,Up
            {"!"}
		}
    }
    local unlockid = Series == "ITG1_" and codenumber or codenumber+#codes["ITG1_"]
    if UNLOCKMAN:GetUnlockEntry(unlockid-1) then
        -- if UNLOCKMAN:GetUnlockEntry(unlockid-1):IsLocked() then
            local isChartUnlock = UNLOCKMAN:GetUnlockEntry(unlockid-1):GetUnlockRewardType() == 1
            lua.ReportScriptError(isChartUnlock)
            local SongToFind = isChartUnlock and codes[Series][codenumber][1] or codes[Series][codenumber]
            UNLOCKMAN:UnlockEntryIndex( unlockid-1 )
            if not isChartUnlock then
                SOUND:DimMusic( 0.2, 3 )
                SOUND:PlayOnce( THEME:GetPathS("Unlocked",SongToFind) )
            end
            GAMESTATE:SetPreferredSong( SONGMAN:FindSong( SongToFind ) )
            MESSAGEMAN:Broadcast("UnlockMade",{ Name=SongToFind })
        -- end
    end
end

-- Begin by the actorframe
local t = Def.ActorFrame{}
local MenuIndex = 1
local scroller

local modes = { "dance", "rave", "nonstop" }
local stringmodes = { "Dance", "Battle", "Marathon", "Oni" }
local PadChoices = {}

if ThemePrefs.Get("ToggleSurvival") then
    modes[#modes+1] = "oni"
end

for i,v in ipairs(modes) do
    PadChoices[#PadChoices+1] = LoadActor( THEME:GetPathG("PlayMode","choices/"..v) )
end

local function CheckValueOffsets(offset)
    MenuIndex = MenuIndex + offset
    print( "CheckValueOffsets ".. MenuIndex )
    if MenuIndex > #PadChoices  then MenuIndex = 1 end
    if MenuIndex < 1            then MenuIndex = #PadChoices end
    scroller:playcommand("Move",{Dir = offset})
    SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMaster","change") )
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    return
end

local BTInput = {
    -- This will control the menu
    ["MenuRight"] = function(event)
        CheckValueOffsets(1)
    end,
    ["MenuLeft"] = function(event)
        CheckValueOffsets(-1)
    end,
    ["Start"] = function(event)
        SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
		or THEME:GetPathS("_ITGCommon","start") )
        local mode = modes[MenuIndex] == "dance" and "regular" or modes[MenuIndex]
        GAMESTATE:ApplyGameCommand("playmode,".. mode)
        SCREENMAN:GetTopScreen():SetNextScreenName( "ITG_StyleSelect" ):StartTransitioningScreen("SM_GoToNextScreen")
    end,
    ["Back"] = function(event)
        SCREENMAN:PlayCancelSound()
        SCREENMAN:GetTopScreen():SetPrevScreenName(Branch.TitleMenu()):Cancel()
    end,
}

local ItemPlacement,Spacing = _screen.cx-320,126
-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{}

    -- This will be out choices 
    for index,mch in ipairs( modes ) do
        -- add the choice actorframes
        t[#t+1] = PadChoices[index]..{
            Name="pad"..index,
            MenuUpAllValMessageCommand=function(self)
                self:finishtweening():playcommand("LoseFocus")
                if MenuIndex == index then
                    self:playcommand("GainFocus")
                end
			end,
			OffCommand=function(self)
				if MenuIndex == index then
					MESSAGEMAN:Broadcast("Mode".. modes[MenuIndex] .."Chosen")
				else
					self:playcommand("ModeNotChosen")
                end
			end
        }
    end

    return t
end
    
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end
    local ET = ToEnumShortString(event.type)
    -- Input that occurs at the moment the button is pressed.
    if ET == "FirstPress" or ET == "Repeat" then
        if BTInput[event.GameButton] then
            BTInput[event.GameButton](event.PlayerNumber)
        end
    end
end

local Controller = Def.ActorFrame{
    OnCommand=function(self)
        MESSAGEMAN:Broadcast("MenuUpAllVal")
        SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
    end
}

t[#t+1] = Def.Quad{
    Condition = not ThemePrefs.Get("ITG1"),
    OnCommand=function(self)
        self:xy( _screen.cx,_screen.cy-40 ):zoomto(SCREEN_WIDTH,160):diffuse( 0,0,0,0.4 )
    end
}

t[#t+1] = Def.Actor{
    CodeMessageCommand=function(s,param)
        Unlock( param.Name )
    end
}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+60):zoom(1.3):fov(90)
    end,
    LoadActor( THEME:GetPathG("","chars/PlayMode") )..{
        OnCommand=function(self)
            self:z(-100):zbuffer(true):glow(1,1,1,0):diffusealpha(0):linear(0.3):glow(1,1,1,1):sleep(0.001):diffusealpha(1):linear(0.3):glow(1,1,1,0)
        end,
        OffCommand=function(self)
            self:sleep(1.5):linear(0.3):diffusealpha(0)
        end
    }
}

t[#t+1] = LoadActor("ScreenWithMenuElements underlay/fore")

t[#t+1] = Def.ActorScroller{
	NumItemsToDraw = 6,
    Subdivisions = 4,
    SecondsPerItem = 0.3,
    LoopScroller = true,
    WrapScroller = true,
    InitCommand=function(self)
        scroller = self
    end,
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+12):z(-200):fov(90)
		self:SetFastCatchup(true):SetDrawByZPosition(true)
	end,
    children = MainMenuChoices(),
	TransformFunction=function(self, offset, itemIndex, numItems)
        local theta=offset*math.pi*2/numItems
        self:x( math.sin( theta )*200 )
        :z( math.cos( theta )*200 )
        :y( self:GetZ()/2.2-50 )
        :diffuse( offset == 0 and Color.White or color("0.5,0.5,0.5,1") )
        
        local focus=scale(self:GetZ(),-100,400,0,1)
        focus = clamp(focus,0,1)
        local zoomv=scale(focus,0,1,0.7,1)
        self:zoom(zoomv)
	end,
    MoveCommand=function(self, params)
        local oldChoice = self:GetCurrentItem()
        local newChoice = MenuIndex
        -- HACK: We can't tell from the option orders whether or not we wrapped.
		-- For now, assume that the order is increasing left to right.
		local PressedDir = params.Dir
        local ActualDir = (oldChoice < newChoice) and 1 or -1

        if PressedDir ~= ActualDir then
            local item = self:GetCurrentItem()
            local currentChoices = #modes
            item = item + (ActualDir * currentChoices) 
            self:SetCurrentAndDestinationItem(item)
        end
		self:SetDestinationItem(newChoice-1)
        :PositionItems()
    end
}
local isITG1 = ThemePrefs.Get("ITG1")

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+82):y(SCREEN_CENTER_Y+134):diffusealpha(0):linear(0.5):diffusealpha(1)
	end,
	OffCommand=function(self)
		self:linear(0.5):diffusealpha(0)
    end,
    
    LoadActor("ScreenSelectStyle underlay/explanation frame")..{
        InitCommand=function(self)
            self:diffuse( isITG1 and color("#000000") or Color.White )
        end
    },
    Def.BitmapText{
        Font="_eurostile normal",
        OnCommand=function(self)
            self:zoomtowidth(300):halign(0):zoom(isITG1 and 1 or 0.8):x(-160):shadowlength(3)
            :zoomx( isITG1 and 1.1 or 1 ):maxwidth( isITG1 and 300 or 330 )
            :skewx(-0.21)
        end,
        MenuUpAllValMessageCommand=function(self)
            self:finishtweening():cropright(1)
            :settext( THEME:GetString("ScreenSelectPlayMode","Explanation"..stringmodes[MenuIndex] ) )
            :linear(0.5):cropright(0)
        end
    }
}

t[#t+1] = Controller

t[#t+1] = LoadActor("_shared underlay arrows")
t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(35,38)
    end,

    Def.BitmapText{
        Font=_eurostileColorPick(),
        Text="SELECT A STYLE",
        InitCommand=function(self) self:shadowlength(4):x(self:GetWidth()/2):skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
        OnCommand=function(self)
            self:zoomx(0):zoomy(6):bounceend(.3):zoom(1)
        end,
        OffCommand=function(self)
            self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
        end
    }
}

t[#t+1] = Def.HelpDisplay {
    File="_eurostile normal",
    OnCommand=function(self)
        self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink():maxwidth(SCREEN_WIDTH/0.8)
    end,
    InitCommand=function(self)
        self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
        self:SetTipsColonSeparated( THEME:GetString("ScreenSelectStyle2","HelpText") )
    end,
    OffCommand=function(self)
        self:linear(0.5):zoomy(0)
    end,
    UnlockMadeMessageCommand=function(self,param)
        self:SetTipsColonSeparated( string.format( THEME:GetString("ScreenUnlock", "Unlocked %s:"), param.Name ) ):sleep(5):queuecommand("ResetText")
    end,
    ResetTextCommand=function(self)
        self:SetTipsColonSeparated( THEME:GetString("ScreenSelectStyle2","HelpText") )
    end
}

return t