; =============================================
;  Yuji Macro GUI - AHK v1
;  Black Flash  : RightClick → 3 (350ms) 3
;  World Slash  : E → 1 (50ms) 3 (500ms) 2 (500ms) R
;
;  F10 → Toggle ALL macros ON/OFF
;  F12 → Exit script
; =============================================

#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- Toggle States ---
BlackFlashEnabled := true
WorldSlashEnabled := true

; --- Tray Icon Setup ---
Menu, Tray, Tip, Yuji Macro
Menu, Tray, NoStandard
Menu, Tray, Add, Show GUI, ShowGUI
Menu, Tray, Add, Toggle All, ToggleAll
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitScript
Menu, Tray, Default, Show GUI

; =============================================
;  BUILD GUI
; =============================================
Gui, +AlwaysOnTop +ToolWindow
Gui, Color, 1a1a2e
Gui, Font, s14 Bold cFFFFFF, Segoe UI
Gui, Add, Text, x20 y18 w260 Center, YUJI MACRO

Gui, Font, s8 cAAAAAA, Segoe UI
Gui, Add, Text, x20 y45 w260 Center, for th big jjs

; --- Divider ---
Gui, Add, Text, x10 y65 w280 h2 BackgroundColor333355,

; --- Black Flash Toggle ---
Gui, Font, s10 Bold cFFFFFF, Segoe UI
Gui, Add, Text, x20 y80 w160, Black Flash
Gui, Font, s8 cAAAAAA, Segoe UI
Gui, Add, Text, x20 y100 w160, 3 + 3
Gui, Font, s9 cFFFFFF, Segoe UI
Gui, Add, Checkbox, x210 y84 w60 h24 vBlackFlashCB gToggleBlackFlash Checked, ON

; --- Divider ---
Gui, Add, Text, x10 y130 w280 h1 Background333355,

; --- World Cutting Slash Toggle ---
Gui, Font, s10 Bold cFFFFFF, Segoe UI
Gui, Add, Text, x20 y145 w160, World Slash
Gui, Font, s8 cAAAAAA, Segoe UI
Gui, Add, Text, x20 y165 w160, 1, 3, 2, R
Gui, Font, s9 cFFFFFF, Segoe UI
Gui, Add, Checkbox, x210 y149 w60 h24 vWorldSlashCB gToggleWorldSlash Checked, ON

; --- Divider ---
Gui, Add, Text, x10 y195 w280 h2 Background333355,

; --- Status Bar ---
Gui, Font, s9 Bold c00FF99, Segoe UI
Gui, Add, Text, x10 y205 w280 Center vStatusLabel, ALL MACROS ACTIVE

; --- Buttons ---
Gui, Font, s9 Bold cFFFFFF, Segoe UI
Gui, Add, Button, x20 y235 w120 h30 gToggleAll, Toggle All
Gui, Add, Button, x160 y235 w120 h30 gExitScript, Exit

; --- Footer ---
Gui, Font, s7 c555577, Segoe UI
Gui, Add, Text, x10 y275 w280 Center, F10 = Toggle All   -   F12 = Exit

Gui, Show, w300 h300, Yuji Macro
return

; =============================================
;  GUI CLOSE → hide to tray instead of exit
; =============================================
GuiClose:
    Gui, Hide
return

; =============================================
;  SHOW GUI from tray
; =============================================
ShowGUI:
    Gui, Show
return

; =============================================
;  BLACK FLASH TOGGLE (checkbox)
; =============================================
ToggleBlackFlash:
    Gui, Submit, NoHide
    BlackFlashEnabled := BlackFlashCB
    UpdateStatus()
return

; =============================================
;  WORLD SLASH TOGGLE (checkbox)
; =============================================
ToggleWorldSlash:
    Gui, Submit, NoHide
    WorldSlashEnabled := WorldSlashCB
    UpdateStatus()
return

; =============================================
;  TOGGLE ALL (button + F10)
; =============================================
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

; =============================================
;  UPDATE STATUS LABEL + TRAY TOOLTIP
; =============================================
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

; =============================================
;  RIGHT CLICK → BLACK FLASH
; =============================================
RButton::
    if (BlackFlashEnabled) {
        Send, 3
        Sleep, 350
        Send, 3
    } else {
        Click, right
    }
return

; =============================================
;  E → WORLD CUTTING SLASH
; =============================================
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

; =============================================
;  EXIT
; =============================================
ExitScript:
F12::
    TrayTip, Yuji Macro, Script closed., 1
    Sleep, 800
    ExitApp
return

; --- Clear tooltip ---
ClearToolTip:
    ToolTip
return
