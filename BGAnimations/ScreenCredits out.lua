local t = Def.ActorFrame{
    StartTransitioningCommand=function(self) self:sleep(1) end
}
return t