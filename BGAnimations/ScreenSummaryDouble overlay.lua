return Def.ActorFrame{
    LoadModule("HeaderText.lua")("ScreenSummaryDouble"),
    LoadActor( THEME:GetPathB("_ScreenSummary","overlay"), "StepsType_Dance_Double" )
}