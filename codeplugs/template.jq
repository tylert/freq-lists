# jq
.

# # Set the DMR ID and Callsign for this radio
| .GeneralSettings.RadioID |= "{{ (XXX).RadioID }}"
| .GeneralSettings.RadioName |= "{{ (XXX).RadioName }}"

# Show DMR ID and Callsign when the radio boots up
| .GeneralSettings.IntroScreen |= "Character String"
| .GeneralSettings.IntroScreenLine1 |= "{{ (XXX).RadioID }}"
| .GeneralSettings.IntroScreenLine2 |= "{{ (XXX).RadioName }}"

# Allow front-panel programming
| .MenuItems.ProgramRadio |= "On"
