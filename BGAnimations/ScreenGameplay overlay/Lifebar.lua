-- Lifebar implementation (This was just so I can make the texture update with the beat.)
--------------------------------
-- Base stuff, player gets loaded into the actor from however called it.
local player=...
-- Demand that 'player' exists. Otherwise, stop anything on the script by this point.
assert(player);
local t = Def.ActorFrame{}
local Life,Streams = {},{"Hot","Normal"}
-- MeterBody
-- We'll load this into memory, to avoid some confusion and memory switching.

-- Lifebar back body
t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("LifeMeterBar","under"), OnCommand=function(s) s:rotationz(-90) end; };
-- I'll explain about the mask eventually.
t[#t+1] = Def.Quad{ Name="QuadUpdater", OnCommand=function(s) s:zoomto(28,272):y(272/2):MaskSource():vertalign("bottom") end;
    UpdateAllCommand=function(s)
        local calculation = math.sin( s:GetParent():GetChild("LifeAux"):getaux() )/10
        s:stoptweening():spring(1/2):cropbottom( Life[player]+(calculation/10) ):sleep(1/30):queuecommand("UpdateAll")
    end;
};
for v in ivalues(Streams) do
    t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("StreamDisplay",v), OnCommand=function(s) s:rotationz(-90):MaskDest() end, Name="Life"..v };
end
-- Lifebar Frame
t[#t+1] = Def.Sprite{ Texture=THEME:GetPathG("LifeMeterBar","over"), OnCommand=function(s) s:rotationz(-90) end };

-- Actor specifically made for aux values.
t[#t+1] = Def.Actor{
	Name="LifeAux",
	OnCommand=function(s) s:aux(50):queuecommand("tweentest") end;
	tweentestCommand=function(s)
		s:aux( s:getaux() > 50 and 50 or (s:getaux() > 0 and s:getaux()-0.2 or s:getaux()) ):sleep(1/60):queuecommand("tweentest")
	end;
};

t.OnCommand=function(s)
    -- Set both StreamDisplays to begin scrolling.
    for v in ivalues(Streams) do s:GetChild("Life"..v):zoomx(1.22):texcoordvelocity( -1,0 ) end
    -- Here comes the fun part.
    s:GetChild("QuadUpdater"):playcommand("UpdateAll")
    s:playcommand("BPMCheck")
end;
-- This BPM check will analyse the current BPM of the song.
-- As the song gets faster, it will update both StreamDisplays accordingly to make them sync.
t.BPMCheckCommand=function(s)
    -- Current song BPM
    local BPM = (GAMESTATE:GetSongBPS()*60)
    -- We need SongPosition to check for stops.
    local NF = (not GAMESTATE:GetSongPosition():GetFreeze() and not GAMESTATE:GetSongPosition():GetDelay())
    -- Update both StreamDisplay with the new BPM, while checking that are no stops currently playing.
    for v in ivalues(Streams) do s:GetChild("Life"..v):texcoordvelocity( NF and -BPM/100 or 0,0 ) end
    s:sleep(1/60):queuecommand("BPMCheck")
end;
--[[
    Here comes the mask's turn.
    It's just is to hide the lifebar that has not been earned yet.
    This is done to make it able to tween the "lifebar" without having to do some trickery if I were to just control
    the StreamDisplays. Now the mask does the trick.
]]
t.LifeChangedMessageCommand=function(s, param)
    if (param.Player == player) then
        Life[player] = param.LifeMeter:GetLife()
        s:GetChild("LifeAux"):aux( s:GetChild("LifeAux"):getaux()+2 )
    end
end;
-- This will change the transparency of both StreamDisplays accordingly based on the player's HealthState.
-- The MessageCommand updates based upon a threshold (Available in Docs/Lua.xml), so there's not exactly
-- a need to check for specific life values.
t.HealthStateChangedMessageCommand=function(s,param)
    if param.PlayerNumber == player then
        local hl = param.HealthState
        if hl == "HealthState_Danger" then
            s:GetChild("LifeNormal"):glowshift():effectcolor1(Color.Red):effectcolor2( color("1,1,1,0") )
        end
        if hl == "HealthState_Alive" then s:GetChild("LifeNormal"):stopeffect() end
        s:GetChild("LifeNormal"):linear(0.5):diffusealpha( (hl == "HealthState_Alive" or hl == "HealthState_Danger") and 1 or 0 )
        s:GetChild("LifeHot"):linear(0.5):diffusealpha( hl == "HealthState_Hot" and 1 or 0 )
    end
end;
return t;