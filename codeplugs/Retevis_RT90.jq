# jq
.

# Retevis RT90 == Tytera MD-9600
# Codeplugs for the Tytera MD-2017 also work on the MD-9600 and vice versa

# Set up the general settings the way we expect them to be
| .GeneralSettings.BacklightTime |= "Always"
| .GeneralSettings.CHVoiceAnnouncement |= "Off"
| .GeneralSettings.CallAlertToneDuration |= "Continue"
| .GeneralSettings.ChFreeIndicationTone |= "On"
| .GeneralSettings.ChannelsHangTime |= "3000"
| .GeneralSettings.DisableAllLeds |= "Off"
| .GeneralSettings.DisableAllTones |= "Off"
| .GeneralSettings.EditRadioID |= "On"
| .GeneralSettings.EnableContactsCSV |= "On"
| .GeneralSettings.FreqChannelMode |= "Channel"
| .GeneralSettings.GroupCallHangTime |= "3000"
| .GeneralSettings.GroupCallMatch |= "Off"
| .GeneralSettings.IntroScreen |= "Character String"
| .GeneralSettings.IntroScreenLine1 |= ""
| .GeneralSettings.IntroScreenLine2 |= ""
| .GeneralSettings.LoneWorkerReminderTime |= "10"
| .GeneralSettings.LoneWorkerResponseTime |= "1"
| .GeneralSettings.MenuControl |= "On"
| .GeneralSettings.MicLevel |= "3"
| .GeneralSettings.ModeSelectA |= "Memory"
| .GeneralSettings.ModeSelectB |= "Memory"
| .GeneralSettings.MonitorType |= "Open Squelch"
| .GeneralSettings.PcProgPassword |= ""
| .GeneralSettings.PowerOnPassword |= "00000000"
| .GeneralSettings.PrivateCallHangTime |= "4000"
| .GeneralSettings.PrivateCallMatch |= "Off"
| .GeneralSettings.PublicZone |= "On"
| .GeneralSettings.PwAndLockEnable |= "Off"
| .GeneralSettings.RadioID |= "1234"
| .GeneralSettings.RadioID1 |= "1"
| .GeneralSettings.RadioID2 |= "2"
| .GeneralSettings.RadioID3 |= "3"
| .GeneralSettings.RadioName |= ""
| .GeneralSettings.RadioProgPassword |= ""
| .GeneralSettings.RxLowBatteryInterval |= "120"
| .GeneralSettings.SaveModeReceive |= "On"
| .GeneralSettings.SavePreamble |= "On"
| .GeneralSettings.ScanAnalogHangTime |= "1000"
| .GeneralSettings.ScanDigitalHangTime |= "1000"
| .GeneralSettings.SetKeypadLockTime |= "Manual"
| .GeneralSettings.TalkPermitTone |= "Digital"
| .GeneralSettings.TimeZone |= "UTC+0:00"
| .GeneralSettings.TwoChannel |= "On"
| .GeneralSettings.TxMode |= "Designated CH + Hand CH"
| .GeneralSettings.TxPreambleDuration |= "600"
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
| .RadioButtons[1] |= {"Button": "Unassigned (default)"}
| .RadioButtons[2] |= {"Button": "Unassigned (default)"}
| .RadioButtons[3] |= {"Button": "Unassigned (default)"}
| .RadioButtons[4] |= {"Button": "Unassigned (default)"}
| .RadioButtons[5] |= {"Button": "Unassigned (default)"}
| .RadioButtons[6] |= {"Button": "Unassigned (default)"}
| .RadioButtons[7] |= {"Button": "Unassigned (default)"}
| .RadioButtons[8] |= {"Button": "Unassigned (default)"}
| .RadioButtons[9] |= {"Button": "High/Low Power"}
| .RadioButtons[10] |= {"Button": "Monitor"}
| .RadioButtons[11] |= {"Button": "All alert Tones On/Off"}
