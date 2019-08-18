return Def.ActorFrame{
    StartTransitioningCommand=function(s)
        s:sleep(1)
        MESSAGEMAN:Broadcast("Cancel")
    end;
}