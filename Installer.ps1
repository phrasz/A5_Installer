$pwd = Get-Location
$N = 4
$NCurrent = 1

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes",""
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No",""
$Enter = New-Object System.Management.Automation.Host.ChoiceDescription "&",""

$choices = [System.Management.Automation.Host.ChoiceDescription[]]($yes,$no)

$caption = "     Warning!"
$message = "     Do you want to proceed?"

cls
Write-Host
Write-Host Allegro 5.1 Powershell Installer
Write-Host ================================
Write-Host V 1.0 by Phrasz

Write-Host [$NCurrent/$N] Making Directory: $pwd\Allegro5.1
echo "Hi" > Temp.txt
$source = "Temp.txt"
$Folder = "Allegro5.1"
$destination = "$pwd\$Folder"
#mkdir -p Allegro5.1 | out-null
Copy-Item -Path $source -Destination $destination -Filter {$_.PSIsContainer} -Recurse -Force
cd $Folder | out-null
del $source

Write-Host
$NCurrent += 1

####################################
# MinGW Installation
$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install MinGW?","",$choices,0)
if($result -eq 0){
	Write-Host [$NCurrent/$N] Downloading the Latest MinGW from Sourceforge
	(New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/project/mingw/Installer/mingw-get-inst/mingw-get-inst-20120426/mingw-get-inst-20120426.exe?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmingw%2Ffiles%2FInstaller%2Fmingw-get-inst%2Fmingw-get-inst-20120426%2F&ts=1373595137&use_mirror=hivelocity","MinGW_Latest_Installer.exe")

	Write-Host

	Write-Host "[$NCurrent/$N] Starting the Installer (Ensure C:\MinGW install path!)"
	move ..\MinGW_Latest_Installer.exe .
	& .\MinGW_Latest_Installer.exe
	Write-Host "     Press any key to continue ..."
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

}
if($result -eq 1) { 
	Write-Host "[$NCurrent/$N] Skipping MinGW Installation" 
}
####################################

Write-Host
$NCurrent += 1

####################################
# CMake Installation
$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install CMake?","",$choices,0)
if($result -eq 0){
	Write-Host [$NCurrent/$N] Downloading the Latest CMake from http://www.cmake.org/
	(New-Object System.Net.WebClient).DownloadFile("http://www.cmake.org/files/v2.8/cmake-2.8.11.2-win32-x86.exe","CMake_2.8.11.2_Installer.exe")

	Write-Host

	Write-Host "[$NCurrent/$N] Starting the Installer!"
	move ..\CMake_2.8.11.2_Installer.exe .
	& .\CMake_2.8.11.2_Installer.exe
	Write-Host "     Press any key to continue ..."
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

}
if($result -eq 1) { 
	Write-Host "[$NCurrent/$N] Skipping MsysGit Installation" 
}
####################################

Write-Host
$NCurrent += 1

####################################
# MsysGit Installation
$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install MsysGit?","",$choices,0)
if($result -eq 0){
	Write-Host [$NCurrent/$N] Downloading the Latest MsysGit from https://code.google.com/p/msysgit/
	(New-Object System.Net.WebClient).DownloadFile("https://msysgit.googlecode.com/files/Git-1.8.3-preview20130601.exe","MsysGit_1.8.3_Installer.exe")

	Write-Host

	Write-Host "[$NCurrent/$N] Starting the Installer!"
	move ..\MsysGit_1.8.3_Installer.exe .
	& .\MsysGit_1.8.3_Installer.exe
	Write-Host "     Press any key to continue ..."
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

}
if($result -eq 1) { 
	Write-Host "[$NCurrent/$N] Skipping MsysGit Installation" 
}
####################################

Write-Host
$NCurrent += 1

Write-Host Finished Installation!