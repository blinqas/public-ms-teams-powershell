# Template queue

$Name = "CQ_NO_OSL_Demo_Queue_1"
$AgentAlertTime = 20
$AllowOptOut = $true
$UseDefaultMusicOnHold = $true
$OverflowActionTarget = "tel:+4793867777"
$OverflowThreshold = 5
$ConferenceMode = $true

$CQ = New-CsCallQueue -Name $Name -AgentAlertTime $AgentAlertTime -AllowOptOut $AllowOptOut -UseDefaultMusicOnHold $UseDefaultMusicOnHold -OverflowActionTarget $OverflowActionTarget -OverflowThreshold $OverflowThreshold -ConferenceMode $ConferenceMode

# Documentation of parameters

-Name
-AgentAlertTime                                         # PARAMVALUE:  0 - 180 seconds
-AllowOptOut                                            # PARAMVALUE:  $true | $false
-DistributionLists                                      # PARAMVALUE:  @(GUID1, GUID2) Distributionlist GUID
-UseDefaultMusicOnHold                                  # PARAMVALUE:  $true | $false
-WelcomeMusicAudioFileId                                # PARAMVALUE:  Id from Set-CsCallParkServiceMusicOnHoldFile, see teams_music_on_hold_file_template.ps1
-MusicOnHoldAudioFileId                                 # PARAMVALUE:  Id from Set-CsCallParkServiceMusicOnHoldFile, see teams_music_on_hold_file_template.ps1
-OverflowAction                                         # PARAMVALUE:  DisconnectWithBusy | Forward | Voicemail | SharedVoicemail
-OverflowActionTarget                                   # PARAMVALUE:  "tel:" | Office 365 Group ID | The OverflowActionTarget parameter represents the target of the overflow action. If the OverFlowAction is set to Forward, this parameter must be set to a Guid or a telephone number with a mandatory ‘tel:’ prefix. If the OverflowAction is set to SharedVoicemail, this parameter must be set to an Office 365 Group ID. Otherwise, this parameter is optional.
-OverflowThreshold                                      # PARAMVALUE:  0 - 200 calls | The OverflowThreshold parameter defines the number of calls that can be in the queue at any one time before the overflow action is triggered. The OverflowThreshold can be any integer value between 0 and 200, inclusive. A value of 0 causes calls not to reach agents and the overflow action to be taken immediately
-TimeoutAction                                          # PARAMVALUE:  Disconnect | Forward | Voicemail | SharedVoicemail
-TimeoutActionTarget                                    # PARAMVALUE:  The TimeoutActionTarget represents the target of the timeout action. If the TimeoutAction is set to Forward, this parameter must be set to a Guid or a telephone number with a mandatory ‘tel:’ prefix. If the TimeoutAction is set to SharedVoicemail, this parameter must be set to an Office 365 Group ID. Otherwise, this field is optional.
-TimeoutThreshold                                       # PARAMVALUE:  0 - 2700 seonds | The TimeoutThreshold parameter defines the time (in seconds) that a call can be in the queue before that call times out. At that point, the system will take the action specified by the TimeoutAction parameter. The TimeoutThreshold can be any integer value between 0 and 2700 seconds (inclusive), and is rounded to the nearest 15th interval. For example, if set to 47 seconds, then it is rounded down to 45. If set to 0, welcome music is played, and then the timeout action will be taken.
-RoutingMethod                                          # PARAMVALUE:  Attendant | Serial | RoundRobin | LongestIdle | The RoutingMethod defines how agents will be called in a Call Queue. If the routing method is set to Serial, then agents will be called one at a time. If the routing method is set to Attendant, then agents will be called in parallel. If routing method is set to RoundRobin, the agents will be called using Round Robin strategy so that all agents share the call-load equally. If routing method is set to LongestIdle, the agents will be called based on their idle time, i.e., the agent that has been idle for the longest period will be called.
-PresenceBasedRouting                                   # PARAMVALUE:  $true | $false | The PresenceBasedRouting parameter indicates whether or not presence based routing will be applied while call being routed to Call Queue agents. When set to False, calls will be routed to agents who have opted in to receive calls, regardless of their presence state. When set to True, opted-in agents will receive calls only when their presence state is Available.
-ConferenceMode                                         # PARAMVALUE:  $true | $false | The ConferenceMode parameter indicates whether or not Conference mode will be applied on calls for this Call queue. Conference mode significantly reduces the amount of time it takes for a caller to be connected to an agent, after the agent accepts the call. The following bullet points detail the difference between both modes:
-User                                                   # PARAMVALUE:  The Users parameter lets you add agents to the Call Queue. This parameter expects a list of user unique identifiers (GUID).
-LanguageId                                             # PARAMVALUE:  You can query the supported languages using the Get-CsAutoAttendantSupportedLanguage cmdlet | The LanguageId parameter indicates the language that is used to play shared voicemail prompts. This parameter becomes a required parameter If either OverflowAction or TimeoutAction is set to SharedVoicemail.
-OboResourceAccountIds                                  # PARAMVALUE:  The OboResourceAccountIds parameter lets you add resource account with phone number to the Call Queue. The agents in the Call Queue will be able to make outbound calls using the phone number on the resource accounts. This is a list of resource account GUIDs. Only Call Queue managed by a Teams Channel will be able to use this feature.
-OverflowSharedVoicemailTextToSpeechPrompt              # PARAMVALUE:  The OverflowSharedVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when transferred to shared voicemail on overflow. This parameter becomes a required parameter when OverflowAction is SharedVoicemail and OverflowSharedVoicemailAudioFilePrompt is null
-OverflowSharedVoicemailAudioFilePrompt                 # PARAMVALUE:  The OverflowSharedVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when transferred to shared voicemail on overflow. This parameter becomes a required parameter when OverflowAction is SharedVoicemail and OverflowSharedVoicemailTextToSpeechPrompt is null.
-EnableOverflowSharedVoicemailTranscription             # PARAMVALUE:  The EnableOverflowSharedVoicemailTranscription parameter is used to turn on transcription for voicemails left by a caller on overflow. This parameter is only applicable when OverflowAction is set to SharedVoicemail.
-TimeoutSharedVoicemailTextToSpeechPrompt               # PARAMVALUE:  The TimeoutSharedVoicemailTextToSpeechPrompt parameter indicates the Text-to-Speech (TTS) prompt which is to be played as a greeting to the caller when transferred to shared voicemail on timeout. This parameter becomes a required parameter when TimeoutAction is SharedVoicemail and TimeoutSharedVoicemailAudioFilePrompt is null.
-TimeoutSharedVoicemailAudioFilePrompt                  # PARAMVALUE:  The TimeoutSharedVoicemailAudioFilePrompt parameter indicates the unique identifier for the Audio file prompt which is to be played as a greeting to the caller when transferred to shared voicemail on timeout. This parameter becomes a required parameter when TimeoutAction is SharedVoicemail and TimeoutSharedVoicemailTextToSpeechPrompt is null.
-EnableTimeoutSharedVoicemailTranscription              # PARAMVALUE:  The EnableTimeoutSharedVoicemailTranscription parameter is used to turn on transcription for voicemails left by a caller on timeout. This parameter is only applicable when TimeoutAction is set to SharedVoicemail.
-ChannelId                                              # PARAMVALUE:  Id of the channel to connect a call queue to.
-ChannelUserObjectId                                    # PARAMVALUE:  Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx). This is the GUID of one of the owners of the team the channels belongs to.

# Reserved for Microsoft Internal use
-Tenant
-LineUri

# Command with all parameter options
New-CsCallQueue \
-Name <String>
[-AgentAlertTime <Int16>]
[-AllowOptOut <Boolean>]
[-DistributionLists <List>]
[-Tenant <Guid>]
[-UseDefaultMusicOnHold <Boolean>]
[-WelcomeMusicAudioFileId <Guid>]
[-MusicOnHoldAudioFileId <Guid>]
[-OverflowAction <Object>]
[-OverflowActionTarget <Guid>]
[-OverflowThreshold <Int16>]
[-TimeoutAction <Object>]
[-TimeoutActionTarget <Guid>]
[-TimeoutThreshold <Int16>]
[-RoutingMethod <Object>]
[-PresenceBasedRouting <Boolean>]
[-ConferenceMode <Boolean>]
[-User <List>]
[-LanguageId <String>]
[-LineUri <String>]
[-OboResourceAccountIds <List>]
[-OverflowSharedVoicemailTextToSpeechPrompt <String>]
[-OverflowSharedVoicemailAudioFilePrompt <Guid>]
[-EnableOverflowSharedVoicemailTranscription <Boolean>]
[-TimeoutSharedVoicemailTextToSpeechPrompt <String>]
[-TimeoutSharedVoicemailAudioFilePrompt <Guid>]
[-EnableTimeoutSharedVoicemailTranscription <Boolean>]
[-ChannelId <String>]
[-ChannelUserObjectId <Guid>]
[<CommonParameters>]
   

