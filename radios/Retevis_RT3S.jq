# jq
.

# Retevis RT3S == TYT MD-UV380

#   ____                           _   ____       _   _   _
#  / ___| ___ _ __   ___ _ __ __ _| | / ___|  ___| |_| |_(_)_ __   __ _ ___
# | |  _ / _ \ '_ \ / _ \ '__/ _` | | \___ \ / _ \ __| __| | '_ \ / _` / __|
# | |_| |  __/ | | |  __/ | | (_| | |  ___) |  __/ |_| |_| | | | | (_| \__ \
#  \____|\___|_| |_|\___|_|  \__,_|_| |____/ \___|\__|\__|_|_| |_|\__, |___/
#                                                                 |___/
# =============================================================================
# Save
| .GeneralSettings.SavePreamble |= "On"                 # "Off", "On"
| .GeneralSettings.SaveModeReceive |= "On"              # "Off", "On"
# Alert Tone
| .GeneralSettings.DisableAllTones |= "Off"             # "Off", "On"
| .GeneralSettings.KeypadTones |= "Off"                 # "Off", "On"
| .GeneralSettings.ChFreeIndicationTone |= "On"         # "Off", "On"
| .GeneralSettings.TalkPermitTone |= "Digital"          # "None", "Digital", "Analog", "Digital and Analog"
| .GeneralSettings.CallAlertToneDuration |= "Continue"  # in seconds;  "Continue", "5" to "1200" incr by 5
# Scan
| .GeneralSettings.ScanDigitalHangTime |= "1000"        # in milliseconds;  "500" to "10000" incr by 500
| .GeneralSettings.ScanAnalogHangTime |= "1000"         # in milliseconds;  "500" to "10000" incr by 500
# Lone Worker
| .GeneralSettings.LoneWorkerResponseTime |= "1"        # in minutes;  "1" to "255" incr by 1
| .GeneralSettings.LoneWorkerReminderTime |= "10"       # in seconds;  ??? to ??? incr by 1
# Power On Password
| .GeneralSettings.PwAndLockEnable |= "Off"             # "Off", "On"
| .GeneralSettings.PowerOnPassword |= "00000000"        # any string of exactly 8 digits
# Voice Announcement
| .GeneralSettings.CHVoiceAnnouncement |= "Off"         # "Off", "On"
# -----------------------------------------------------------------------------
| .GeneralSettings.RadioName |= ""                      # any string unknown max length
| .GeneralSettings.RadioID |= "1234"                    # any string of up to 8 digits less than "16777216"
| .GeneralSettings.MonitorType |= "Open Squelch"        # "Open Squelch", "Silent"
| .GeneralSettings.VoxSensitivity |= "3"                # "1" to "10" incr by 1
| .GeneralSettings.TxPreambleDuration |= "600"          # in milliseconds;  "0" to "8640" incr by 60
| .GeneralSettings.RxLowBatteryInterval |= "120"        # in seconds;  ??? to ??? incr by 5
| .GeneralSettings.ChannelsHangTime |= "3000"           # in milliseconds;  "0" to "7000" incr by 500
| .GeneralSettings.PcProgPassword |= ""                 # any string of exactly 8 digits
| .GeneralSettings.RadioProgPassword |= ""              # any string of exactly 8 digits
| .GeneralSettings.BacklightTime |= "10"                # in seconds;  "Always", "5", "10", "15"
| .GeneralSettings.SetKeypadLockTime |= "Manual"        # in seconds;  "5", "10", "15", "Manual"
# Talkaround
| .GeneralSettings.GroupCallHangTime |= "3000"          # in milliseconds;  "0" to "7000" incr by 500
| .GeneralSettings.PrivateCallHangTime |= "4000"        # in milliseconds;  "0" to "7000" incr by 500
# -----------------------------------------------------------------------------
| .GeneralSettings.RadioID1 |= "1"                      # any string of up to 8 digits less than "16777216"
| .GeneralSettings.RadioID2 |= "2"                      # any string of up to 8 digits less than "16777216"
| .GeneralSettings.RadioID3 |= "3"                      # any string of up to 8 digits less than "16777216"
| .GeneralSettings.MicLevel |= "3"                      # "1" to "6", incr by 1
| .GeneralSettings.TxMode |= "Designated CH + Hand CH"  # "Last Call CH", "Last Call CH + Hand CH", "Designated CH", "Designated CH + Hand CH"
| .GeneralSettings.FreqChannelMode |= "Channel"         # "Channel", "Frequency"
| .GeneralSettings.ModeSelectA |= "Memory"              # unknown
| .GeneralSettings.ModeSelectB |= "Memory"              # unknown
| .GeneralSettings.TimeZone |= "UTC+0:00"               # "UTC-12:00" to "UTC+12:00"
| .GeneralSettings.DisableAllLeds |= "Off"              # "Off", "On"
| .GeneralSettings.GroupCallMatch |= "Off"              # "Off", "On"
| .GeneralSettings.PrivateCallMatch |= "Off"            # "Off", "On"
| .GeneralSettings.EditRadioID |= "On"                  # "Off", "On"
| .GeneralSettings.PublicZone |= "On"                   # "Off", "On"
| .GeneralSettings.EnableContactsCSV |= "On"            # "Off", "On"
# Intro Screen
| .GeneralSettings.IntroScreen |= "Character String"    # "Character String", "Picture"
| .GeneralSettings.IntroScreenLine1 |= ""               # any string unknown max length;  ABSOLUTELY NO SPACES
| .GeneralSettings.IntroScreenLine2 |= ""               # any string unknown max length;  ABSOLUTELY NO SPACES
# =============================================================================

#  __  __                    ___ _
# |  \/  | ___ _ __  _   _  |_ _| |_ ___ _ __ ___  ___
# | |\/| |/ _ \ '_ \| | | |  | || __/ _ \ '_ ` _ \/ __|
# | |  | |  __/ | | | |_| |  | || ||  __/ | | | | \__ \
# |_|  |_|\___|_| |_|\__,_| |___|\__\___|_| |_| |_|___/
# =============================================================================
| .MenuItems.HangTime |= "10"         # "Hang", "1" to "30" incr by 1
| .MenuItems.TextMessage |= "On"      # "Off", "On"
# Contacts
| .MenuItems.CallAlert |= "On"        # "Off", "On"
| .MenuItems.ManualDial |= "On"       # "Off", "On"
| .MenuItems.RemoteMonitor |= "Off"   # "Off", "On"
| .MenuItems.RadioEnable |= "Off"     # "Off", "On"
| .MenuItems.Edit |= "On"             # "Off", "On"
| .MenuItems.RadioCheck |= "Off"      # "Off", "On"
| .MenuItems.ProgramKey |= "On"       # "Off", "On"
| .MenuItems.RadioDisable |= "Off"    # "Off", "On"
# Call Log
| .MenuItems.Missed |= "On"           # "Off", "On"
| .MenuItems.OutgoingRadio |= "On"    # "Off", "On"
| .MenuItems.Answered |= "On"         # "Off", "On"
# Utilities
| .MenuItems.Talkaround |= "On"       # "Off", "On"
| .MenuItems.Power |= "On"            # "Off", "On"
| .MenuItems.IntroScreen |= "On"      # "Off", "On"
| .MenuItems.LedIndicator |= "On"     # "Off", "On"
| .MenuItems.PasswordAndLock |= "On"  # "Off", "On"
| .MenuItems.DisplayMode |= "On"      # "Off", "On"
| .MenuItems.Gps |= "On"              # "Off", "On"
| .MenuItems.ToneOrAlert |= "On"      # "Off", "On"
| .MenuItems.Backlight |= "On"        # "Off", "On"
| .MenuItems.KeyboardLock |= "On"     # "Off", "On"
| .MenuItems.Squelch |= "On"          # "Off", "On"
| .MenuItems.Vox |= "On"              # "Off", "On"
| .MenuItems.ProgramRadio |= "On"     # "Off", "On"
# Scan
| .MenuItems.Scan |= "On"             # "Off", "On"
| .MenuItems.EditList |= "On"         # "Off", "On"
# =============================================================================

#  ____        _   _
# | __ ) _   _| |_| |_ ___  _ __
# |  _ \| | | | __| __/ _ \| '_ \
# | |_) | |_| | |_| || (_) | | | |
# |____/ \__,_|\__|\__\___/|_| |_|
#  ____        __ _       _ _   _
# |  _ \  ___ / _(_)_ __ (_) |_(_) ___  _ __  ___
# | | | |/ _ \ |_| | '_ \| | __| |/ _ \| '_ \/ __|
# | |_| |  __/  _| | | | | | |_| | (_) | | | \__ \
# |____/ \___|_| |_|_| |_|_|\__|_|\___/|_| |_|___/
# =============================================================================
| .ButtonDefinitions.LongPressDuration |= "1000"    # in milliseconds
# Radio Buttons
| .RadioButtons[0] |= {"Button": "Zone +"}          # Side Button 1 Short Press
| .RadioButtons[1] |= {"Button": "High/Low Power"}  # Side Button 1 Long Press
| .RadioButtons[2] |= {"Button": "Zone -"}          # Side Button 2 Short Press
| .RadioButtons[3] |= {"Button": "Monitor"}         # Side Button 2 Long Press
# =============================================================================
