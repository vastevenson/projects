#Install Chrome Extension (app ID: glnpjglilkicbckjpbgcfkogebgllemb (Okta))
#Vincent Stevenson
#adapted from: http://petermassa.com/?p=550

#this code creates a registry folder and file that adds an app ID as a required, force install 
#on chrome. Removing the app from this registry folder will remove the chrome extension when chrome
#restarts. 

$appid = 'glnpjglilkicbckjpbgcfkogebgllemb'#app ID of Okta
#check if chrome registry files are present
if (Test-Path -Path HKLM:\Software\Policies\Google\Chrome) {
} else {
#if not, then create them
New-Item -Path HKLM:\Software\Policies -Name Google –Force > $null
New-Item -Path HKLM:\Software\Policies\Google -Name Chrome –Force > $null
}

#check if Forcelist for Chrome Extensions (CRX) already exists
if (Test-Path -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist) {
Get-ChildItem -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist
} else {
#if not, create one
New-Item -Path HKLM:\Software\Policies\Google\Chrome -Name ExtensionInstallForcelist –Force > $null
}

#determine the name of the registry key to go under the Forcelist
$count = 1
$flag = $false
$va = Get-ChildItem hklm:\software\policies\google\chrome\
$va | foreach-object {
# Check for existing entry of that extension
$tempItem = $_ | get-itemproperty
if ($tempItem -match $appid -and $_.Name -match "ExtensionInstallForcelist") {
$tempItem
$flag = $true
}
# Check for next available id
if ($_.Name -match "ExtensionInstallForcelist") {
[int]$intNum = [convert]::ToInt32($_.ValueCount, 10)
$count = $count + $intNum
}
}

#if the extension wasn't on Forcelist, then add it. When chrome restarts, it will download and install the extension. 
if ($flag -eq $false) {
# Install extension
New-ItemProperty -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist `
-Name $count -Value "$($appid);https://clients2.google.com/service/update2/crx" –Force > $null
}

