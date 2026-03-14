#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

BlackFlashEnabled := true
WorldSlashEnabled := true

Menu, Tray, Tip, Yuji Macro
Menu, Tray, NoStandard
Menu, Tray, Add, Show GUI, ShowGUI
Menu, Tray, Add, Toggle All, ToggleAll
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitScript
Menu, Tray, Default, Show GUI

Gui, +AlwaysOnTop +ToolWindow
Gui, Color, 1a1a2e
Gui, Font, s14 Bold cFFFFFF, Segoe UI
Gui, Add, Text, x20 y18 w260 Center, YUJI MACRO

Gui, Font, s8 cAAAAAA, Segoe UI
Gui, Add, Text, x20 y45 w260 Center, for th big jjs

Gui, Add, Text, x10 y65 w280 h2 BackgroundColor333355,

Gui, Font, s10 Bold cFFFFFF, Segoe UI
Gui, Add, Text, x20 y80 w160, Black Flash
Gui, Font, s8 cAAAAAA, Segoe UI
Gui, Add, Text, x20 y100 w160, 3 + 3
Gui, Font, s9 cFFFFFF, Segoe UI
Gui, Add, Checkbox, x210 y84 w60 h24 vBlackFlashCB gToggleBlackFlash Checked, ON

Gui, Add, Text, x10 y130 w280 h1 Background333355,

Gui, Font, s10 Bold cFFFFFF, Segoe UI
Gui, Add, Text, x20 y145 w160, World Slash
Gui, Font, s8 cAAAAAA, Segoe UI
Gui, Add, Text, x20 y165 w160, 1, 3, 2, R
Gui, Font, s9 cFFFFFF, Segoe UI
Gui, Add, Checkbox, x210 y149 w60 h24 vWorldSlashCB gToggleWorldSlash Checked, ON

Gui, Add, Text, x10 y195 w280 h2 Background333355,

Gui, Font, s9 Bold c00FF99, Segoe UI
Gui, Add, Text, x10 y205 w280 Center vStatusLabel, ALL MACROS ACTIVE

Gui, Font, s9 Bold cFFFFFF, Segoe UI
Gui, Add, Button, x20 y235 w120 h30 gToggleAll, Toggle All
Gui, Add, Button, x160 y235 w120 h30 gExitScript, Exit

Gui, Font, s7 c555577, Segoe UI
Gui, Add, Text, x10 y275 w280 Center, F10 = Toggle All   -   F12 = Exit

Gui, Show, w300 h300, Yuji Macro
return

GuiClose:
    Gui, Hide
return

ShowGUI:
    Gui, Show
return

ToggleBlackFlash:
    Gui, Submit, NoHide
    BlackFlashEnabled := BlackFlashCB
    UpdateStatus()
return

ToggleWorldSlash:
    Gui, Submit, NoHide
    WorldSlashEnabled := WorldSlashCB
    UpdateStatus()
return

ToggleAll:
F10::
    if (BlackFlashEnabled || WorldSlashEnabled) {
        BlackFlashEnabled := false
        WorldSlashEnabled := false
        GuiControl,, BlackFlashCB, 0
        GuiControl,, WorldSlashCB, 0
    } else {
        BlackFlashEnabled := true
        WorldSlashEnabled := true
        GuiControl,, BlackFlashCB, 1
        GuiControl,, WorldSlashCB, 1
    }
    UpdateStatus()
return

UpdateStatus() {
    global BlackFlashEnabled, WorldSlashEnabled
    if (BlackFlashEnabled && WorldSlashEnabled) {
        GuiControl,, StatusLabel, ● ALL MACROS ACTIVE
        GuiControl, +cGreen, StatusLabel
        Menu, Tray, Tip, Yuji Macro — All Active
    } else if (!BlackFlashEnabled && !WorldSlashEnabled) {
        GuiControl,, StatusLabel, ○ ALL MACROS PAUSED
        GuiControl, +cRed, StatusLabel
        Menu, Tray, Tip, Yuji Macro — All Paused
    } else {
        GuiControl,, StatusLabel, ◑ SOME MACROS ACTIVE
        GuiControl, +cYellow, StatusLabel
        Menu, Tray, Tip, Yuji Macro — Partial
    }
    ToolTip, % (BlackFlashEnabled ? "[BF ON]" : "[BF OFF]") . " " . (WorldSlashEnabled ? "[WS ON]" : "[WS OFF]")
    SetTimer, ClearToolTip, -2000
}

RButton::
    if (BlackFlashEnabled) {
        Send, 3
        Sleep, 350
        Send, 3
    } else {
        Click, right
    }
return

e::
    if (WorldSlashEnabled) {
        Send, 1
        Sleep, 50
        Send, 3
        Sleep, 500
        Send, 2
        Sleep, 500
        Send, r
    } else {
        Send, e
    }
return

ExitScript:
F12::
    TrayTip, Yuji Macro, Script closed., 1
    Sleep, 800
    ExitApp
return

ClearToolTip:
    ToolTip
return
