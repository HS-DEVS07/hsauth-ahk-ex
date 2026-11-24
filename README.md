# HS DEVS AUTH — AutoHotkey (AHK) SDK

Official AHK library for Windows game script licensing.

## Usage

```ahk
#Include %A_ScriptDir%\HSAuth.ahk

auth := new HSAuth("AppName", "OwnerID", "Secret", "1.0")
if (auth.License("YOUR_KEY")) {
    MsgBox, 64, Granted, % "Valid until " . auth.UserData.expires_at
}
```
