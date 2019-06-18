# jq
.

# Set the DMR ID and Callsign values for each radio uniquely
| .GeneralSettings.RadioID |= "{{ (XXX).GeneralSettings.RadioID }}"
| .GeneralSettings.RadioName |= "{{ (XXX).GeneralSettings.RadioName }}"

# Set the Intro values when the radio boots up to something helpful
| .GeneralSettings.IntroScreen |= "Character String"
| .GeneralSettings.IntroScreenLine1 |= "{{ (XXX).GeneralSettings.RadioID }}"
| .GeneralSettings.IntroScreenLine2 |= "{{ (XXX).GeneralSettings.RadioName }}"
