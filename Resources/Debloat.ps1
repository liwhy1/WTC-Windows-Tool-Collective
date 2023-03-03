$AppXApps = @(

        "Microsoft.MicrosoftStickyNotes"
		"\.NET"
		"Microsoft.HEIFImageExtension"
		"Microsoft.VP9VideoExtensions"
		"Microsoft.WebMediaExtensions"
		"Microsoft.WebpImageExtension"
		"WindSynthBerry"
		"MIDIBerry"
		"Slack"
		"Microsoft.MixedReality.Portal"
		"Microsoft.PPIProjection"
		"Microsoft.BingNews"
		"Microsoft.GetHelp"
		"Microsoft.Getstarted"
		"Microsoft.Messaging"
		"Microsoft.Microsoft3DViewer"
		"Microsoft.MicrosoftOfficeHub"
		"Microsoft.MicrosoftSolitaireCollection"
		"Microsoft.NetworkSpeedTest"
		"Microsoft.News"
		"Microsoft.Office.Lens"
		"Microsoft.Office.OneNote"
		"Microsoft.Office.Sway"
		"Microsoft.OneConnect"
		"Microsoft.People"
		"Microsoft.Print3D"
		"Microsoft.RemoteDesktop"
		"Microsoft.SkypeApp"
		"Microsoft.Office.Todo.List"
		"Microsoft.Whiteboard"
		"Microsoft.WindowsAlarms"
		"microsoft.windowscommunicationsapps"
		"Microsoft.WindowsFeedbackHub"
		"Microsoft.WindowsMaps"
		"EclipseManager"
		"ActiproSoftwareLLC"
		"AdobeSystemsIncorporated.AdobePhotoshopExpress"
		"Duolingo-LearnLanguagesforFree"
		"PandoraMediaInc"
		"CandyCrush"
		"BubbleWitch3Saga"
		"Wunderlist"
		"Flipboard"
		"Twitter"
		"Facebook"
		"Minecraft"
		"Royal Revolt"
		"Sway"
		"Dolby"
		"Spotify"
		"Microsoft.549981C3F5F10"
		"Microsoft.NET.Native.Framework.2.2"
		"Microsoft.NET.Native.Runtime.2.2"
		"Microsoft.VCLibs.140.00.UWPDesktop"
		"Microsoft.VCLibs.140.00"
		"MicrosoftWindows.Client.WebExperience"
		"MicrosoftTeams"
		"Clipchamp.Clipchamp"
		"Microsoft.Todos"
		"Microsoft.VCLibs.140.00"
		"Microsoft.WindowsAppRuntime.1.2"
		"Microsoft.WindowsAppRuntime.1.2"
		"FACEBOOK.317180B0BB486"
		"Microsoft.NET.Native.Runtime.2.2"
		"Microsoft.NET.Native.Framework.2.2"
		"AmazonVideo.PrimeVideo"
		"22364Disney.ESPNBetaPWA"
		"BytedancePte.Ltd.TikTok"
		"Microsoft.VCLibs.140.00.UWPDesktop"
		"Microsoft.UI.Xaml.2.8"
		"Microsoft.UI.Xaml.2.8"
		"5319275A.WhatsAppDesktop"
		"Microsoft.WebMediaExtensions"
		"Microsoft.VP9VideoExtensions"
		"Microsoft.WebpImageExtension"
		"MicrosoftCorporationII.QuickAssist"
		"Microsoft.YourPhone"
		"Microsoft.UI.Xaml.2.4"
		"Microsoft.RawImageExtension"
		"Microsoft.PowerAutomateDesktop"
		"Microsoft.HEVCVideoExtension"
		"Microsoft.HEIFImageExtension"
		"Microsoft.BingWeather"
		"Microsoft.UI.Xaml.2.7"
		"Microsoft.UI.Xaml.2.7"
    )
    foreach ($App in $AppXApps) {
        Write-Verbose -Message ('Removing Package {0}' -f $App)
        Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
        Get-AppxPackage -Name $App -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $App | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
	
	#Disables Windows Feedback Experience
    Write-Output "Disabling Windows Feedback Experience program"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }
            
    #Stops Cortana from being used as part of your Windows Search Function
    Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

    #Disables Web Search in Start Menu
    Write-Output "Disabling Bing Search in Start Menu"
    $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
	If (!(Test-Path $WebSearch)) {
        New-Item $WebSearch
	}
	Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
            
    #Stops the Windows Feedback Experience from sending anonymous data
    Write-Output "Stopping the Windows Feedback Experience program"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item $Period
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

    #Prevents bloatware applications from returning and removes Start Menu suggestions               
    Write-Output "Adding Registry key to prevent bloatware apps from returning"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $registryPath)) { 
        New-Item $registryPath
    }
    Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

    If (!(Test-Path $registryOEM)) {
        New-Item $registryOEM
    }
        Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
        Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
        Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
        Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
        Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
        Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          
    
    #Preping mixed Reality Portal for removal    
    Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
    }

    #Disables Wi-fi Sense
    Write-Output "Disabling Wi-Fi Sense"
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
    $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
    $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
    If (!(Test-Path $WifiSense1)) {
	    New-Item $WifiSense1
    }
    Set-ItemProperty $WifiSense1  Value -Value 0 
	If (!(Test-Path $WifiSense2)) {
	    New-Item $WifiSense2
    }
    Set-ItemProperty $WifiSense2  Value -Value 0 
	Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
        
    #Disables live tiles
    Write-Output "Disabling live tiles"
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
    If (!(Test-Path $Live)) {      
        New-Item $Live
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
        
    #Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Output "Turning off Data Collection"
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }
    
    #Disabling Location Tracking
    Write-Output "Disabling Location Tracking"
    $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
    If (!(Test-Path $SensorState)) {
        New-Item $SensorState
    }
    Set-ItemProperty $SensorState SensorPermissionState -Value 0 
    If (!(Test-Path $LocationConfig)) {
        New-Item $LocationConfig
    }
    Set-ItemProperty $LocationConfig Status -Value 0 
        
    #Disables People icon on Taskbar
    Write-Output "Disabling People icon on Taskbar"
    $People = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"    
    If (!(Test-Path $People)) {
        New-Item $People
    }
    Set-ItemProperty $People  PeopleBand -Value 0 
        
    #Disables scheduled tasks that are considered unnecessary 
    Write-Output "Disabling scheduled tasks"
    Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask
    
    Write-Output "Stopping and disabling WAP Push Service"
    #Stop and disable WAP Push Service
	Stop-Service "dmwappushservice"
	Set-Service "dmwappushservice" -StartupType Disabled

    Write-Output "Stopping and disabling Diagnostics Tracking Service"
    #Disabling the Diagnostics Tracking Service
	Stop-Service "DiagTrack"
	Set-Service "DiagTrack" -StartupType Disabled

New-PSDrive -PSProvider Registry -Root HKEY_CLASSES_ROOT -Name HKCR
$Keys = @(
            
        #Remove Background Tasks
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Windows File
        "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
        #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Scheduled Tasks to delete
        "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
        #Windows Protocol Keys
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
               
        #Windows Share Target
        "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    )
        
    #This writes the output of each key it is removing and also removes the keys listed above.
    ForEach ($Key in $Keys) {
        Write-Output "Removing $Key from registry"
        Remove-Item $Key -Recurse -ErrorAction SilentlyContinue
    }
	