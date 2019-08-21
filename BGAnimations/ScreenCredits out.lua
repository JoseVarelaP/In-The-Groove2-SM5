local t = Def.ActorFrame{
    StartTransitioningCommand=function(s) s:sleep(1) end;
}
return t;