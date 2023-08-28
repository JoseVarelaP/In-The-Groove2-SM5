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
		}
    }
    local unlockid = Series == "ITG1_" and codenumber or codenumber+#codes["ITG1_"]
    if UNLOCKMAN:GetUnlockEntry(unlockid-1) then
        if UNLOCKMAN:GetUnlockEntry(unlockid-1):IsLocked() then
	        SOUND:DimMusic( 0.2, 3 )
            SOUND:PlayOnce( THEME:GetPathS("Unlocked",codes[Series][codenumber]) )
            UNLOCKMAN:UnlockEntryIndex( unlockid-1 )
            GAMESTATE:SetPreferredSong( SONGMAN:FindSong( codes[Series][codenumber] ) )
            MESSAGEMAN:Broadcast("UnlockMade",{ Name=codes[Series][codenumber] })
        end
    end
end

-- Begin by the actorframe
local t = Def.ActorFrame{}
local MenuIndex = 1
local scroller

local modes = { "single", "versus", "double" }
local MenuChoices = { 1,2,3 }
local padloc = {"Single","Versus","Double"}

-- In Battle mode, double is not available.
if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
    table.remove(modes, 3)
    table.remove(MenuChoices, 3)
    table.remove(padloc, 3)
end

local function CheckValueOffsets(offset)
    MenuIndex = MenuIndex + offset
    if MenuIndex > #padloc  then MenuIndex = 1 end
    if MenuIndex < 1            then MenuIndex = #padloc end
    if GAMESTATE:GetCoinMode() == "CoinMode_Pay" then
        if MenuIndex == 2 or MenuIndex == 3 then
            if GAMESTATE:GetNumPlayersEnabled() < 2 and (GAMESTATE:GetCoins() < GAMESTATE:GetCoinsNeededToJoin()) then
                MenuIndex = 1
            end
        end
    end

    scroller:playcommand("Move",{Dir = offset})

    SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMaster","change") )
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    return
end

local BTInput = {
    -- This will control the menu
    ["MenuRight"] = function(event)
        -- MenuIndex = MenuIndex + 1
        -- MESSAGEMAN:Broadcast("MenuRight".. ToEnumShortString(event) )
        -- WrapperVisualItem = WrapperVisualItem + 1
        CheckValueOffsets(1)
    end,
    ["MenuLeft"] = function(event)
        -- MenuIndex = MenuIndex - 1
        -- MESSAGEMAN:Broadcast("MenuLeft".. ToEnumShortString(event) )
        -- WrapperVisualItem = WrapperVisualItem - 1
        CheckValueOffsets(-1)
    end,
    ["Start"] = function(event)
        if GAMESTATE:IsSideJoined(event) then
            if GAMESTATE:GetCoinMode() == "CoinMode_Pay" then
                if MenuIndex == 2 or MenuIndex == 3 then
                    if GAMESTATE:GetNumPlayersEnabled() == 1 then
                        GAMESTATE:InsertCoin( -GAMESTATE:GetCoinsNeededToJoin() )
                    end
                end
            end
            if MenuIndex == 2 then
                GAMESTATE:JoinPlayer(PLAYER_1)
                GAMESTATE:JoinPlayer(PLAYER_2)
            end
            SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
            if not GAMESTATE:Env()["WorkoutMode"] then
                SOUND:StopMusic()
            end
            GAMESTATE:SetCurrentStyle( modes[MenuIndex] )
            SCREENMAN:GetTopScreen():SetNextScreenName( GAMESTATE:Env()["WorkoutMode"] and "ScreenWorkoutMenu" or SelectMusicOrCourse() ):StartTransitioningScreen("SM_GoToNextScreen")
        else
            if GAMESTATE:GetCoins() >= 1 then
                GAMESTATE:JoinPlayer(event)
                SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
                or THEME:GetPathS("_ITGCommon","start") )
                GAMESTATE:InsertCoin(-1)
            end
        end
    end,
    ["Back"] = function(event)
        SCREENMAN:PlayCancelSound()
        SCREENMAN:GetTopScreen():SetPrevScreenName(Branch.TitleMenu()):Cancel()
    end
}

local ItemPlacement,Spacing = _screen.cx-320,126
-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{}

    -- This will be out choices 
    for index in ipairs( MenuChoices ) do
        -- add the choice actorframes
        t[#t+1] = loadfile( THEME:GetPathG("ScreenSelectStyle","scroll/"..padloc[index]) )()..{
            Name="pad"..index,
            MenuUpAllValMessageCommand=function(self)
                self:finishtweening():stopeffect()
                if MenuIndex == index then
                    self:GetChild("")[1]:wag():effectmagnitude(0,10,0)
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
    SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end
}

t[#t+1] = Def.Quad{
    Condition = not ThemePrefs.Get("ITG1"),
    OnCommand=function(self)
        self:xy( _screen.cx,_screen.cy-40 ):zoomto(SCREEN_WIDTH,160):diffuse( 0,0,0,0.4 )
        if GAMESTATE:Env()["WorkoutMode"] then
            GAMESTATE:SetTemporaryEventMode(true)
        end
    end,
    OffCommand=function(self)
        self:sleep(1.5):linear(0.3):diffusealpha(0)
    end,
    CodeMessageCommand=function(s,param)
        Unlock( param.Name )
    end
}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:x(SCREEN_CENTER_X+80):y(SCREEN_CENTER_Y+60):zoom(1.3):fov(45)
    end,
    
    Def.Sprite{
        Texture=THEME:GetPathG("","chars/Style"),
        OnCommand=function(self)
            self:z(-100):zbuffer(true):glow(1,1,1,0):diffusealpha(0):linear(0.3):glow(1,1,1,1):sleep(0.001):diffusealpha(1):linear(0.3):glow(1,1,1,0)
        end,
        OffCommand=function(self)
            self:sleep(1.5):linear(0.3):diffusealpha(0)
        end
    }
}

t[#t+1] = loadfile( THEME:GetPathB("ScreenWithMenuElements","underlay/fore.lua"))()

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
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+12):z(-200):fov(50)
		self:SetFastCatchup(true):SetDrawByZPosition(true)
	end,
    children = MainMenuChoices(),
	TransformFunction=function(self, offset, itemIndex, numItems)
        local theta=offset*math.pi*2/numItems
        -- local theta = offset * 1
        self:x( math.sin( theta )*200 )
        :z( math.cos( theta )*200 )
        :y( self:GetZ()/2.2-20 )
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
            local currentChoices = #MenuChoices
            item = item + (ActualDir * currentChoices) 
            self:SetCurrentAndDestinationItem(item)
        end
		self:SetDestinationItem(newChoice-1)
        :PositionItems()
    end
}

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+82):y(SCREEN_CENTER_Y+134):diffusealpha(0):linear(0.5):diffusealpha(1)
	end,
	OffCommand=function(self)
		self:linear(0.5):diffusealpha(0)
    end,
    
    Def.Sprite{ Texture="ScreenSelectStyle underlay/explanation frame" },
    Def.BitmapText{
        Font="_eurostile normal",
        OnCommand=function(self)
            self:zoomtowidth(300):halign(0):zoom(0.8):x(-160):shadowlength(3)
            :skewx(-0.21):wrapwidthpixels(400)
        end,
        MenuUpAllValMessageCommand=function(self)
            local translated = {"1Player","2Player","Double"}
            self:finishtweening():cropright(1)
            :settext( THEME:GetString("ScreenSelectStyle2","Explanation"..translated[MenuIndex] ) )
            :linear(0.5):cropright(0)
        end
    }
}

t[#t+1] = Controller

t[#t+1] = loadfile( THEME:GetPathB("_shared underlay","arrows") )()
t[#t+1] = LoadModule("HeaderText.lua")("ScreenSelectStyle2")

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
        self:SetTipsColonSeparated( "Unlocked ".. param.Name ):sleep(5):queuecommand("ResetText")
    end,
    ResetTextCommand=function(self)
        self:SetTipsColonSeparated( THEME:GetString("ScreenSelectStyle2","HelpText") )
    end
}

t[#t+1] = loadfile( THEME:GetPathB("_menu","out") )()..{
    OnCommand=function(self)
        if ThemePrefs.Get("ITG1") then self:xy(GetTitleSafeH(0.9),GetTitleSafeV(0.8)) else self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y) end
        self:diffusealpha(0)
    end,
    OffCommand=function(self)
        if not GAMESTATE:Env()["WorkoutMode"] then
            self:sleep(1.5):linear(0.3):diffusealpha(1)
        end
    end
}

return t