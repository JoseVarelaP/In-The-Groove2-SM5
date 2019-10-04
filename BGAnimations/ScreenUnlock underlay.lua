-- Unlock Display
local glowcolor = ThemePrefs.Get("ITG1") and "_big blue glow" or "_big red glow"
local MenuIndex = 1;
local itemnames = {THEME:GetString("EditMenuRow","Song"),THEME:GetString("EditMenuRow","Steps"),THEME:GetString("EditMenuRow","StepsType"),THEME:GetString("OptionNames","Courses"),"Modifier"}
local UnlocksEnabled = PREFSMAN:GetPreference("UseUnlockSystem")
local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(s) s:xy(SCREEN_CENTER_X+150,SCREEN_CENTER_Y-40):addx(SCREEN_WIDTH):decelerate(0.5):addx(-SCREEN_WIDTH) end;
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH) end;

    Def.Banner{
        MenuUpAllValMessageCommand=function(s)
            if not UNLOCKMAN:GetUnlockEntry(MenuIndex-1):IsLocked() then
                s:LoadBannerFromUnlockEntry( UNLOCKMAN:GetUnlockEntry(MenuIndex-1) )
                :setsize(234,78)
            else
                s:Load( THEME:GetPathG("ITG2 Common fallback","Banner") )
                :setsize(234,78)
            end
        end;
    };

    LoadActor("_frame 3x3", {"banner",200,32,1.36});
}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(s)
        s:xy(SCREEN_CENTER_X-130,SCREEN_CENTER_Y-40)
        :addx(-SCREEN_WIDTH):decelerate(0.5):addx(SCREEN_WIDTH)
    end;
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH) end;

    LoadActor("_frame 3x3", {"info",240,60,1.67});

    Def.BitmapText{ Font="_eurostile normal",
        OnCommand=function(s) s:xy(-123,-30):zoom(0.6):halign(0) end;
        MenuUpAllValMessageCommand=function(s)
            s:settext("???")
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if not itemid:IsLocked() and itemid:GetSong() then
                s:settext(
                    string.format( THEME:GetString("ScreenUnlock","Unlocked %s:"),
                    itemnames[itemid:GetUnlockRewardType()+1] ) 
                )
            end
        end;
    };
    Def.BitmapText{ Font="_eurostile normal",
        OnCommand=function(s) s:xy(-123,-14):zoom(0.5):halign(0) end;
        MenuUpAllValMessageCommand=function(s)
            s:settext("???")
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if not itemid:IsLocked() and itemid:GetSong() then
                s:settext(itemid:GetDescription()..", "..itemnames[itemid:GetUnlockRewardType()+1])
            end
            s:finishtweening():cropright(1):decelerate(0.3):cropright(0)
        end;
    };

    Def.BitmapText{ Font="_eurostile normal", Text=THEME:GetString("ScreenUnlock","Trigger:"),
        OnCommand=function(s) s:xy(-123,20):zoom(0.6):halign(0) end;
    };

    Def.BitmapText{ Font="_eurostile normal",
        OnCommand=function(s) s:xy(-122,38):zoom(0.5):halign(0) end;
        MenuUpAllValMessageCommand=function(s)
            local text = "CODE"
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            s:settext("???")
            if not itemid:IsLocked() and itemid:GetSong() then
                s:settext( text )
            end
            s:finishtweening():cropright(1):decelerate(0.3):cropright(0)
        end;
    };
}

t[#t+1] = Def.ActorFrame{
    OnCommand=function(s)
        s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-140)
        :zoom(0):decelerate(0.5):zoom(1)
    end;
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():accelerate(0.5):zoom(0) end;

    LoadActor("_frame 3x1", {"answer",520});
    Def.BitmapText{
        Font=glowcolor,
        Text="#15",
        OnCommand=function(s)
            s:xy(-230,-2):zoom(1)
        end;
        MenuUpAllValMessageCommand=function(s)
            s:settext( "#"..MenuIndex )
        end;
    };

    Def.BitmapText{
        Font=glowcolor,
        Text="#15",
        OnCommand=function(s)
            s:xy(40,-2):zoom(0.7):maxwidth(600)
        end;
        MenuUpAllValMessageCommand=function(s)
            s:settext("???")
            local itemid = UNLOCKMAN:GetUnlockEntry(MenuIndex-1)
            if not itemid:IsLocked() then
                s:settext( itemid:GetDescription()..", ".. itemnames[itemid:GetUnlockRewardType()+1])
            end
        end;
    };
}

t[#t+1] = LoadActor("ScreenWithMenuElements underlay")..{
    OnCommand=function(self) self:diffusealpha(0):linear(.5):diffusealpha(1) end;
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():linear(.5):diffusealpha(0) end;
}

local function MainMenuChoices()
    local t=Def.ActorFrame{};

    -- This will be our choices 
    for i=1,UNLOCKMAN:GetNumUnlocks() do
        -- add the choice actorframes
        t[#t+1] = Def.ActorFrame{
            Def.Sprite{
                Texture=THEME:GetPathG("ScreenUnlock","grid")
            };
            LoadActor("_frame 3x1", {"square cursor diffuse",6})..{
                OnCommand=function(s) s:x(-0.5):zoomy(1.3) end;
                MenuUpAllValMessageCommand=function(s)
                    s:visible( MenuIndex == i )
                end;
            };
            LoadActor("_frame 3x1", {"square cursor add",6})..{
                OnCommand=function(s) s:x(-0.5):zoomy(1.3):diffuseshift():effectcolor1(color("1,1,1,0")) end;
                MenuUpAllValMessageCommand=function(s)
                    s:visible( MenuIndex == i )
                end;
            };
            Def.BitmapText{
                Font="_eurostile normal", Text=i,
                OnCommand=function(s)
                    s:zoom(0.6)
                    s:diffuse( (UNLOCKMAN:GetUnlockEntry(i-1):IsLocked() or not UNLOCKMAN:GetUnlockEntry(i-1):GetSong()) and color("#444444FF") or Color.White )
                end;
            };
        }
    end

    return t;
end

t[#t+1] = Def.ActorFrame{
    OnCommand=function(s)
        s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+110)
        :zoom(0):decelerate(0.5):zoom(1)
    end;
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():accelerate(0.5):zoom(0) end;

    LoadActor("_frame 3x3", {"keyboard",460,60,1.80})..{
        OnCommand=function(s)
            s:diffuse( ThemePrefs.Get("ITG1") and color("#0099FF") or color("#EE3333"))
        end;
    };
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
        OnCommand=function(s)
            local unlocked = 0
            for i=1,UNLOCKMAN:GetNumUnlocks() do
                local Code = UNLOCKMAN:GetUnlockEntry( i-1 )
                if Code and not Code:IsLocked() then
                    unlocked = unlocked + 1
                end
            end
    
            s:settext( string.format( THEME:GetString("ScreenUnlock","%d/%d unlocked"), unlocked, 15 ) )
            :y(-30):zoom(0.6):diffuseshift():effectcolor1(color("#777777"))
        end;
    };
}

-- Controller Logic
local function CheckValueOffsets()
    if UnlocksEnabled then
        if MenuIndex > UNLOCKMAN:GetNumUnlocks() then MenuIndex = UNLOCKMAN:GetNumUnlocks() end
        if MenuIndex < 1 then MenuIndex = 1 end
        SOUND:PlayOnce( THEME:GetPathS("ScreenSelectMaster","change") )
        MESSAGEMAN:Broadcast("MenuUpAllVal")
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
    ["Start"] = function(event)
        SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start") or THEME:GetPathS("_ITGCommon","start") )
        SCREENMAN:GetTopScreen():SetNextScreenName( "ScreenRecordsMenu" ):StartTransitioningScreen("SM_GoToNextScreen")
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
    OnCommand=function(s) s:diffusealpha(0):linear(0.5):diffusealpha(1) end,
    OffCommand=function(s) s:linear(0.5):diffusealpha(0) end,
    Def.Quad{ OnCommand=function(s) s:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse( Alpha(Color.Black,0.8) ) end };
    Def.BitmapText{
        Font="_eurostile normal",
        Text="Unlocks are not enabled, thus this screen won't work properly.\nYou can enabled this on 'Advanced Options'.",
        OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y):zoom(0.5) end
    };
}

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
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():linear(0.5):zoomy(0) end;
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
    OffCommand=function(s) s:playcommand("TweenOff") end;
    CancelMessageCommand=function(s) s:playcommand("TweenOff") end;
    TweenOffCommand=function(s) s:stoptweening():accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end;
    };

};
return t;