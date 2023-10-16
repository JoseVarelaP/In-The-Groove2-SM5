return Def.ActorFrame{
    LoadModule("HeaderText.lua")("ScreenGradesDouble"),
    LoadActor( THEME:GetPathB("_ScreenGrades","overlay"), "StepsType_Dance_Double" )
}