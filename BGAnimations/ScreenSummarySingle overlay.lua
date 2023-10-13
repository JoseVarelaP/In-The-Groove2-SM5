return Def.ActorFrame{
    LoadModule("HeaderText.lua")("ScreenSummarySingle"),
    LoadActor( THEME:GetPathB("_ScreenSummary","overlay"), "StepsType_Dance_Single" )
}