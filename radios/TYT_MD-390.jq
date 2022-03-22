# jq
.

# Retevis RT8 == TYT MD-390

# Set up the general settings the way we expect them to be
| .GeneralSettings.BacklightTime |= "10"
| .GeneralSettings.CallAlertToneDuration |= "Continue"
| .GeneralSettings.ChFreeIndicationTone |= "On"
| .GeneralSettings.DisableAllLeds |= "Off"
| .GeneralSettings.DisableAllTones |= "Off"
| .GeneralSettings.GroupCallHangTime |= "3000"
| .GeneralSettings.IntroScreen |= "Character String"
| .GeneralSettings.IntroScreenLine1 |= ""
| .GeneralSettings.IntroScreenLine2 |= ""
| .GeneralSettings.KeypadTones |= "Off"
| .GeneralSettings.LoneWorkerReminderTime |= "10"
| .GeneralSettings.LoneWorkerResponseTime |= "1"
| .GeneralSettings.MonitorType |= "Open Squelch"
| .GeneralSettings.PcProgPassword |= ""
| .GeneralSettings.PowerOnPassword |= "00000000"
| .GeneralSettings.PrivateCallHangTime |= "4000"
| .GeneralSettings.PwAndLockEnable |= "Off"
| .GeneralSettings.RadioID |= "1234"
| .GeneralSettings.RadioName |= ""
| .GeneralSettings.RadioProgPassword |= "00000000"
| .GeneralSettings.RxLowBatteryInterval |= "120"
| .GeneralSettings.SaveModeReceive |= "On"
| .GeneralSettings.SavePreamble |= "On"
| .GeneralSettings.ScanAnalogHangTime |= "1000"
| .GeneralSettings.ScanDigitalHangTime |= "1000"
| .GeneralSettings.SetKeypadLockTime |= "Manual"
| .GeneralSettings.TalkPermitTone |= "Digital"
| .GeneralSettings.TxPreambleDuration |= "300"
| .GeneralSettings.VoxSensitivity |= "3"

# Set up the menu items the way we expect them to be
| .MenuItems.Answered |= "On"
| .MenuItems.Backlight |= "On"
| .MenuItems.CallAlert |= "On"
| .MenuItems.DisplayMode |= "On"
| .MenuItems.Edit |= "On"
| .MenuItems.EditList |= "On"
| .MenuItems.Gps |= "On"
| .MenuItems.HangTime |= "10"
| .MenuItems.IntroScreen |= "On"
| .MenuItems.KeyboardLock |= "On"
| .MenuItems.LedIndicator |= "On"
| .MenuItems.ManualDial |= "On"
| .MenuItems.Missed |= "On"
| .MenuItems.OutgoingRadio |= "On"
| .MenuItems.PasswordAndLock |= "On"
| .MenuItems.Power |= "On"
| .MenuItems.ProgramKey |= "On"
| .MenuItems.ProgramRadio |= "On"
| .MenuItems.RadioCheck |= "Off"
| .MenuItems.RadioDisable |= "Off"
| .MenuItems.RadioEnable |= "Off"
| .MenuItems.RemoteMonitor |= "Off"
| .MenuItems.Scan |= "On"
| .MenuItems.Squelch |= "On"
| .MenuItems.Talkaround |= "On"
| .MenuItems.TextMessage |= "On"
| .MenuItems.ToneOrAlert |= "On"
| .MenuItems.Vox |= "On"

# Set up the configurable buttons the way we expect them to be
| .ButtonDefinitions.LongPressDuration |= "1000"
| .RadioButtons[0] |= {"Button": "Unassigned (default)"}
| .RadioButtons[1] |= {"Button": "High/Low Power"}
| .RadioButtons[2] |= {"Button": "Monitor"}
| .RadioButtons[3] |= {"Button": "All alert Tones On/Off"}