return Def.ActorFrame{
    InitCommand=function(self)
        self:z( WideScale(0, 140) ):SetDrawByZPosition(true)
    end,
    LoadActor("misc"),
    LoadActor("top lights"),
    LoadActor("points")
    -- LoadActor("end")
}
