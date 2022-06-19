return Def.ActorFrame{
    StartTransitioningCommand=function(self)
        self:sleep(1)
        MESSAGEMAN:Broadcast("Cancel")
    end
}