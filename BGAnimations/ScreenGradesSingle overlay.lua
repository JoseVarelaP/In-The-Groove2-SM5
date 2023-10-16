return Def.ActorFrame{
    LoadModule("HeaderText.lua")("ScreenGradesSingle"),
    LoadActor( THEME:GetPathB("_ScreenGrades","overlay"), "StepsType_Dance_Single" )
}