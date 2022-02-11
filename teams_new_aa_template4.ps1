<# 
This example creates a new AA named "AA_NO_OSL_Demo_Auto_Attendant_4" that has the following properties:

It sets a default call flow.
It sets an after-hours call flow.
It sets a business hours options.
It references a call queue as a menu option.
The default language is en-US.
The time zone is set to Romance Standard.
It sets user1 as operator.
It has user2 also as a menu option.
The Auto Attendant is voice enabled.

#>

# ----------------- Update variables below -----------------------

# Create your own naming convention
$AAname = "AA_NO_OSL_Demo_Auto_Attendant_4"

# To Get and list all supported languages use: Get-CsAutoAttendantSupportedLanguage
$LanguageId = "en-US"

# To Get and list all TimeZone IDs use: Get-CsAutoAttendantSupportedTimeZone
$TimeZoneId = "Romance Standard Time"

# Create Time Range and after hour schedule
$tr1 = New-CsOnlineTimeRange -Start 07:00 -End 20:00
$afterHoursSchedule = New-CsOnlineSchedule -Name "After Hours" -WeeklyRecurrentSchedule -MondayHours @($tr1) -TuesdayHours @($tr1) -WednesdayHours @($tr1) -ThursdayHours @($tr1) -FridayHours @($tr1) -Complement

# Update identities to operator, user and CQ
$operatorUPN = "hein.koien@blinq.no"
$userUPN = "hein.koien@blinq.no"
$callQueueAppInstance = "queue.demo1@blinq.no" # one of the application instances associated to the Call Queue

# Update prompts
$greetingText = "Welcome to Contoso"
$mainMenuText = "To reach your party by name, say it now. To talk to Sales, please press 1. To talk to User2 press 2. Please press 0 for operator"
$afterHoursText = "Sorry Contoso is closed. Please call back during week days from 7AM to 8PM. Goodbye!"

# ---------------- Run the commands below when you have updated variables abowe  --------------------------------

$operatorId = (Get-CsOnlineUser -Identity "$operatorUPN").ObjectId
$user1Id = (Get-CsOnlineUser -Identity "$userUPN").ObjectId
$salesCQappinstance = (Get-CsOnlineUser -Identity "$callQueueAppInstance").ObjectId 

# After hours
$afterHoursGreetingPrompt = New-CsAutoAttendantPrompt -TextToSpeechPrompt $afterHoursText
$afterHoursMenuOption = New-CsAutoAttendantMenuOption -Action DisconnectCall -DtmfResponse Automatic
$afterHoursMenu = New-CsAutoAttendantMenu -Name "AA menu1" -MenuOptions @($afterHoursMenuOption)
$afterHoursCallFlow = New-CsAutoAttendantCallFlow -Name "After Hours" -Menu $afterHoursMenu -Greetings @($afterHoursGreetingPrompt)
$afterHoursCallHandlingAssociation = New-CsAutoAttendantCallHandlingAssociation -Type AfterHours -ScheduleId $afterHoursSchedule.Id -CallFlowId $afterHoursCallFlow.Id

# Business hours menu options
$operator = New-CsAutoAttendantCallableEntity -Identity $operatorId -Type User
$sales = New-CsAutoAttendantCallableEntity -Identity $salesCQappinstance -Type applicationendpoint
$user1 = New-CsAutoAttendantCallableEntity -Identity $user1Id -Type User
$menuOption0 = New-CsAutoAttendantMenuOption -Action TransferCallToOperator -DtmfResponse Tone0 -CallTarget $operator
$menuOption1 = New-CsAutoAttendantMenuOption -Action TransferCallToTarget -DtmfResponse Tone1 -CallTarget $sales
$menuOption2 = New-CsAutoAttendantMenuOption -Action TransferCallToTarget -DtmfResponse Tone2 -CallTarget $user1

# Business hours menu
$greetingPrompt = New-CsAutoAttendantPrompt -TextToSpeechPrompt $greetingText
$menuPrompt = New-CsAutoAttendantPrompt -TextToSpeechPrompt $mainMenuText
$menu = New-CsAutoAttendantMenu -Name "AA menu2" -Prompts @($menuPrompt) -EnableDialByName -MenuOptions @($menuOption0,$menuOption1,$menuOption2)
$callFlow = New-CsAutoAttendantCallFlow -Name "Default" -Menu $menu -Greetings $greetingPrompt

New-CsAutoAttendant -Name $AAname -LanguageId $languageId -CallFlows @($afterHoursCallFlow) -TimeZoneId $TimeZoneId -Operator $operator -DefaultCallFlow $callFlow -CallHandlingAssociations @($afterHoursCallHandlingAssociation) -EnableVoiceResponse
Set-CsAutoAttendant -Name $AAname -LanguageId $languageId -CallFlows @($afterHoursCallFlow) -TimeZoneId $TimeZoneId -Operator $operator -DefaultCallFlow $callFlow -CallHandlingAssociations @($afterHoursCallHandlingAssociation) -EnableVoiceResponse

# Output : 
# Identity                        : 9316da46-80f4-4803-98e1-81c73c5f7706
# TenantId                        : 27772aa8-fa11-4bd2-ae1b-dde8b4a7b78d
# Name                            : AA_NO_OSL_Demo_Auto_Attendant_4
# LanguageId                      : en-US
# VoiceId                         : Female
# DefaultCallFlow                 : Default
# Operator                        : ID=f85d83a9-ca4e-4f14-8819-5793ce448eac, Type=User
# TimeZoneId                      : Romance Standard Time
# VoiceResponseEnabled            : True
# CallFlows                       : After Hours
# Schedules                       : After Hours
# CallHandlingAssociations        : AfterHours(1)
# Status                          : Successful
# DialByNameResourceId            : adba9893-62e5-4114-9bb8-dc21aaf58e06
# DirectoryLookupScope            : 
# ApplicationInstances            : {}
# GreetingsSettingAuthorizedUsers : {}