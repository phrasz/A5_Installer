$pwd = Get-Location
$N = 4
$NCurrent = 1

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes",""
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No",""
$b32 = New-Object System.Management.Automation.Host.ChoiceDescription "&32",""
$b64 = New-Object System.Management.Automation.Host.ChoiceDescription "&64",""

$Enter = New-Object System.Management.Automation.Host.ChoiceDescription "&",""

$choices = [System.Management.Automation.Host.ChoiceDescription[]]($yes,$no)
$bit = [System.Management.Automation.Host.ChoiceDescription[]]($b32,$b64)

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
		(New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/project/mingw/Installer/mingw-get-inst/mingw-get-inst-20120426/mingw-get-inst-20120426.exe?r=&ts=1374192738&use_mirror=hivelocity","$env:HOMEDRIVE$env:HOMEPATH\MinGW_Latest_Installer.exe")

		Write-Host

		Write-Host "[$NCurrent/$N] Starting the Installer (Ensure C:\MinGW install path!)"
		Move-Item $env:HOMEDRIVE$env:HOMEPATH\MinGW_Latest_Installer.exe .
		& .\MinGW_Latest_Installer.exe
		& sysdm.cpl
		Write-Host "Add `";C:\MinGW\bin\;C:\MinGW\bin\`" to the System path! "
		Write-Host "   1) Click the `"Advanced`" Tab on the system properties window"
		Write-Host "   2) Click `"Environment Variables`""
		Write-Host "   3) On the bottom half, find PATH in the `"System variables`""
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
		(New-Object System.Net.WebClient).DownloadFile("http://www.cmake.org/files/v2.8/cmake-2.8.11.2-win32-x86.exe","$env:HOMEDRIVE$env:HOMEPATH\CMake_2.8.11.2_Installer.exe")

		Write-Host

		Write-Host "[$NCurrent/$N] Starting the Installer!"
		Move-Item $env:HOMEDRIVE$env:HOMEPATH\CMake_2.8.11.2_Installer.exe .
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
		(New-Object System.Net.WebClient).DownloadFile("https://msysgit.googlecode.com/files/Git-1.8.3-preview20130601.exe","$env:HOMEDRIVE$env:HOMEPATH\MsysGit_1.8.3_Installer.exe")

		Write-Host

		Write-Host "[$NCurrent/$N] Starting the Installer!"
		Move-Item $env:HOMEDRIVE$env:HOMEPATH\MsysGit_1.8.3_Installer.exe .
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
# 7zip
	$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install 7zip?","",$choices,0)
	if($result -eq 0){
		$result = $Host.UI.PromptForChoice("[$NCurrent/$N]      Would you like to install 7zip?","",$bit,0)
		if($result -eq 0){
			(New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/sevenzip/7z920.msi","$env:HOMEDRIVE$env:HOMEPATH\7zip_Installer.exe")
		}
		if($result -eq 1) {
			(New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/sevenzip/7z920-x64.msi","$env:HOMEDRIVE$env:HOMEPATH\7zip_Installer.exe")
		}
		Write-Host [$NCurrent/$N] Downloading the Latest 7zip from http://downloads.sourceforge.net/		
		Write-Host
		Write-Host "[$NCurrent/$N] Starting the Installer!"
		Move-Item $env:HOMEDRIVE$env:HOMEPATH\7zip_Installer.exe .
		& .\7zip_Installer.exe
			
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
$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to download and build Allegro's Dependencies?","",$choices,0)
if($result -eq 0){

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

$result2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install verified dependency packages??<DEBUGGING>","",$choices,0)
if($result2 -eq 0){
	####################################
	#	0) ENV VARs 
		
		#SET("CMAKE_C_COMPILER $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\bin\gcc.exe")
		#SET("CMAKE_CXX_COMPILER $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\bin\g++.exe")
	
	####################################
	#    1) Zlib
	$Zlib = "Zlib"
	Write-Host "[$NCurrent/$N] Creating Zlib Library:"
	Write-Host "[$NCurrent/$N] `tMaking Directory: .\$Zlib"
	$DestZlib = ".\$Zlib"
	# if folder does not exist...
	if (!(Test-Path $DestZlib)) {
		# create it
		[void](new-item $Zlib -itemType directory)
	}
	cd $Zlib | out-null
	$ZlibDL="http://zlib.net/zlib128.zip"
	Write-Host "[$NCurrent/$N] `tDownloading the source: $ZlibDL"		
	(New-Object System.Net.WebClient).DownloadFile($ZlibDL,"$env:HOMEDRIVE$env:HOMEPATH\Zlib_src.zip")


	Write-Host "[$NCurrent/$N] `tExtracting + Building the source..."
	Move-Item $env:HOMEDRIVE$env:HOMEPATH\Zlib_src.zip .
	unzip -q Zlib_src.zip
	del Zlib_src.zip
	cd zlib-1.2.8
	mkdir build
	cd build
	
	#$t1="cmake -G `"MinGW Makefiles`"  -D CMAKE_INSTALL_PREFIX=`"$env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\A5_Deps`" ..\"
	$t1="cmake -G `"MinGW Makefiles`"  -D CMAKE_INSTALL_PREFIX=`"C:\MinGW`" ..\"
	Write-Output $t1 | Out-File -encoding ASCII .\zlibcmd.bat -width 200
	& cmd.exe /k "cls && echo Building the Zlib source pt 1/2 && echo ================================= && echo Please type 'exit', and press enter, when this completes! && echo. && echo Right click, and press enter to continue... && echo (try twice b/c windows is HALF as awesome as Linux) && clip<zlibcmd.bat"
	
	Write-Host "[$NCurrent/$N] `tBuiling the Zlib source pt 2/2 ..."

	& C:\MinGW\bin\mingw32-make.exe install
	cd ..\..\..\
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    2) Ogg
	$Ogg = "Ogg"
	Write-Host "[$NCurrent/$N] Creating Ogg Libary"
	Write-Host "[$NCurrent/$N] `tMaking Directory: .\$Ogg"
	$DestOgg = ".\$Ogg"
	# if folder does not exist...
	if (!(Test-Path $DestOgg)){
		# create it
		[void](new-item $Ogg -itemType directory)
	}
	cd $Ogg | out-null
	
	$OggDL="http://downloads.xiph.org/releases/ogg/libogg-1.3.1.zip"
	Write-Host "[$NCurrent/$N] `tDownloading: $OggDL ..."
	
	(New-Object System.Net.WebClient).DownloadFile($OggDL,"$env:HOMEDRIVE$env:HOMEPATH\Ogg_src.zip")
	
	Move-Item $env:HOMEDRIVE$env:HOMEPATH\Ogg_src.zip .
	Write-Host "[$NCurrent/$N] `tExtracting the source..."
	unzip -q Ogg_src.zip
	del Ogg_src.zip
	cd libogg-1.3.1
	Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
	$t1="#!/bin/sh"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200
	$t1="cd ~/Allegro5.1/A5_Deps/Ogg/libogg-1.3.1/"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	#$t1="./configure --prefix=`"``echo ~/``Allegro5.1/A5_Deps`""
	$t1="./configure --prefix=`"/c/mingw`""
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	$t1="make"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	$t1="make install"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	$t1="exit"
	Write-Output $t1 | Out-File -encoding ASCII .\oggcmd.sh -width 200 -append
	Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
	$DestSh = "C:\MinGW\msys\1.0\etc\profile.d"
	Write-Host [$NCurrent/$N] Making Directory: .\$DestSh
	# if folder does not exist...
	if (!(Test-Path $DestSh)){
		# create it
		[void](new-item $DestSh -itemType directory)
	}
	#$file = Get-Item "$DestSh"
	#$file.Attributes = 'Hidden'
	Move-Item .\oggcmd.sh "$DestSh\" -force
	#copy $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\msys\1.0\msys.bat .
	& C:\MinGW\msys\1.0\msys --login #should only need to be called by last ps scripted

	
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    3) Vorbis
	$Vorbis = "Vorbis"
	Write-Host "[$NCurrent/$N] Creating Vorbis Libary"
	Write-Host "[$NCurrent/$N] `tMaking Directory: .\$Vorbis"
	$DestVorbis = ".\$Vorbis"
	# if folder does not exist...
	if (!(Test-Path $DestVorbis)){
		# create it
		[void](new-item $Vorbis -itemType directory)
	}
	cd $Vorbis | out-null
	
	$VorbisDL="http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.zip"
	Write-Host "[$NCurrent/$N] `tDownloading: $VorbisDL ..."
	
	(New-Object System.Net.WebClient).DownloadFile($VorbisDL,"$env:HOMEDRIVE$env:HOMEPATH\Vorbis_src.zip")
	
	Move-Item $env:HOMEDRIVE$env:HOMEPATH\Vorbis_src.zip .
	Write-Host "[$NCurrent/$N] `tExtracting the source..."
	unzip -q Vorbis_src.zip
	del Vorbis_src.zip
	cd libvorbis-1.3.3
	Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
	$t1="#!/bin/sh"
	Write-Output $t1 | Out-File -encoding ASCII .\Vorbiscmd.sh -width 200
	$t1="cd ~/Allegro5.1/A5_Deps/Vorbis/libvorbis-1.3.3/"
	Write-Output $t1 | Out-File -encoding ASCII .\Vorbiscmd.sh -width 200 -append
	#$t1="./configure --prefix=`"``echo ~/``Allegro5.1/A5_Deps`""
	$t1="./configure --prefix=`"/c/mingw`""
	Write-Output $t1 | Out-File -encoding ASCII .\Vorbiscmd.sh -width 200 -append
	$t1="make"
	Write-Output $t1 | Out-File -encoding ASCII .\Vorbiscmd.sh -width 200 -append
	$t1="make install"
	Write-Output $t1 | Out-File -encoding ASCII .\Vorbiscmd.sh -width 200 -append
	$t1="exit"
	Write-Output $t1 | Out-File -encoding ASCII .\Vorbiscmd.sh -width 200 -append
	Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
	$DestSh = "C:\MinGW\msys\1.0\etc\profile.d"
	Write-Host [$NCurrent/$N] Making Directory: .\$DestSh
	# if folder does not exist...
	if (!(Test-Path $DestSh)){
		# create it
		[void](new-item $DestSh -itemType directory)
	}
	#$file = Get-Item "$DestSh"
	#$file.Attributes = 'Hidden'
	Move-Item .\Vorbiscmd.sh "$DestSh\" -force
	#copy $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\msys\1.0\msys.bat .
	& C:\MinGW\msys\1.0\msys --login
	
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    4) FLAC
	$flac = "flac"
	Write-Host "[$NCurrent/$N] Creating flac Libary"
	Write-Host "[$NCurrent/$N] `tMaking Directory: .\$flac"
	$Destflac = ".\$flac"
	# if folder does not exist...
	if (!(Test-Path $Destflac)){
		# create it
		[void](new-item $flac -itemType directory)
	}
	cd $flac | out-null
	
	$flacDL="http://downloads.xiph.org/releases/flac/flac-1.3.0.tar.xz"
	Write-Host "[$NCurrent/$N] `tDownloading: $flacDL ..."
	
	(New-Object System.Net.WebClient).DownloadFile($flacDL,"$env:HOMEDRIVE$env:HOMEPATH\flac_src.tar.xz")
	
	Move-Item $env:HOMEDRIVE$env:HOMEPATH\flac_src.tar.xz .
	Write-Host "[$NCurrent/$N] `tExtracting the source..."
	& "7z" x flac_src.tar.xz
	& "7z" x flac_src.tar
	Remove-Item flac_src.tar -recurse
	Remove-Item flac_src.tar.xz -recurse

	#cd libflac-1.3.1
	Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
	$t1="#!/bin/sh"
	Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200
	$t1="cd ~/Allegro5.1/A5_Deps/flac/flac-1.3.0/"
	Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200 -append
	#$t1="./configure --prefix=`"``echo ~/``Allegro5.1/A5_Deps`""
	$t1="./configure --prefix=`"/c/mingw`""
	Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200 -append
	$t1="make"
	Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200 -append
	$t1="make install"
	Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200 -append
	$t1="exit"
	Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200 -append
	Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
	$DestSh = "C:\MinGW\msys\1.0\etc\profile.d"
	Write-Host [$NCurrent/$N] Making Directory: .\$DestSh
	# if folder does not exist...
	if (!(Test-Path $DestSh)){
		# create it
		[void](new-item $DestSh -itemType directory)
	}
	#$file = Get-Item "$DestSh"
	#$file.Attributes = 'Hidden'
	Move-Item .\flaccmd.sh "$DestSh\" -force
	#copy $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\msys\1.0\msys.bat .
	& C:\MinGW\msys\1.0\msys --login #should only need to be called by last ps scripted
	####################################
}
if($result2 -eq 1){ 
	Write-Host "[$NCurrent/$N] Skipping Verified Dependency Packages Installation" 
}
	Write-Host
	$NCurrent += 1

	####################################
	#    5) DUMB
	$DUMB = "DUMB"
	Write-Host "[$NCurrent/$N] Creating DUMB Libary"
	Write-Host "[$NCurrent/$N] `tMaking Directory: .\$DUMB"
	$DestDUMB = ".\$DUMB"
	# if folder does not exist...
	if (!(Test-Path $DestDUMB)){
		# create it
		[void](new-item $DUMB -itemType directory)
	}
	cd $DUMB | out-null
	
	#$DUMBDL="http://downloads.sourceforge.net/project/dumb/dumb/0.9.3/dumb-0.9.3.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fdumb%2Ffiles%2Fdumb%2F0.9.3%2F&ts=1374430774&use_mirror=iweb"
	$DUMBDL="http://downloads.sourceforge.net/project/dumb/dumb/0.9.3/dumb-0.9.3.zip?r=http%3A%2F%2Fdumb.sourceforge.net%2Findex.php%3Fpage%3Ddownloads&ts=1374462143&use_mirror=hivelocity"
	Write-Host "[$NCurrent/$N] `tDownloading: $DUMBDL ..."
	
	(New-Object System.Net.WebClient).DownloadFile($DUMBDL,"$env:HOMEDRIVE$env:HOMEPATH\DUMB_src.zip")
	
	Move-Item $env:HOMEDRIVE$env:HOMEPATH\DUMB_src.zip .
	Write-Host "[$NCurrent/$N] `tExtracting the source..."
	unzip -q DUMB_src.zip
	del DUMB_src.zip
	cd dumb-0.9.3
	Write-Host "[$NCurrent/$N] `tBuilding the source..."
	Write-Host "[$NCurrent/$N] `tPress M for MinGW, NO for Allegro 4.2..."
	& C:\MinGW\bin\mingw32-make.exe MINGDIR=C:\MinGW
	& C:\MinGW\bin\mingw32-make.exe install MINGDIR=C:\MinGW
	#Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
	#$t1="#!/bin/sh"
	#Write-Output $t1 | Out-File -encoding ASCII .\DUMBcmd.sh -width 200
	#$t1="cd ~/Allegro5.1/A5_Deps/DUMB/dumb-0.9.3/"
	#Write-Output $t1 | Out-File -encoding ASCII .\DUMBcmd.sh -width 200 -append
	##$t1="./configure --prefix=`"``echo ~/``Allegro5.1/A5_Deps`""
	#$t1="./configure --prefix=`"/c/mingw`""
	#Write-Output $t1 | Out-File -encoding ASCII .\DUMBcmd.sh -width 200 -append
	#$t1="make"
	#Write-Output $t1 | Out-File -encoding ASCII .\DUMBcmd.sh -width 200 -append
	#$t1="make install"
	#Write-Output $t1 | Out-File -encoding ASCII .\DUMBcmd.sh -width 200 -append
	#$t1="exit"
	#Write-Output $t1 | Out-File -encoding ASCII .\DUMBcmd.sh -width 200 -append
	#Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
	#$DestSh = "C:\MinGW\msys\1.0\etc\profile.d"
	#Write-Host [$NCurrent/$N] Making Directory: .\$DestSh
	## if folder does not exist...
	#if (!(Test-Path $DestSh)){
	#	# create it
	#	[void](new-item $DestSh -itemType directory)
	#}
	#$file = Get-Item "$DestSh"
	#$file.Attributes = 'Hidden'
	#Move-Item .\DUMBcmd.sh "$DestSh\" -force
	#copy $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\msys\1.0\msys.bat .
	#& C:\MinGW\msys\1.0\msys --login #should only need to be called by last ps scripted

	
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
	# Needed for Nvidia GPGPU stuff
	# https://developer.nvidia.com/cg-toolkit
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
	Write-Host
	$NCurrent += 1

	####################################
	#    9) PhysFS
	# http://icculus.org/physfs/downloads/physfs-2.0.3.tar.bz2
	####################################
	
	
	
}
if($result -eq 1) { 
	Write-Host "[$NCurrent/$N] Skipping Allegro Dependency Installation!" 
}
Write-Host Finished Installation!