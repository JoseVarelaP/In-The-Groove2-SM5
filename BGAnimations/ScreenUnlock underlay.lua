-- Unlock Display
local glowcolor = ThemePrefs.Get("ITG1") and "_big blue glow" or "_big red glow"
local MenuIndex = 1
local itemnames = {THEME:GetString("EditMenuRow","Song"),THEME:GetString("EditMenuRow","Steps"),THEME:GetString("EditMenuRow","StepsType"),THEME:GetString("OptionNames","Courses"),"Modifier"}
local UnlocksEnabled = PREFSMAN:GetPreference("UseUnlockSystem")
local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self) self:xy(SCREEN_CENTER_X+150,SCREEN_CENTER_Y-40):addx(SCREEN_WIDTH):decelerate(0.5):addx(-SCREEN_WIDTH) end,
    OffCommand=function(self) self:playcommand("TweenOff") end,
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end,
    TweenOffCommand=function(self) self:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH) end,

    Def.Banner{
        MenuUpAllValMessageCommand=function(self)
            local entry = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if entry and not entry:IsLocked() then
                self:LoadBannerFromUnlockEntry( entry )
            else
                self:Load( THEME:GetPathG("ITG2 Common fallback","Banner") )
            end
            self:setsize(234,78)
        end
    },

    LoadActor("_frame 3x3", {"banner",200,32,1.36})
}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(SCREEN_CENTER_X-130,SCREEN_CENTER_Y-40)
        :addx(-SCREEN_WIDTH):decelerate(0.5):addx(SCREEN_WIDTH)
    end,
    OffCommand=function(self) self:playcommand("TweenOff") end,
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end,
    TweenOffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH) end,

    LoadActor("_frame 3x3", {"info",240,60,1.67}),

    Def.BitmapText{ Font="_eurostile normal",
        OnCommand=function(self) self:xy(-123,-30):zoom(0.6):halign(0) end;
        MenuUpAllValMessageCommand=function(self)
            self:settext("???")
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if itemid then
                if not itemid:IsLocked() and itemid:GetSong() then
                    self:settext(
                        string.format( THEME:GetString("ScreenUnlock","Unlocked %s:"),
                        itemnames[itemid:GetUnlockRewardType()+1] ) 
                    )
                end
            end
        end
    },
    Def.BitmapText{ Font="_eurostile normal",
        OnCommand=function(self) self:xy(-123,-14):zoom(0.5):halign(0) end;
        MenuUpAllValMessageCommand=function(self)
            self:settext("???")
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if itemid then
                if not itemid:IsLocked() and itemid:GetSong() then
                    self:settext(itemid:GetDescription()..", "..itemnames[itemid:GetUnlockRewardType()+1])
                end
            end
            self:finishtweening():cropright(1):decelerate(0.3):cropright(0)
        end
    },

    Def.BitmapText{ Font="_eurostile normal", Text=THEME:GetString("ScreenUnlock","Trigger:"),
        OnCommand=function(self) self:xy(-123,20):zoom(0.6):halign(0) end;
    },

    Def.BitmapText{ Font="_eurostile normal",
        OnCommand=function(self) self:xy(-122,38):zoom(0.5):halign(0) end;
        MenuUpAllValMessageCommand=function(self)
            local text = "CODE"
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            self:settext("???")
            if itemid then
                if not itemid:IsLocked() and itemid:GetSong() then
                    self:settext( text )
                end
            end
            self:finishtweening():cropright(1):decelerate(0.3):cropright(0)
        end
    }
}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-140)
        :zoom(0):decelerate(0.5):zoom(1)
    end,
    OffCommand=function(self) self:playcommand("TweenOff") end,
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end,
    TweenOffCommand=function(self) self:stoptweening():accelerate(0.5):zoom(0) end,

    LoadActor("_frame 3x1", {"answer",520}),
    Def.BitmapText{
        Font=glowcolor,
        Text="#15",
        OnCommand=function(self)
            self:xy(-230,-2):zoom(1)
        end,
        MenuUpAllValMessageCommand=function(self)
            self:settext( "#"..MenuIndex )
        end
    },

    Def.BitmapText{
        Font=glowcolor,
        Text="#15",
        OnCommand=function(self)
            self:xy(40,-2):zoom(0.7):maxwidth(600)
        end,
        MenuUpAllValMessageCommand=function(self)
            self:settext("???")
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if itemid then
                if not itemid:IsLocked() then
                    self:settext( itemid:GetDescription()..", ".. itemnames[itemid:GetUnlockRewardType()+1])
                end
            end
        end
    }
}

t[#t+1] = LoadActor("ScreenWithMenuElements underlay")..{
    OnCommand=function(self) self:diffusealpha(0):linear(.5):diffusealpha(1) end,
    OffCommand=function(self) self:playcommand("TweenOff") end,
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end,
    TweenOffCommand=function(self) self:stoptweening():linear(.5):diffusealpha(0) end
}

local function MainMenuChoices()
    local t=Def.ActorFrame{}

    -- This will be our choices 
    for i=1,UNLOCKMAN:GetNumUnlocks() do
        -- add the choice actorframes
        t[#t+1] = Def.ActorFrame{
            MenuUpAllValMessageCommand = function(self)
                self:GetChild("Add"):visible( MenuIndex == i  )
                self:GetChild("Diffuse"):visible( MenuIndex == i  )
            end,
            Def.Sprite{ Texture=THEME:GetPathG("ScreenUnlock","grid") },
            LoadActor("_frame 3x1", {"square cursor diffuse",6})..{
                Name="Diffuse",
                OnCommand=function(self) self:x(-0.5):zoomy(1.3) end,
            },
            LoadActor("_frame 3x1", {"square cursor add",6})..{
                Name="Add",
                OnCommand=function(self) self:x(-0.5):zoomy(1.3):diffuseshift():effectcolor1(color("1,1,1,0")) end
            },
            Def.BitmapText{
                Font="_eurostile normal",
                Text=i,
                OnCommand=function(self)
                    local entry = UNLOCKMAN:GetUnlockEntry(i-1)
                    self:zoom(0.6)
                    :diffuse( (entry:IsLocked() or not entry:GetSong()) and color("#444444FF") or Color.White )
                end
            }
        }
    end

    return t
end

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+110)
        :zoom(0):decelerate(0.5):zoom(1)
    end,
    OffCommand=function(self) self:playcommand("TweenOff") end,
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end,
    TweenOffCommand=function(self) self:stoptweening():accelerate(0.5):zoom(0) end,

    LoadActor("_frame 3x3", {"keyboard",460,60,1.80})..{
        OnCommand=function(self)
            self:diffuse( ThemePrefs.Get("ITG1") and color("#0099FF") or color("#EE3333"))
        end
    },
    Def.ActorScroller{
        NumItemsToDraw=99;
        OnCommand=function(self)
            self:y(30):zoom(0.8):SetFastCatchup(true):SetWrap(false)
        end;
        children = MainMenuChoices();
        TransformFunction=function(self, offset, itemIndex, numItems)
            self:finishtweening():decelerate(0.2)
            :x( (-34*8)+38*itemIndex )
        end;
        MenuUpAllValMessageCommand=function(self)
            self:SetDestinationItem(MenuIndex-1)
            :PositionItems()
        end;
    };

    Def.BitmapText{
        Condition=PREFSMAN:GetPreference("UseUnlockSystem"),
        Font="Common Normal",
        OnCommand=function(self)
            local unlocked = 0
            for i=1,UNLOCKMAN:GetNumUnlocks() do
                local Code = UNLOCKMAN:GetUnlockEntry( i-1 )
                if Code and not Code:IsLocked() then
                    unlocked = unlocked + 1
                end
            end
    
            self:settext( string.format( THEME:GetString("ScreenUnlock","%d/%d unlocked"), unlocked, 15 ) )
            :y(-30):zoom(0.6):diffuseshift():effectcolor1(color("#777777"))
        end;
    };
}

-- These button options will be used instead as a shortcut to the advanced options menu.
local buttonOptions = {
    {"Go to Advanced Options", "ScreenOptionsAdvanced"},
    {"Go Back", "ScreenRecordsMenu"}
}

-- Controller Logic
local function CheckValueOffsets()
    if UnlocksEnabled then
        if MenuIndex > UNLOCKMAN:GetNumUnlocks() then MenuIndex = UNLOCKMAN:GetNumUnlocks() end
        if MenuIndex < 1 then MenuIndex = 1 end
        SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMaster","change") )
        MESSAGEMAN:Broadcast("MenuUpAllVal")
    else
        if MenuIndex > #buttonOptions then MenuIndex = 1 end
        if MenuIndex < 1 then MenuIndex = #buttonOptions end
        MESSAGEMAN:Broadcast("ChoiceUpVal")
    end
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
    ["MenuDown"] = function(event)
        if UnlocksEnabled then return end
        MenuIndex = MenuIndex + 1
        MESSAGEMAN:Broadcast("MenuRight".. ToEnumShortString(event) )
        CheckValueOffsets()
    end,
    ["MenuUp"] = function(event)
        if UnlocksEnabled then return end
        MenuIndex = MenuIndex - 1
        MESSAGEMAN:Broadcast("MenuRight".. ToEnumShortString(event) )
        CheckValueOffsets()
    end,
    ["Start"] = function(event)
        SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start") or THEME:GetPathS("_ITGCommon","start") )
        local screenToGo = UnlocksEnabled and "ScreenRecordsMenu" or buttonOptions[MenuIndex][2]
        SCREENMAN:GetTopScreen():SetNextScreenName( screenToGo ):StartTransitioningScreen("SM_GoToNextScreen")
    end,
    ["Back"] = function(event)
        SCREENMAN:GetTopScreen():SetPrevScreenName("ScreenRecordsMenu"):Cancel()
    end,
};

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

t[#t+1] = Controller

t[#t+1] = Def.ActorFrame{
    Condition=not UnlocksEnabled,
    OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
    OffCommand=function(self) self:linear(0.5):diffusealpha(0) end,
    CancelCommand=function(self) self:linear(0.5):diffusealpha(0) end,
    Def.Quad{ OnCommand=function(self) self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse( Alpha(Color.Black,0.8) ) end };
    Def.BitmapText{
        Font="_eurostile normal",
        Text=THEME:GetString("ScreenUnlock","NotEnabled"),
        OnCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y - 60):zoom(0.5) end
    };
}

if not UnlocksEnabled then
    local style = ThemePrefs.Get("ITG1") and "small blue" or "small red"
    for i,v in ipairs( buttonOptions ) do
        t[#t+1] = Def.ActorFrame{
            InitCommand=function(self)
                self:xy( SCREEN_CENTER_X , SCREEN_CENTER_Y + 10 + ( 32 * (i-1) ) )
                self:playcommand((MenuIndex == i and "Gain" or "Lose") .. "Focus")
            end,
            OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
            CancelCommand=function(self) self:linear(0.3):diffusealpha(0) end,
            ChoiceUpValMessageCommand=function(self)
                self:playcommand( (MenuIndex == i and "Gain" or "Lose") .. "Focus" )
            end,
            LoadActor( THEME:GetPathB("","_frame 3x1") , {style,320}),
            LoadActor( THEME:GetPathB("","_frame 3x1") , {"small green",312})..{
                GainFocusMessageCommand=function(self) self:visible(true) end,
                LoseFocusMessageCommand=function(self) self:visible(false) end
            },
            LoadActor( THEME:GetPathB("","_frame 3x1") , {"small glow",292})..{
                GainFocusMessageCommand=function(self) self:visible(true):diffuseshift():effectcolor1( color("1,1,1,0") ) end,
                LoseFocusMessageCommand=function(self) self:visible(false) end
            },
            Def.BitmapText{
                Font="Common Normal",
                OnCommand=function(s)
                    s:zoom(0.6)
                    :settext( THEME:GetString(Var "LoadingScreen",v[1]) )
                    -- local optrow = s:GetParent():GetParent():GetParent()
                    -- s:settext( THEME:GetString("OptionTitles",optrow:GetName()) )
                end,
                GainFocusMessageCommand=function(s) s:diffuse( color("1,1,1,1") ) end,
                LoseFocusMessageCommand=function(s) s:diffuse( color("0.5,0.5,0.5,1") ) end
            }
        }
    end
end

t[#t+1] = Def.HelpDisplay {
    File="_eurostile normal",
    OnCommand=function(self)
        self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink():maxwidth(SCREEN_WIDTH/0.8)
        :zoomy(0):linear(0.4):zoomy(0.7)
    end;
    InitCommand=function(self)
        self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
        self:SetTipsColonSeparated( THEME:GetString("ScreenUnlockBrowse","HelpText") );
    end;
    OffCommand=function(self) self:playcommand("TweenOff") end;
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end;
    TweenOffCommand=function(self) self:stoptweening():linear(0.5):zoomy(0) end;
};

t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
        self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
    end;

    Def.BitmapText{
    Font=_eurostileColorPick(),
    Text=THEME:GetString("ScreenUnlockBrowse","HeaderText"),
    InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
    OnCommand=function(self)
        self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
    end;
    OffCommand=function(self) self:playcommand("TweenOff") end;
    CancelMessageCommand=function(self) self:playcommand("TweenOff") end;
    TweenOffCommand=function(self) self:stoptweening():accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end;
    };

};
return t;