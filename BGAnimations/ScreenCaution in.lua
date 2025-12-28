if NETMAN and NETMAN:IsConnectionEstablished() then
    return Def.ActorFrame{}
end

return LoadActor(THEME:GetPathB("_fade in","normal"))