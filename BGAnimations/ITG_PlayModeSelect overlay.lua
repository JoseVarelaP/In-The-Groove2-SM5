-- Begin by the actorframe
local t = Def.ActorFrame{};
local MenuIndex = 1;

local modes = { "dance", "rave", "nonstop", "oni" };

local PadChoices = {
    LoadActor( THEME:GetPathG("PlayMode","choices/dance") ),
    LoadActor( THEME:GetPathG("PlayMode","choices/rave") ),
    LoadActor( THEME:GetPathG("PlayMode","choices/nonstop") ),
    LoadActor( THEME:GetPathG("PlayMode","choices/oni") ),
};

local function CheckValueOffsets()
    print( "CheckValueOffsets ".. MenuIndex )
    if MenuIndex > #PadChoices  then MenuIndex = 1 end
    if MenuIndex < 1            then MenuIndex = #PadChoices end
    SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMaster","change") )
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    return
end

local BTInput = {
    -- This will control the menu
    ["MenuRight"] = function(event)
        MenuIndex = MenuIndex + 1
        MESSAGEMAN:Broadcast("MenuRight".. ToEnumShortString(event) )
        CheckValueOffsets()
    end,
    ["MenuLeft"] = function(event)
        MenuIndex = MenuIndex - 1
        MESSAGEMAN:Broadcast("MenuLeft".. ToEnumShortString(event) )
        CheckValueOffsets()
    end,
    ["Start"] = function(event)
        SCREENMAN:PlayStartSound()
        GAMESTATE:SetCurrentPlayMode( modes[MenuIndex] )
        SCREENMAN:GetTopScreen():SetNextScreenName( SelectMusicOrCourse() ):StartTransitioningScreen("SM_GoToNextScreen")
    end,
    ["Back"] = function(event)
        SCREENMAN:PlayCancelSound()
        SCREENMAN:GetTopScreen():SetPrevScreenName("SM_TitleMenu"):Cancel()
    end,
};

local ItemPlacement,Spacing = _screen.cx-320,126
-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{};

    -- This will be out choices 
    for index,mch in ipairs( modes ) do
        -- add the choice actorframes
        t[#t+1] = PadChoices[index]..{
            Name="pad"..index;
            MenuUpAllValMessageCommand=function(self)
                self:finishtweening():playcommand("LoseFocus")
                if MenuIndex == index then
                    self:playcommand("GainFocus")
                end
			end;
			OffCommand=function(self)
				if MenuIndex == index then
					MESSAGEMAN:Broadcast("Mode".. modes[MenuIndex] .."Chosen")
				else
					self:playcommand("ModeNotChosen")
                end
			end;
        };
    end

    return t;
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
    SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        self:xy( _screen.cx,_screen.cy-40 ):zoomto(SCREEN_WIDTH,160):diffuse( 0,0,0,0.4 )
    end;
};

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:x(SCREEN_CENTER_X+80):y(SCREEN_CENTER_Y+60):zoom(1.3):fov(45)
    end;    
        LoadActor("ScreenSelectStyle underlay/char")..{
            OnCommand=function(self)
                self:z(-100):zbuffer(true):glow(1,1,1,0):diffusealpha(0):linear(0.3):glow(1,1,1,1):sleep(0.001):diffusealpha(1):linear(0.3):glow(1,1,1,0)
            end;
            OffCommand=function(self)
                self:sleep(1.5):linear(0.3):diffusealpha(0)
            end;
        },
};

t[#t+1] = Def.ActorScroller{
	NumItemsToDraw=4;
	OnCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+12):z(-200):fov(45)
		self:SetFastCatchup(true):SetSecondsPerItem(0.2):SetDrawByZPosition(true):SetWrap(true)
	end;
    children = MainMenuChoices();
	TransformFunction=function(self, offset, itemIndex, numItems)
        local theta=offset*math.pi*1.5/numItems;
        local focus=scale(self:GetZ(),-100,400,0,1)
        focus = clamp(focus,0,1)
        local bright=scale(focus,0,1,0.15,1)
        local zoomv=scale(focus,0,1,0.7,1)
        self:finishtweening():decelerate(0.2)
        self:x( math.sin( theta )*200 )
        self:z( math.cos( theta )*330 )
        self:y( (MenuIndex-1) == itemIndex and 30 or -70 )
        self:diffuse( (MenuIndex-1) == itemIndex and Color.White or color("0.2,0.2,0.2,1") )
        self:zoom(zoomv)
	end;
    MenuUpAllValMessageCommand=function(self)
        print( self:GetCurrentItem() )
		self:SetDestinationItem(MenuIndex-1)
        self:PositionItems()
    end;
};

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X+82):y(SCREEN_CENTER_Y+134):diffusealpha(0):linear(0.5):diffusealpha(1)
	end;
	OffCommand=function(self)
		self:linear(0.5):diffusealpha(0)
    end;
    
    LoadActor("ScreenSelectStyle underlay/explanation frame"),
    Def.BitmapText{
        Font="_eurostile normal",
        OnCommand=function(self)
            self:zoomtowidth(300):halign(0):zoom(0.8):x(-160):shadowlength(3)
            :skewx(-0.21)
        end;
        MenuUpAllValMessageCommand=function(self)
            self:finishtweening():cropright(1)
            :settext( THEME:GetString("ScreenSelectPlayMode","Explanation"..modes[MenuIndex] ) )
            :linear(0.5):cropright(0)
        end;
    }
};

t[#t+1] = Controller;

t[#t+1] = LoadActor("_shared underlay arrows")
t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
    end;

    Def.BitmapText{
    Font="_eurostile blue glow",
    Text="SELECT A STYLE",
    InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
    OnCommand=function(self)
        self:zoomx(0):zoomy(6):bounceend(.3):zoom(1)
    end;
    OffCommand=function(self)
        self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
    end;
    },

};

return t;