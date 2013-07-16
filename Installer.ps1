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

$Folder = "Allegro5.1"
$destination = "$pwd\$Folder"
# if folder does not exist...
if (!(Test-Path $destination)) {
	# create it
	[void](new-item $folder -itemType directory)
}
cd $Folder | out-null


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
		move $env:HOMEDRIVE$env:HOMEPATH\MinGW_Latest_Installer.exe .
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
		move $env:HOMEDRIVE$env:HOMEPATH\CMake_2.8.11.2_Installer.exe .
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
		move %HOMEDRIVE%%HOMEPATH%\MsysGit_1.8.3_Installer.exe .
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

####################################
# Setup for Allegro Dependencies:
#    0) Create "...\Allegro5.1\A5_Deps" Folder
#
#	Then grab/build/place all needed files for the A5 install
#    1) Zlib
#    2) Ogg
#    3) Vorbis
#    4) FLAC
#    5) DUMB
#    6) DirectX9-bin
#    7) CG Toolkit-bin
#    8) OpenAL Soft
#    9) FreeType

####################################
#    0) Create "...\Allegro5.1\A5_Deps" Folder
	$F2 = "A5_Deps"
	Write-Host [$NCurrent/$N] Making Directory: .\$F2
	$dest2 = ".\$F2"
	# if folder does not exist...
	if (!(Test-Path $dest2)) {
		# create it
		[void](new-item $F2 -itemType directory)
	}
	cd $F2 | out-null
####################################

	Write-Host
	$NCurrent += 1

	####################################
	#	0) ENV VARs 
		
		#SET("CMAKE_C_COMPILER $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\bin\gcc.exe")
		#SET("CMAKE_CXX_COMPILER $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\bin\g++.exe")
	
	####################################
	#    1) Zlib
	$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to build Zlib? [DEBUGGING]","",$choices,0)
	if($result -eq 0){
		$Zlib = "Zlib"
		Write-Host [$NCurrent/$N] Making Directory: .\$Zlib
		$DestZlib = ".\$Zlib"
		# if folder does not exist...
		if (!(Test-Path $DestZlib)) {
			# create it
			[void](new-item $Zlib -itemType directory)
		}
		cd $Zlib | out-null
		
		(New-Object System.Net.WebClient).DownloadFile("http://zlib.net/zlib128.zip","Zlib_src.zip")

		Write-Host

		Write-Host "[$NCurrent/$N] Extracting + Building the source..."
		move $env:HOMEDRIVE$env:HOMEPATH\Zlib_src.zip .
		unzip -q Zlib_src.zip
		del Zlib_src.zip
		cd zlib-1.2.8
		mkdir build
		cd build
		
		$t1="cmake -G `"MinGW Makefiles`"  -D CMAKE_INSTALL_PREFIX=`"$env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\A5_Deps`" ..\"
		Write-Output $t1 | Out-File -encoding ASCII .\zlibcmd.bat -width 200
		& cmd.exe /k "cls && echo Building the Zlib source pt 1/2 && echo ================================= && echo Please type 'exit', and press enter, when this completes! && echo. && echo Right click, and press enter to continue... && echo (try twice b/c windows is HALF as awesome as Linux) && clip<zlibcmd.bat"
		
		Write-Host "[$NCurrent/$N] Builing the Zlib source pt 2/2 ..."

		\bin\mingw32-make.exe install
		cd ..\..\..\
	}
	if($result -eq 1) { 
		Write-Host "[$NCurrent/$N] Skipping MsysGit Installation" 
	}
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    2) Ogg
	$Ogg = "Ogg"
	Write-Host [$NCurrent/$N] Making Directory: .\$Ogg
	$DestOgg = ".\$Ogg"
	# if folder does not exist...
	if (!(Test-Path $DestOgg)){
		# create it
		[void](new-item $Ogg -itemType directory)
	}
	cd $Ogg | out-null
	
	(New-Object System.Net.WebClient).DownloadFile("http://downloads.xiph.org/releases/ogg/libogg-1.3.1.zip","Ogg_src.zip")

	Write-Host

	Write-Host "[$NCurrent/$N] Extracting + Building the source..."
	move $env:HOMEDRIVE$env:HOMEPATH\Ogg_src.zip .
	
	unzip -q Ogg_src.zip
	del Ogg_src.zip
	cd libogg-1.3.1
	$t1="#!/bin/sh"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200
	$t1="./configure --prefix=`"$HOME/Allegro5.1/A5_Deps`""
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	$t1="make"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	$t1="make install"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	
	$Sh = "profile.d"
	Write-Host [$NCurrent/$N] Making Directory: .\$Sh
	$DestSh = ".\.$Sh"
	# if folder does not exist...
	if (!(Test-Path $DestSh)){
		# create it
		[void](new-item $Sh -itemType directory)
	}
	move oggcmd.sh .\.profile.d
	
	#& msys --login
	
	
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    3) Vorbis
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    4) FLAC
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    5) DUMB
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    6) DirectX9-bin
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    7) CG Toolkit-bin
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    8) OpenAL Soft
	####################################

Write-Host
$NCurrent += 1

	####################################
	#    9) FreeType
	####################################

Write-Host Finished Installation!