local t =Def.ActorFrame{}

if not IsITG2PS2Mode() then
    t[#t+1] = LoadActor("back");
    t[#t+1] = LoadActor("fore");
else
    t[#t+1] = LoadActor("ps2-back");
    --t[#t+1] = LoadActor("ps2-fore");
end

return t;