<# 
This template creates a new Auto Attendant that has the following properties:

It sets a default call flow.
It sets an after-hours call flow.
It enables voice response with dial by name.
The default language is en-US.
The time zone is set to UTC.
An inclusion scope is specified.

#>

# ----------------- Update variables below -----------------------

# Create your own naming convention
$AAname = "AA_NO_OSL_Demo_Auto_Attendant"

# To Get and list all supported languages use: Get-CsAutoAttendantSupportedLanguage
$LanguageId = "en-US"

# To Get and list all TimeZone IDs use: Get-CsAutoAttendantSupportedTimeZone
$TimeZoneId = "UTC"

$operatorUPN = "operator.upn@contoso.com"
$operatorUPN = "hein.koien@blinq.no"
$welcomePrompt = "Welcome to Contoso"

# Update Prompts
$menuPromptTTS = "To reach your party by name, enter it now, followed by the pound sign or press 0 to reach the operator."
$afterHoursGreetingPromptTTS = "Welcome to Contoso! Unfortunately, you have reached us outside of our business hours. We value your call please call us back Monday to Friday, between 9 A.M. to 12 P.M. and 1 P.M. to 5 P.M. Goodbye!"

# Group Id to Office365 Group for all people that should be possible to reach with dial by name
$inclusionScopeGroupIds = @("5e16412e-1110-4ea5-94d7-43bd61bf00d3")

# Configure opening hours, add more time ranges if required
$timerange1 = New-CsOnlineTimeRange -Start 09:00 -end 12:00
$timerange2 = New-CsOnlineTimeRange -Start 13:00 -end 17:00
$afterHoursSchedule = New-CsOnlineSchedule -Name "After Hours Schedule" -WeeklyRecurrentSchedule -MondayHours @($timerange1, $timerange2) -TuesdayHours @($timerange1, $timerange2) -WednesdayHours @($timerange1, $timerange2) -ThursdayHours @($timerange1, $timerange2) -FridayHours @($timerange1, $timerange2) -Complement

# ---------------- Run the commands below when you have updated variables abowe  --------------------------------

$operatorObjectId = (Get-CsOnlineUser "$operatorUPN").ObjectId
$operatorEntity = New-CsAutoAttendantCallableEntity -Identity $operatorObjectId -Type User
$greetingPrompt = New-CsAutoAttendantPrompt -TextToSpeechPrompt "$welcomePrompt"
$menuOptionZero = New-CsAutoAttendantMenuOption -Action TransferCallToOperator -DtmfResponse Tone0
$menuPrompt = New-CsAutoAttendantPrompt -TextToSpeechPrompt "$menuPromptTTS"
$defaultMenu = New-CsAutoAttendantMenu -Name "Default menu" -Prompts @($menuPrompt) -MenuOptions @($menuOptionZero) -EnableDialByName
$defaultCallFlow = New-CsAutoAttendantCallFlow -Name "Default call flow" -Greetings @($greetingPrompt) -Menu $defaultMenu
$afterHoursGreetingPrompt = New-CsAutoAttendantPrompt -TextToSpeechPrompt "$afterHoursGreetingPromptTTS"
$automaticMenuOption = New-CsAutoAttendantMenuOption -Action Disconnect -DtmfResponse Automatic
$afterHoursMenu=New-CsAutoAttendantMenu -Name "After Hours menu" -MenuOptions @($automaticMenuOption)
$afterHoursCallFlow = New-CsAutoAttendantCallFlow -Name "After Hours call flow" -Greetings @($afterHoursGreetingPrompt) -Menu $afterHoursMenu
$afterHoursCallHandlingAssociation = New-CsAutoAttendantCallHandlingAssociation -Type AfterHours -ScheduleId $afterHoursSchedule.Id -CallFlowId $afterHoursCallFlow.Id
$inclusionScope = New-CsAutoAttendantDialScope -GroupScope -GroupIds $inclusionScopeGroupIds
$aa = New-CsAutoAttendant -Name "$AAname" -DefaultCallFlow $defaultCallFlow -EnableVoiceResponse -CallFlows @($afterHoursCallFlow) -CallHandlingAssociations @($afterHoursCallHandlingAssociation) -LanguageId "$LanguageId" -TimeZoneId "$TimeZoneId" -Operator $operatorEntity -InclusionScope $inclusionScope