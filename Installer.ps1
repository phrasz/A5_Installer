<#
PS C:\My_Programming\Provisioning\Allegro 5.1 Installer> Get-ExecutionPolicy
Restricted
PS C:\My_Programming\Provisioning\Allegro 5.1 Installer> Set-ExecutionPolicy Unrestricted
PS C:\My_Programming\Provisioning\Allegro 5.1 Installer> Get-ExecutionPolicy
Unrestricted
#>

$ARCH="i686-w64-mingw32"
$InstallationDir="C:\AllegroEnv"
$MinGWInstallaDir="$InstallationDir\MinGW-w64"
$ToolsFolder="$InstallationDir\Tools"
$AllegroInstallDir="$InstallationDir\Allegro5.1"
$AllegroCloneFolder="SourceForge_src_5.1"
$MSYSProfileDir = "$MinGWInstallaDir\msys\1.0\etc\profile.d"
$AllegroDepsBuildFolder = "$AllegroInstallDir\A5_Deps"
$ZlibBuildFolder = "$AllegroDepsBuildFolder\Zlib"
$ZlibDL="http://zlib.net/zlib128.zip"
$ZlibVersionFolder="zlib-1.2.8"
$OggBuildFolder = "$AllegroDepsBuildFolder\Ogg"
$OggDL="http://downloads.xiph.org/releases/ogg/libogg-1.3.2.zip"
$OggVersionFolder="libogg-1.3.2"
$VorbisBuildFolder = "$AllegroDepsBuildFolder\Vorbis"
$VorbisDL="http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.zip"
$VorbisVersionFolder="libvorbis-1.3.5"
$flacBuildFolder = "$AllegroDepsBuildFolder\flac"
$flacDL="http://downloads.xiph.org/releases/flac/flac-1.3.1.tar.xz"
$flacVersionFolder="flac-1.3.1"
$DUMBBuildFolder = "$AllegroDepsBuildFolder\DUMB"
$DUMBDL="http://colocrossing.dl.sourceforge.net/project/dumb/dumb/0.9.3/dumb-0.9.3.zip"
$DUMBVersionFolder="dumb-0.9.3"
$PhysFSBuildFolder = "$AllegroDepsBuildFolder\PhysFS"
$PhysFSDL="http://icculus.org/physfs/downloads/physfs-2.0.3.tar.bz2"
$PhysFSVersionFolder="physfs-2.0.3"
$LibPNGBuildFolder = "$AllegroDepsBuildFolder\LibPNG"
$LibPNGDL="http://hivelocity.dl.sourceforge.net/project/libpng/libpng16/1.6.17/lpng1617.zip"
$LibPNGVersionFolder="lpng1617"
$LibTheoraBuildFolder = "$AllegroDepsBuildFolder\LibTheora"
$LibTheoraDL="http://downloads.xiph.org/releases/theora/libtheora-1.1.1.zip"
$LibTheoraVersionFolder="libtheora-1.1.1"
$FreeTypeBuildFolder = "$AllegroDepsBuildFolder\FreeType"
$FreeTypeDL="http://softlayer-dal.dl.sourceforge.net/project/freetype/freetype2/2.5.5/ft255.zip"
$FreeTypeVersionFolder="freetype-2.5.5"
$OpenALBuildFolder = "$AllegroDepsBuildFolder\OpenAL"
$OpenALDL="http://web.archive.org/web/20130722162856/http://kcat.strangesoft.net/openal-releases/openal-soft-1.15.1.tar.bz2"
$OpenALVersionFolder="openal-soft-1.15.1"

#MSYS Style
$InstallationDirSH="/c/AllegroEnv"
$InstallationDirSHcmake="C:/AllegroEnv"
$MinGWInstallaDirSH="$InstallationDirSH/MinGW-w64"
$MinGWInstallaDirSHcmake="$InstallationDirSHcmake/MinGW-w64"
$AllegroInstallDirSH="$InstallationDirSH/Allegro5.1"
$AllegroSourceForgeDirSH="$AllegroInstallDirSH/$AllegroCloneFolder"
$AllegroDepsBuildFolderSH = "$AllegroInstallDirSH/A5_Deps"
$ZlibBuildFolderSH = "$AllegroDepsBuildFolderSH/Zlib/$ZlibVersionFolder"
$OggBuildFolderSH = "$AllegroDepsBuildFolderSH/Ogg/$OggVersionFolder"
$VorbisBuildFolderSH = "$AllegroDepsBuildFolderSH/Vorbis/$VorbisVersionFolder"
$flacBuildFolderSH = "$AllegroDepsBuildFolderSH/flac/$flacVersionFolder"
$DUMBBuildFolderSH = "$AllegroDepsBuildFolderSH/DUMB/$DUMBVersionFolder"
$PhysFSBuildFolderSH = "$AllegroDepsBuildFolderSH/PhysFS/$PhysFSVersionFolder"
$LibPNGBuildFolderSH = "$AllegroDepsBuildFolderSH/LibPNG/$LibPNGVersionFolder"
$LibTheoraBuildFolderSH = "$AllegroDepsBuildFolderSH/LibTheora/$LibTheoraVersionFolder"
$FreeTypeBuildFolderSH = "$AllegroDepsBuildFolderSH/FreeType/$FreeTypeVersionFolder"
$OpenALBuildFolderSH = "$AllegroDepsBuildFolderSH/OpenAL/$OpenALVersionFolder"
$MSYSProfileDPathSH = "$MinGWInstallaDirSH/msys/1.0/etc/profile.d"

push-location $InstallationDir
$pwd = Get-Location
#TotalSteps:
$N = 19
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
Write-Host V 2.0 by Phrasz copyleft 2015
#N=1
Write-Host [$NCurrent/$N] Making Directory: $InstallationDir
if (!(Test-Path $InstallationDir)) {
	[void](new-item $InstallationDir -itemType directory)
}
if (!(Test-Path $ToolsFolder)) {
	[void](new-item $ToolsFolder -itemType directory)
}
if (!(Test-Path $AllegroInstallDir)) {
	[void](new-item $AllegroInstallDir -itemType directory)
}
if (!(Test-Path $MinGWInstallaDir)) {
	[void](new-item $MinGWInstallaDir -itemType directory)
}
cd $InstallationDir | out-null

Write-Host
$NCurrent += 1

$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to download and Install the Needed Tools(Git/MinGW-w64/Git/etc.)?","",$choices,0)
if($result -eq 0){
	####################################
	# MinGW Installation
	#N = 2
		$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install MinGW-w64 via WinBuilds?","",$choices,0)
		if($result -eq 0){
			if (!(Test-Path $ToolsFolder\WinBuilds_1_5_0.exe -PathType Leaf)) {
				Write-Host "[$NCurrent/$N] Downloading the Win-Builds Installer 1.5.0"
				(New-Object System.Net.WebClient).DownloadFile("http://win-builds.org/1.5.0/win-builds-1.5.0.exe","$ToolsFolder\WinBuilds_1_5_0.exe")
			}
			else{
				Write-Host "MinGW Installer present...skipping download!"
			}
			

			if (!(Test-Path $MinGWInstallaDir)) {
				# create it
				[void](new-item $MinGWInstallaDir -itemType directory)
			}

			Write-Host

			Write-Host "[$NCurrent/$N] Starting the Installer (Ensure $ToolsFolder install path!)"
			#Move-Item $env:HOMEDRIVE$env:HOMEPATH\MinGW_Latest_Installer.exe .
			cd $ToolsFolder
			.\WinBuilds_1_5_0.exe
			& sysdm.cpl
			Write-Host "Add `";$ToolsFolder\MinGW-w64\bin`" to the System path! "
			Write-Host "   1) Click the `"Advanced`" Tab on the system properties window"
			Write-Host "   2) Click `"Environment Variables`""
			Write-Host "   3) On the bottom half, find PATH in the `"System variables`""
			Write-Host "     Press space bar to continue ..."
			$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

		}
		if($result -eq 1) { 
			Write-Host "[$NCurrent/$N] Skipping MinGW-w64 Installation" 
			#N -=1 ?
		}
	####################################
	 
	Write-Host
	$NCurrent += 1

	####################################
	# Msys Installation
	#N=3
		$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install MSYS?","",$choices,0)
		if($result -eq 0){
			##CHANGE
			if (!(Test-Path $ToolsFolder\Msys_get_Installer.exe -PathType Leaf)) {
				Write-Host [$NCurrent/$N] Downloading the Msys from a SourceForge.net link/
				(New-Object System.Net.WebClient).DownloadFile("http://hivelocity.dl.sourceforge.net/project/mingw/Installer/mingw-get-setup.exe","$ToolsFolder\Msys_get_Installer.exe")
			}
			else{
				Write-Host "Msys Installer present...skipping download!"
			}

			Write-Host

			Write-Host "[$NCurrent/$N] Starting the Installer!"
			cd $ToolsFolder\
			.\Msys_get_Installer.exe
			& sysdm.cpl
			Write-Host "For MSYS:"
			Write-Host "	1) First use the down-loader to install the mingwget tool in $MinGWInstallaDir, and new pop up will appear when done"
			Write-Host "	2) Next on the new window, Named MinGW Installation Manager"
			Write-Host "		1) Left Click on 'All Packages on the left'"
			Write-Host "		2) Left Click on 'MSYS Base System'"
			Write-Host "		3) On the right side, right click the 'msys-base' bin package and select 'Mark for Installation'"
			Write-Host "		4) Select the 'Installation' from the top left menu bar, and pick 'Apply Changes'"
			Write-Host "	3) Make sure the MSYS system installed to $MinGWInstallaDir\msys\"
			Write-Host
			Write-Host "If you did not select 'add to path for current, or all, users, then add `";C:\Program Files (x86)\CMake\bin`" to the System path! "
			Write-Host "   1) Click the `"Advanced`" Tab on the system properties window"
			Write-Host "   2) Click `"Environment Variables`""
			Write-Host "   3) On the bottom half, find PATH in the `"System variables`""
			Write-Host "     Press space bar to continue ..."
			$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
		}
		if($result -eq 1) { 
			Write-Host "[$NCurrent/$N] Skipping CMake Installation" 
		}
	####################################
	 
	Write-Host
	$NCurrent += 1

	####################################
	# CMake Installation
	#N=4
		$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install CMake?","",$choices,0)
		if($result -eq 0){
			##CHANGE
			if (!(Test-Path $ToolsFolder\CMake_3_2_2_Installer.exe -PathType Leaf)) {
				Write-Host [$NCurrent/$N] Downloading the Latest CMake from http://www.cmake.org/
				(New-Object System.Net.WebClient).DownloadFile("http://www.cmake.org/files/v3.2/cmake-3.2.2-win32-x86.exe","$ToolsFolder\CMake_3_2_2_Installer.exe")
			}
			else{
				Write-Host "OpenAL Source zip present...skipping download!"
			}

			Write-Host

			Write-Host "[$NCurrent/$N] Starting the Installer!"
			cd $ToolsFolder\
			.\CMake_3_2_2_Installer.exe
			& sysdm.cpl
			Write-Host "If you did not select 'add to path for current, or all, users, then add `";C:\Program Files (x86)\CMake\bin`" to the System path! "
			Write-Host "   1) Click the `"Advanced`" Tab on the system properties window"
			Write-Host "   2) Click `"Environment Variables`""
			Write-Host "   3) On the bottom half, find PATH in the `"System variables`""
			Write-Host "     Press space bar to continue ..."
			$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
		}
		if($result -eq 1) { 
			Write-Host "[$NCurrent/$N] Skipping CMake Installation" 
		}
	####################################

	 
	Write-Host
	$NCurrent += 1

	####################################
	# Git Installation
	#N=5
		$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install Git?","",$choices,0)
		if($result -eq 0){
			##CHANGE
			if (!(Test-Path $ToolsFolder\Git_1_9_5_Installer.exe -PathType Leaf)) {
				Write-Host [$NCurrent/$N] Downloading the Latest Git from GitHub.com
				(New-Object System.Net.WebClient).DownloadFile("https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/Git-1.9.5-preview20150319.exe","$ToolsFolder\Git_1_9_5_Installer.exe")
			}
			else{
				Write-Host "Git Installer present...skipping download!"
			}

			Write-Host
			cd $ToolsFolder\
			Write-Host "[$NCurrent/$N] Starting the Installer!"
			.\Git_1_9_5_Installer.exe
			& sysdm.cpl
			Write-Host "If you did not select 'add to path for current, or all, users, then add `";C:\Program Files (x86)\Git\bin`" to the System path! "
			Write-Host "   1) Click the `"Advanced`" Tab on the system properties window"
			Write-Host "   2) Click `"Environment Variables`""
			Write-Host "   3) On the bottom half, find PATH in the `"System variables`""
			Write-Host "     Press space bar to continue ..."
			$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

		}
		if($result -eq 1) { 
			Write-Host "[$NCurrent/$N] Skipping Git Installation" 
		}
	####################################


	Write-Host
	$NCurrent += 1

	####################################
	# 7zip
	#N=6
		$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to install 7zip?","",$choices,0)
		if($result -eq 0){
			##CHANGE
			if (!(Test-Path $ToolsFolder\7zip_Installer.msi -PathType Leaf)) {
				$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like the 32 bit or 64bit installer?","",$bit,0)
				if($result -eq 0){
					Write-Host "Downloading the 32 bit version!"
					(New-Object System.Net.WebClient).DownloadFile("http://www.7-zip.org/a/7z938.msi","$ToolsFolder\7zip_Installer.msi")
				}
				if($result -eq 1) {
					Write-Host "Downloading the 64 bit version!"
					(New-Object System.Net.WebClient).DownloadFile("http://www.7-zip.org/a/7z938-x64.msi","$ToolsFolder\7zip_Installer.msi")
				}
				Write-Host [$NCurrent/$N] Downloading the Latest 7zip from http://downloads.sourceforge.net/		
				Write-Host
			}
			else{
				Write-Host "7zip Installer present...skipping download!"
			}

			cd $ToolsFolder
			Write-Host "[$NCurrent/$N] Starting the Installer!"
			#Move-Item $env:HOMEDRIVE$env:HOMEPATH\7zip_Installer.exe .
			.\7zip_Installer.msi
			& sysdm.cpl
			Write-Host "If you did not select 'add to path for current, or all, users, then add `";C:\Program Files\7-Zip`" to the System path! "
			Write-Host "   1) Click the `"Advanced`" Tab on the system properties window"
			Write-Host "   2) Click `"Environment Variables`""
			Write-Host "   3) On the bottom half, find PATH in the `"System variables`""
				
			Write-Host "     Press space bar to continue ..."
			$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
		}
		if($result -eq 1) { 
			Write-Host "[$NCurrent/$N] Skipping MsysGit Installation" 
		}
	####################################

	Write-Host
	$NCurrent += 1
}
else{
	$NCurrent += 5
}

####################################
# Setup for Allegro Dependencies:
#    0) Create "...\Allegro5.1\A5_Deps" Folder
#
#	Then grab/build/place all needed files for the A5 install
#    1)  Zlib
#    2)  Ogg
#    3)  Vorbis
#    4)  FLAC
#    5)  DUMB
#	 6)  PhysFS
#	 7)	 LibPNG
#	 8)	 Theora
#    9) FreeType

#	Other Mentioned, but not used, A5.1 Deps:
#    #)  DirectX9-bin
#    #)  CG Toolkit-bin
#    #)  OpenAL Soft
$BuildDepsALL=$FALSE
$BuildDepsSingle=$FALSE
$BuildDepsSet=$FALSE

$result = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like to download and build Allegro's Dependencies?","",$choices,0)
if($result -eq 0){

	$resultDeps = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build ALL of the dependencies?","",$choices,0)
	if($resultDeps -eq 0){
		$BuildDepsALL=$TRUE
	}
	else{
		$BuildDepsALL=$FALSE
	}
	#Write-Host "Setting BuildDepsALL to $BuildDepsALL"



	####################################
	#    0) Create "...\Allegro5.1\A5_Deps" Folder
	#N=7
	#$AllegroInstallDir="$InstallationDir\Allegro5.1"

		Write-Host [$NCurrent/$N] Making Directory: $AllegroDepsBuildFolder
	#	$AllegroDepsBuildFolder = ".\$AllegroDepsBuildFolder"
		# if folder does not exist...
		if (!(Test-Path $AllegroDepsBuildFolder)) {
			# create it
			[void](new-item $AllegroDepsBuildFolder -itemType directory)
		}
		cd $AllegroDepsBuildFolder | out-null
	####################################
		Write-Host
		$NCurrent += 1

	####################################
	#	0) ENV VARs 
		
		#SET("CMAKE_C_COMPILER $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\bin\gcc.exe")
		#SET("CMAKE_CXX_COMPILER $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\bin\g++.exe")
	#Clean up other runs:
	rm $MSYSProfileDir\*.sh

	####################################
	#    1) Zlib
	#N=8
	cd $AllegroDepsBuildFolder
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the Zlib dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating Zlib Library:"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $ZlibBuildFolder"
		if (!(Test-Path $ZlibBuildFolder)) {
			[void](new-item $ZlibBuildFolder -itemType directory)
		}
		cd $ZlibBuildFolder | out-null
		if (!(Test-Path $ZlibBuildFolder\Zlib_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $ZlibDL"		
			(New-Object System.Net.WebClient).DownloadFile($ZlibDL,"$ZlibBuildFolder\Zlib_src.zip")
		}
		else{
			Write-Host "Zlib Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting + Building the source..."
		cd $ZlibBuildFolder
		if ( Test-Path '.\$ZlibVersionFolder' -PathType Container){
			rm -r $ZlibVersionFolder
		}
		unzip -q Zlib_src.zip
		#del Zlib_src.zip
		cd $ZlibVersionFolder
		mkdir build
		cd build
		Write-Host "Changing to: $ZlibBuildFolderSH"

		Write-Host "[$NCurrent/$N] `tBuiling the Zlib source pt 2/2 ..."
		
		$MSYSScript="01_Zlibcmd.sh"
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $ZlibBuildFolderSH/build"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
 
		$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH=$ARCH -DBUILD_SHARED_LIBS:BOOL=`"1`" -DBUILD_STATIC_LIBS:BOOL=`"0`" -DCMAKE_C_COMPILER=$MinGWInstallaDirSH/bin/gcc.exe -DCMAKE_CXX_COMPILER=$MinGWInstallaDirSH/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR=CXX -DCMAKE_C_COMPILER_ENV_VAR=CC -DCMAKE_MAKE_PROGRAM=$MinGWInstallaDirSH/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX=$MinGWInstallaDirSH .."
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		Write-Host "Awaiting to build source due to (Ogg configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder
	}
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    2) Ogg
	#N=9
	cd $AllegroDepsBuildFolder
	#$OggBuildFolder = "$AllegroDepsBuildFolder\Ogg"
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the Ogg dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){

		Write-Host "[$NCurrent/$N] Creating Ogg Library"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $OggBuildFolder"
		if (!(Test-Path $OggBuildFolder)) {
			[void](new-item $OggBuildFolder -itemType directory)
		}
		cd $OggBuildFolder | out-null

		if (!(Test-Path $OggBuildFolder\Ogg_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $OggDL"		
			(New-Object System.Net.WebClient).DownloadFile($OggDL,"$OggBuildFolder\Ogg_src.zip")
		}
		else{
			Write-Host "Ogg Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting + Building the source..."
		cd $OggBuildFolder
		if ( Test-Path '.\$OggVersionFolder' -PathType Container){
			rm -r $OggVersionFolder
		}
		unzip -q Ogg_src.zip
		#del Ogg_src.zip
		cd $OggVersionFolder
				
		Write-Host "Changing to: $OggBuildFolderSH"

		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$MSYSScript="02_Oggcmd.sh"
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $OggBuildFolderSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="./configure --host=$ARCH --enable-static=no --enable-shared=yes --prefix=`"$MinGWInstallaDirSH`""
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="make"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="make install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append		
		
		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		Write-Host "Awaiting to build source due to (Vorbis configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################
#$resultDeps = $Host.UI.PromptForChoice("BREAK!!!!!!!!!!!!","",$choices,0)
#if($resultDeps -eq 0){
#}

	Write-Host
	$NCurrent += 1

	####################################
	#    3) Vorbis
	#N=10
	cd $AllegroDepsBuildFolder
	#$VorbisBuildFolder = "$AllegroDepsBuildFolder\Vorbis"
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the Vorbis dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating Vorbis Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $VorbisBuildFolder"
		if (!(Test-Path $VorbisBuildFolder)) {
			[void](new-item $VorbisBuildFolder -itemType directory)
		}
		cd $VorbisBuildFolder | out-null

		if (!(Test-Path $VorbisBuildFolder\Vorbis_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $VorbisDL"		
			(New-Object System.Net.WebClient).DownloadFile($VorbisDL,"$VorbisBuildFolder\Vorbis_src.zip")
		}
		else{
			Write-Host "Vorbis Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting + Building the source..."
		cd $VorbisBuildFolder
		if ( Test-Path '.\$VorbisVersionFolder' -PathType Container){
			rm -r $VorbisVersionFolder
		}
		unzip -q Vorbis_src.zip
		#del Vorbis_src.zip
		cd $VorbisVersionFolder
				
		Write-Host "Changing to: $VorbisBuildFolderSH"	

		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$MSYSScript="03_Vorbiscmd.sh"
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $VorbisBuildFolderSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="./configure --host=$ARCH --enable-static=no --enable-shared=yes --prefix=`"$MinGWInstallaDirSH`""
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="make"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="make install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append		
		
		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}

		Write-Host "Awaiting to build source due to (Vorbis configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################

	Write-Host
	$NCurrent += 1

 	####################################
	#    4) FLAC
	#N=11
	cd $AllegroDepsBuildFolder
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the FLAC dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating flac Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $flacBuildFolder"
		if (!(Test-Path $flacBuildFolder)) {
			[void](new-item $flacBuildFolder -itemType directory)
		}
		cd $flacBuildFolder | out-null

		if (!(Test-Path $flacBuildFolder\flac_src.tar.xz -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $flacDL"		
			(New-Object System.Net.WebClient).DownloadFile($flacDL,"$flacBuildFolder\flac_src.tar.xz")
		}
		else{
			Write-Host "flac Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."
		& "7z" x flac_src.tar.xz
		& "7z" x flac_src.tar
		Remove-Item flac_src.tar -recurse
		#Remove-Item flac_src.tar.xz -recurse

		& rm -r .\PaxHeaders.20420
		cd $flacVersionFolder
		
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$MSYSScript="04_flaccmd.sh"
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200
		$t1="cd $flacBuildFolderSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="./configure --disable-doxygen-docs --host=$ARCH --enable-static=no --enable-shared=yes --prefix=`"$MinGWInstallaDirSH`""
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="make"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="make install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append		
		
		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
			
		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}

		Write-Host "Awaiting to build source due to (DUMB configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################

	Write-Host
	$NCurrent += 1

	####################################
	#    5) DUMB
	#N=12
	cd $AllegroDepsBuildFolder
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the DUMB dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating DUMB Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $DUMBBuildFolder"
		if (!(Test-Path $DUMBBuildFolder)) {
			[void](new-item $DUMBBuildFolder -itemType directory)
		}
		cd $DUMBBuildFolder | out-null

		if (!(Test-Path $DUMBBuildFolder\DUMB_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $DUMBDL"		
			(New-Object System.Net.WebClient).DownloadFile($DUMBDL,"$DUMBBuildFolder\DUMB_src.zip")
		}
		else{
			Write-Host "DUMB Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting + Building the source..."
		cd $DUMBBuildFolder
		unzip -q DUMB_src.zip
		#del DUMB_src.zip
		cd $DUMBVersionFolder

		Write-Host

		$MSYSScript="05_DUMBcmd.sh"
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\flaccmd.sh -width 200
		$t1="cd $DUMBBuildFolderSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="echo `"Press M for MinGW, NO for Allegro 4.2...`""
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe MINGDIR=$MinGWInstallaDirSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install MINGDIR=$MinGWInstallaDirSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append		
		
		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
			
		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}

		#Write-Host "Awaiting to build source due to (Ogg configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################

	Write-Host
	$NCurrent += 1

 	####################################
	#    6) PhysFS
	#N=13
	cd $AllegroDepsBuildFolder
	# http://icculus.org/physfs/downloads/physfs-2.0.3.tar.bz2
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the PhysFS dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating PhysFS Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $PhysFSBuildFolder"
		if (!(Test-Path $PhysFSBuildFolder)) {
			[void](new-item $PhysFSBuildFolder -itemType directory)
		}
		cd $PhysFSBuildFolder | out-null
	 
		if (!(Test-Path $PhysFSBuildFolder\PhysFS_src.tar.bz2 -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $PhysFSDL"		
			(New-Object System.Net.WebClient).DownloadFile($PhysFSDL,"$PhysFSBuildFolder\PhysFS_src.tar.bz2")
		}
		else{
			Write-Host "PhysFS Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."
		& 7z x PhysFS_src.tar.bz2
		& 7z x PhysFS_src.tar
		Remove-Item PhysFS_src.tar -recurse
	#	del physfs-2.0.3.tar.bz2
		cd $PhysFSVersionFolder
		mkdir build
		cd build

		#Remove-Item PhysFS_src.tar.xz -recurse

		Write-Host "[$NCurrent/$N] `tBuiling the PhysFS source pt 2/2 ..."

		$MSYSScript="06_PhysFScmd.sh"
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $PhysFSBuildFolderSH/build"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH=$ARCH -DPHYSFS_BUILD_SHARED:BOOL=`"1`" -DPHYSFS_BUILD_STATIC:BOOL=`"0`" -DCMAKE_C_COMPILER=$MinGWInstallaDirSH/bin/gcc.exe -DCMAKE_CXX_COMPILER=$MinGWInstallaDirSH/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR=CXX -DCMAKE_C_COMPILER_ENV_VAR=CC -DCMAKE_MAKE_PROGRAM=$MinGWInstallaDirSH/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX=$MinGWInstallaDirSH .."
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		#For whatever reason there's a /* HACK! */ Comment in the lzma.c (7zip) files that pops -Werror with MinGW-w64 ... were going to actively ignore that
		$t1="sed -i 's/Werror/Wall/g' ./CMakeFiles/physfs-static.dir/flags.make"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="sed -i 's/Werror/Wall/g' ./CMakeFiles/physfs.dir/flags.make"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="sed -i 's/Werror/Wall/g' ./CMakeFiles/test_physfs.dir/flags.make"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		Write-Host "Awaiting to build source due to (LibPNG configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################
	
	Write-Host
	$NCurrent += 1

	####################################
	#    7) LibPNG
	#N=14
	cd $AllegroDepsBuildFolder
	# http://downloads.sourceforge.net/project/libpng/libpng16/1.6.3/lpng163.zip?r=&ts=1375031571&use_mirror=superb-dca3
		if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the LibPNG dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating LibPNG Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $LibPNGBuildFolder"
		if (!(Test-Path $LibPNGBuildFolder)) {
			[void](new-item $LibPNGBuildFolder -itemType directory)
		}
		cd $LibPNGBuildFolder | out-null

		if (!(Test-Path $LibPNGBuildFolder\LibPNG_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $LibPNGDL"		
			(New-Object System.Net.WebClient).DownloadFile($LibPNGDL,"$LibPNGBuildFolder\LibPNG_src.zip")
		}
		else{
			Write-Host "LibPNG Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."
		unzip -q LibPNG_src.zip
	#	del LibPNG_src.zip
		cd $LibPNGVersionFolder
		mkdir build
		cd build
		
		Write-Host "[$NCurrent/$N] `tBuiling the LibPNG source pt 2/2 ..."

		$MSYSScript="07_LibPNGcmd.sh"
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $LibPNGBuildFolderSH/build"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH=$ARCH -DPNG_STATIC:BOOL=`"0`" -DPNG_SHARED:BOOL=`"1`" -DCMAKE_C_COMPILER=$MinGWInstallaDirSH/bin/gcc.exe -DCMAKE_CXX_COMPILER=$MinGWInstallaDirSH/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR=CXX -DCMAKE_C_COMPILER_ENV_VAR=CC -DCMAKE_MAKE_PROGRAM=$MinGWInstallaDirSH/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX=$MinGWInstallaDirSH .."
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		Write-Host "Awaiting to build source due to (LibTheora configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################
	
	Write-Host
	$NCurrent += 1

	####################################
	# LibTheora
	#N=15
	cd $AllegroDepsBuildFolder
	# http://downloads.xiph.org/releases/theora/libtheora-1.1.1.zip
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the LibTheora dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating LibTheora Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $LibTheoraBuildFolder"
		if (!(Test-Path $LibTheoraBuildFolder)) {
			[void](new-item $LibTheoraBuildFolder -itemType directory)
		}
		cd $LibTheoraBuildFolder | out-null

		if (!(Test-Path $LibTheoraBuildFolder\LibTheora_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $LibTheoraDL"		
			(New-Object System.Net.WebClient).DownloadFile($LibTheoraDL,"$LibTheoraBuildFolder\LibTheora_src.zip")
		}
		else{
			Write-Host "LibTheora Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."
		unzip -q LibTheora_src.zip
	#	del LibPNG_src.zip
		cd $LibTheoraVersionFolder
		#mkdir build
		#cd build
		

		Write-Host "[$NCurrent/$N] `tBuiling the LibTheora source pt 2/2 ..."

		$MSYSScript="08_LibTheoracmd.sh"
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $LibTheoraBuildFolderSH"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		$t1="./configure --enable-static=no --enable-shared=yes --prefix=`"$MinGWInstallaDirSH`""
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		Write-Host "Awaiting to build source due to (FreeType configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################

	Write-Host
	$NCurrent += 1
	
	####################################
	#    11) FreeType
	#	
	# N=16
	cd $AllegroDepsBuildFolder
	# DEPENDS ON LIBPNG!!!
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the FreeType dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating FreeType Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $FreeTypeBuildFolder"
		if (!(Test-Path $FreeTypeBuildFolder)) {
			[void](new-item $FreeTypeBuildFolder -itemType directory)
		}
		cd $FreeTypeBuildFolder | out-null

		if (!(Test-Path $FreeTypeBuildFolder\FreeType_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $FreeTypeDL"		
			(New-Object System.Net.WebClient).DownloadFile($FreeTypeDL,"$FreeTypeBuildFolder\FreeType_src.zip")
		}
		else{
			Write-Host "FreeType Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."
		unzip -q FreeType_src.zip
	#	del LibPNG_src.zip
		cd $FreeTypeVersionFolder
		mkdir build
		cd build

		Write-Host "[$NCurrent/$N] `tBuiling the FreeType source pt 2/2 ..."

		$MSYSScript="09_FreeTypecmd.sh"
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $FreeTypeBuildFolderSH/build"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH=$ARCH -DSHARED:BOOL=`"1`" -DFLAC_STATIC:BOOL=`"0`" -DCMAKE_C_COMPILER=$MinGWInstallaDirSH/bin/gcc.exe -DCMAKE_CXX_COMPILER=$MinGWInstallaDirSH/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR=CXX -DCMAKE_C_COMPILER_ENV_VAR=CC -DCMAKE_MAKE_PROGRAM=$MinGWInstallaDirSH/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX=$MinGWInstallaDirSH .."
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append


		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		#Write-Host "Awaiting to build source due to (Ogg configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		#& msys --login
		$BuildDepsSet=$TRUE
		cd $AllegroDepsBuildFolder		
	}
	####################################

	Write-Host
	$NCurrent += 1

	###################################
	#   12) OpenAL Soft
	# Was originally going to NOT use this ... then DSOUND kept crashing...
	cd $AllegroDepsBuildFolder
	# Original: http://connect.creativelabs.com/openal/Downloads/openal-soft-1.13.tbz2
	# N=17
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like build the OpenAL dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		Write-Host "[$NCurrent/$N] Creating OpenAL Libary"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $OpenALBuildFolder"
		if (!(Test-Path $OpenALBuildFolder)) {
			[void](new-item $OpenALBuildFolder -itemType directory)
		}
		cd $OpenALBuildFolder | out-null

		if (!(Test-Path $OpenALBuildFolder\OpenAL_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $OpenALDL"		
			(New-Object System.Net.WebClient).DownloadFile($OpenALDL,"$OpenALBuildFolder\OpenAL_src.tar.bz2")
		}
		else{
			Write-Host "OpenAL Source zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."

		& "7z" x OpenAL_src.tar.bz2
		& "7z" x OpenAL_src.tar
		del OpenAL_src.tar
		#del OpenAL_src.tbz2
		cd $OpenALVersionFolder
		#mkdir build #it extracts with a build folder...
		cd build

		Write-Host "[$NCurrent/$N] `tBuiling the OpenAL source pt 2/2 ..."

		$MSYSScript="10_OpenALcmd.sh"
		Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
		$t1="#!/bin/sh"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
		$t1="cd $OpenALBuildFolderSH/build"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

		$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH=$ARCH -DLIBTYPE=`"SHARED`" -DCMAKE_C_COMPILER=$MinGWInstallaDirSH/bin/gcc.exe -DCMAKE_CXX_COMPILER=$MinGWInstallaDirSH/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR=CXX -DCMAKE_C_COMPILER_ENV_VAR=CC -DCMAKE_MAKE_PROGRAM=$MinGWInstallaDirSH/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX=$MinGWInstallaDirSH .."
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
		$t1="mingw32-make.exe install"
		Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append


		Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

		Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
		if (!(Test-Path $MSYSProfileDir)){
			[void](new-item $MSYSProfileDir -itemType directory)
		}
		#Write-Host "Awaiting to build source due to (Ogg configuration...)"
		Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
		$BuildDepsSet=$TRUE

		cd $AllegroDepsBuildFolder		
	}
	####################################

	#Build 'em if you got 'em
	if($BuildDepsSet -eq $TRUE){
		& msys --login
	}
	
	Write-Host
	$NCurrent += 1
	
	####################################
	#    13) DirectX9/10-bin with Sal.h 
	####################################
	# N=17
	cd $AllegroDepsBuildFolder
	if($BuildDepsALL -eq $FALSE){
		$resultDeps2 = $Host.UI.PromptForChoice("[$NCurrent/$N] Would you like install the DirectX/Sal.h dependency?","",$choices,0)
		if($resultDeps2 -eq 0){
			$BuildDepsSingle=$TRUE
		}
		else{
			$BuildDepsSingle=$FALSE
		}
	}
	Write-Host "Setting BuildDepsSingle to $BuildDepsSingle"

	if(($BuildDepsALL -eq $TRUE) -or ($BuildDepsSingle -eq $TRUE)){
		$DXBuildFolder = "$AllegroDepsBuildFolder\DX"
		$DXDL="https://drive.google.com/uc?export=download&id=0Bx8XklQ4Lhh5NXZRQmtqYlR0eTg"
		$DXVersionFolder="D10_x64_with_sal"

		Write-Host "[$NCurrent/$N] Obtaining DirectX Needs"
		Write-Host "[$NCurrent/$N] `tMaking Directory: $DXBuildFolder"
		if (!(Test-Path $DXBuildFolder)) {
			[void](new-item $DXBuildFolder -itemType directory)
		}
		cd $DXBuildFolder | out-null

		if (!(Test-Path $DXBuildFolder\DX_src.zip -PathType Leaf)) {
			Write-Host "[$NCurrent/$N] `tDownloading the source: $DXDL"		
			(New-Object System.Net.WebClient).DownloadFile($DXDL,"$DXBuildFolder\DX_src.zip")
		}
		else{
			Write-Host "DX zip present...skipping download!"
		}

		Write-Host "[$NCurrent/$N] `tExtracting the source..."

		& "unzip" -q DX_src.zip
		#del DX_src.zip
		#cd $DXVersionFolder
		copy .\include\* $MinGWInstallaDir\include\
		copy .\lib\* $MinGWInstallaDir\lib\

		cd $AllegroDepsBuildFolder		
	}
	####################################
	Write-Host
	$NCurrent += 1
}
else{
	$NCurrent += 12
}

Write-Host Finished Installation of Allegro Dependencies!

#N=19
$result = $Host.UI.PromptForChoice("[$NCurrent/$N] [RUN AFTER MSYS IS DONE!] Would you like to download and build Allegro's source?","",$choices,0)
if($result -eq 0){
	cd $AllegroInstallDir
	if (!(Test-Path $AllegroCloneFolder)) {
		Write-Host "[$NCurrent/$N] Cloning Allegro 5.1 from SourceForge!"
		& git clone git://git.code.sf.net/p/alleg/allegro $AllegroCloneFolder
		cd $AllegroCloneFolder
	}
	else{
		cd $AllegroCloneFolder
		Write-Host "[$NCurrent/$N] Allegro 5.1 Source Present!"
		Write-Host "[$NCurrent/$N] 		Resetting repo and pulling the latest!"
		& git reset --hard HEAD
		& git pull origin master
	}

	if (!(Test-Path .\buildStatic)) {
		[void](new-item .\buildStatic -itemType directory)
	}
	else{
		Write-Host "build folder present! Deleting and resetting"
		rm -r .\buildStatic
		[void](new-item .\buildStatic -itemType directory)
	}
	if (!(Test-Path .\buildShared)) {
		[void](new-item .\buildShared -itemType directory)
	}
	else{
		Write-Host "build folder present! Deleting and resetting"
		rm -r .\buildShared
		[void](new-item .\buildShared -itemType directory)
	}
	cd .\buildShared

	#Clean up Deps build or old Allegro Source building...
	rm $MSYSProfileDir\*.sh
	
	Write-Host "[$NCurrent/$N] `tBuiling the Allegro Source from SourceForge source pt 2/2 ..."

	$MSYSScript="00_BUILDAllegrocmd.sh"
	Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
	$t1="#!/bin/sh"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200
	$t1="cd $AllegroSourceForgeDirSH/buildShared"
<#
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
	$t1="echo 'Patching like a boss (aka MinGW-w64 has issues, and these are workarounds.)'"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
	
	$t1="sed -i 's/test_big_endian(ALLEGRO_BIG_ENDIAN)/#test_big_endian(ALLEGRO_BIG_ENDIAN)/g' ./CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="sed -i 's/endif(NOT ALLEGRO_BIG_ENDIAN)/#endif(NOT ALLEGRO_BIG_ENDIAN)/g' ./CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="sed -i 's/if(NOT ALLEGRO_BIG_ENDIAN)/#if(NOT ALLEGRO_BIG_ENDIAN)/g' ./CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append


	$t1="sed -i 's/endif(FLAC_COMPILES)/#endif(FLAC_COMPILES)/g' ./addons/acodec/CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="sed -i 's/if(FLAC_COMPILES)/#if(FLAC_COMPILES)/g' ./addons/acodec//CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="sed -i 's/endif(DUMB_COMPILES)/#endif(DUMB_COMPILES)/g' ./addons/acodec//CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="sed -i 's/if(DUMB_COMPILES)/#if(DUMB_COMPILES)/g' ./addons/acodec//CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	#$t1="sed -i 's/endif(VORBIS_COMPILES)/#endif(VORBIS_COMPILES)/g' ./addons/acodec//CMakeLists.txt"
	#Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="sed -i 's/if(VORBIS_COMPILES)/if(VORBIS_FOUND)/g' ./addons/acodec//CMakeLists.txt"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append
#>
	$t1="cd $AllegroSourceForgeDirSH/buildShared"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH:STRING=$ARCH -DCMAKE_LIBRARY_PATH:PATH=`"$MinGWInstallaDirSHcmake/lib;$MinGWInstallaDirSHcmake/$ARCH/lib`" -DCMAKE_INCLUDE_PATH:PATH=`"$MinGWInstallaDirSHcmake/include;$MinGWInstallaDirSHcmake/$ARCH/include`" -DCMAKE_C_COMPILER:FILEPATH=$MinGWInstallaDirSHcmake/bin/gcc.exe -DCMAKE_CXX_COMPILER:FILEPATH=$MinGWInstallaDirSHcmake/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR:STRING=CXX -DCMAKE_C_COMPILER_ENV_VAR:STRING=CC -DCMAKE_MAKE_PROGRAM:FILEPATH=$MinGWInstallaDirSHcmake/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX:PATH=$MinGWInstallaDirSHcmake -DWANT_MONOLITH:BOOL=`"0`" -DWANT_DLL_TLS:BOOL=`"0`" -DWANT_ANDROID_LEGACY:BOOL=`"0`" -DWANT_FLAC:BOOL=`"1`" -DWANT_DOCS_INFO:BOOL=`"0`" -DWANT_IMAGE:BOOL=`"1`" -DWANT_PRIMITIVES:BOOL=`"1`" -DWANT_OSS:BOOL=`"0`" -DWANT_MEMFILE:BOOL=`"1`" -DWANT_PHYSFS:BOOL=`"1`" -DWANT_AQUEUE:BOOL=`"0`" -DWANT_MODAUDIO:BOOL=`"1`" -DWANT_DSOUND:BOOL=`"0`" -DWANT_FRAMEWORKS:BOOL=`"0`" -DWANT_DOCS_HTML:BOOL=`"0`" -DWANT_OPENGL_S3TC_LOCKING:BOOL=`"0`" -DWANT_OPENAL:BOOL=`"1`" -DWANT_DOCS_PDF:BOOL=`"0`" -DWANT_OGG_VIDEO:BOOL=`"1`" -DWANT_POPUP_EXAMPLES:BOOL=`"1`" -DWANT_DOCS:BOOL=`"0`" -DWANT_AUDIO:BOOL=`"1`" -DWANT_ACODEC_DYNAMIC_LOAD:BOOL=`"1`" -DWANT_VIDEO:BOOL=`"0`" -DWANT_X11_XRANDR:BOOL=`"0`" -DWANT_GLES2:BOOL=`"1`" -DWANT_D3D:BOOL=`"1`" -DWANT_IMAGE_JPG:BOOL=`"1`" -DWANT_COLOR:BOOL=`"1`" -DSHARED:BOOL=`"1`" -DWANT_ANDROID:BOOL=`"0`" -DWANT_FFMPEG:BOOL=`"0`" -DWANT_PULSEAUDIO:BOOL=`"0`" -DWANT_TTF:BOOL=`"1`" -DWANT_FONT:BOOL=`"1`" -DWANT_MUDFLAP:BOOL=`"0`" -DWANT_NATIVE_DIALOG:BOOL=`"1`" -DWANT_PYTHON_WRAPPER:BOOL=`"0`" -DWANT_D3D9EX:BOOL=`"0`" -DWANT_TESTS:BOOL=`"1`" -DWANT_OPENGL:BOOL=`"1`" -DWANT_ALSA:BOOL=`"0`" -DWANT_X11_XINERAMA:BOOL=`"0`" -DWANT_SHADERS_D3D:BOOL=`"1`" -DNO_FPU:BOOL=`"0`" -DWANT_NATIVE_IMAGE_LOADER:BOOL=`"1`" -DSTRICT_WARN:BOOL=`"0`" -DCMAKE_GNUtoMS:BOOL=`"0`" -DWANT_X11_XF86VIDMODE:BOOL=`"0`" -DWANT_VORBIS:BOOL=`"1`" -DWANT_EXAMPLES:BOOL=`"1`" -DWANT_DOCS_PDF_PAPER:BOOL=`"0`" -DWANT_EMBED:BOOL=`"0`" -DWANT_DEMO:BOOL=`"1`" -DWANT_RELEASE_LOGGING:BOOL=`"0`" -DWANT_TREMOR:BOOL=`"0`" -DWANT_CURL_EXAMPLE:BOOL=`"0`" -DWANT_IMAGE_PNG:BOOL=`"1`" -DWANT_SHADERS_GL:BOOL=`"1`" -DWANT_OPENSL:BOOL=`"0`" -DWANT_X11:BOOL=`"0`" -DWANT_DOCS_MAN:BOOL=`"0`" -DALLEGRO_SDL:BOOL=`"0`"  .."
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append	
	
	$t1="mingw32-make.exe install"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="cd $AllegroSourceForgeDirSH/buildStatic"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	$t1="cmake -G`"MinGW Makefiles`" -DTARGET_ARCH:STRING=$ARCH -DCMAKE_LIBRARY_PATH:PATH=`"$MinGWInstallaDirSHcmake/lib;$MinGWInstallaDirSHcmake/$ARCH/lib`" -DCMAKE_INCLUDE_PATH:PATH=`"$MinGWInstallaDirSHcmake/include;$MinGWInstallaDirSHcmake/$ARCH/include`" -DCMAKE_C_COMPILER:FILEPATH=$MinGWInstallaDirSHcmake/bin/gcc.exe -DCMAKE_CXX_COMPILER:FILEPATH=$MinGWInstallaDirSHcmake/bin/g++.exe -DCMAKE_CXX_COMPILER_ENV_VAR:STRING=CXX -DCMAKE_C_COMPILER_ENV_VAR:STRING=CC -DCMAKE_MAKE_PROGRAM:FILEPATH=$MinGWInstallaDirSHcmake/bin/mingw32-make.exe -DCMAKE_INSTALL_PREFIX:PATH=$MinGWInstallaDirSHcmake -DWANT_MONOLITH:BOOL=`"1`" -DWANT_DLL_TLS:BOOL=`"0`" -DWANT_ANDROID_LEGACY:BOOL=`"0`" -DWANT_FLAC:BOOL=`"1`" -DWANT_DOCS_INFO:BOOL=`"0`" -DWANT_IMAGE:BOOL=`"1`" -DWANT_PRIMITIVES:BOOL=`"1`" -DWANT_OSS:BOOL=`"0`" -DWANT_MEMFILE:BOOL=`"1`" -DWANT_PHYSFS:BOOL=`"1`" -DWANT_AQUEUE:BOOL=`"0`" -DWANT_MODAUDIO:BOOL=`"1`" -DWANT_DSOUND:BOOL=`"0`" -DWANT_FRAMEWORKS:BOOL=`"0`" -DWANT_DOCS_HTML:BOOL=`"0`" -DWANT_OPENGL_S3TC_LOCKING:BOOL=`"0`" -DWANT_OPENAL:BOOL=`"1`" -DWANT_DOCS_PDF:BOOL=`"0`" -DWANT_OGG_VIDEO:BOOL=`"1`" -DWANT_POPUP_EXAMPLES:BOOL=`"1`" -DWANT_DOCS:BOOL=`"0`" -DWANT_AUDIO:BOOL=`"1`" -DWANT_ACODEC_DYNAMIC_LOAD:BOOL=`"1`" -DWANT_VIDEO:BOOL=`"0`" -DWANT_X11_XRANDR:BOOL=`"0`" -DWANT_GLES2:BOOL=`"1`" -DWANT_D3D:BOOL=`"1`" -DWANT_IMAGE_JPG:BOOL=`"1`" -DWANT_COLOR:BOOL=`"1`" -DSHARED:BOOL=`"0`" -DWANT_ANDROID:BOOL=`"0`" -DWANT_FFMPEG:BOOL=`"0`" -DWANT_PULSEAUDIO:BOOL=`"0`" -DWANT_TTF:BOOL=`"1`" -DWANT_FONT:BOOL=`"1`" -DWANT_MUDFLAP:BOOL=`"0`" -DWANT_NATIVE_DIALOG:BOOL=`"1`" -DWANT_PYTHON_WRAPPER:BOOL=`"0`" -DWANT_D3D9EX:BOOL=`"0`" -DWANT_TESTS:BOOL=`"1`" -DWANT_OPENGL:BOOL=`"1`" -DWANT_ALSA:BOOL=`"0`" -DWANT_X11_XINERAMA:BOOL=`"0`" -DWANT_SHADERS_D3D:BOOL=`"1`" -DNO_FPU:BOOL=`"0`" -DWANT_NATIVE_IMAGE_LOADER:BOOL=`"1`" -DSTRICT_WARN:BOOL=`"0`" -DCMAKE_GNUtoMS:BOOL=`"0`" -DWANT_X11_XF86VIDMODE:BOOL=`"0`" -DWANT_VORBIS:BOOL=`"1`" -DWANT_EXAMPLES:BOOL=`"1`" -DWANT_DOCS_PDF_PAPER:BOOL=`"0`" -DWANT_EMBED:BOOL=`"0`" -DWANT_DEMO:BOOL=`"1`" -DWANT_RELEASE_LOGGING:BOOL=`"0`" -DWANT_TREMOR:BOOL=`"0`" -DWANT_CURL_EXAMPLE:BOOL=`"0`" -DWANT_IMAGE_PNG:BOOL=`"1`" -DWANT_SHADERS_GL:BOOL=`"1`" -DWANT_OPENSL:BOOL=`"0`" -DWANT_X11:BOOL=`"0`" -DWANT_DOCS_MAN:BOOL=`"0`" -DALLEGRO_SDL:BOOL=`"0`"  .."
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append	
	
	$t1="mingw32-make.exe install"
	Write-Output $t1 | Out-File -encoding ASCII .\$MSYSScript -width 200 -append

	Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."

	Write-Host [$NCurrent/$N] Making Directory: $MSYSProfileDir
	if (!(Test-Path $MSYSProfileDir)){
		[void](new-item $MSYSProfileDir -itemType directory)
	}
	#Write-Host "Awaiting to build source due to (Ogg configuration...)"
	Move-Item .\$MSYSScript "$MSYSProfileDir\" -force
	& msys --login

}

pop-location


	<# 

	####################################
	#    #) CG Toolkit-bin
	# Needed for Nvidia GPGPU stuff
	# https://developer.nvidia.com/cg-toolkit
	####################################
	Write-Host
	$NCurrent += 1
 #>
<#
	#Word on the street is Windows has a LibJpeg and other silly things (as seen in other installers) are being skipped...
	
 	####################################
	#    #) LibJpeg
	# http://www.ijg.org/files/jpegsr9.zip
	# $LibJPEG = "LibJPEG"
	# Write-Host "[$NCurrent/$N] Creating LibJPEG Libary"
	# Write-Host "[$NCurrent/$N] `tMaking Directory: .\$LibJPEG"
	# $DestLibJPEG = ".\$LibJPEG"
	# # if folder does not exist...
	# if (!(Test-Path $DestLibJPEG)){
		# # create it
		# [void](new-item $LibJPEG -itemType directory)
	# }
	# cd $LibJPEG | out-null
	
	# $LibJPEGDL="http://www.ijg.org/files/jpegsr9.zip"
	# Write-Host "[$NCurrent/$N] `tDownloading: $LibJPEGDL ..."
	
	# (New-Object System.Net.WebClient).DownloadFile($LibJPEGDL,"$env:HOMEDRIVE$env:HOMEPATH\LibJPEG_src.zip")
	
	# Move-Item $env:HOMEDRIVE$env:HOMEPATH\LibJPEG_src.zip .
	# Write-Host "[$NCurrent/$N] `tExtracting the source..."
	# & unzip -q LibJPEG_src.zip
	# del LibJPEG_src.zip
	# cd jpeg-9
	# Write-Host "[$NCurrent/$N] `tCreating MSYS build shell script..."
	# $t1="#!/bin/sh"
	# Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200
	# $t1="cd ~/Allegro5.1/A5_Deps/LibJPEG/jpeg-9/"
	# Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200 -append
	# $t1="autoheader"
	# Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200 -append
	# #$t1="./configure --prefix=`"``echo ~/``Allegro5.1/A5_Deps`""
	# $t1="./configure --prefix=`"/c/mingw`""
	# Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200 -append
	# $t1="make"
	# Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200 -append
	# $t1="make install"
	# Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200 -append
	# #$t1="exit"
	# #Write-Output $t1 | Out-File -encoding ASCII .\LibJPEGcmd.sh -width 200 -append
	# Write-Host "[$NCurrent/$N] `tBuilding the source with Msys.bat --login ..."
	# $DestSh = "C:\MinGW\msys\1.0\etc\profile.d"
	# Write-Host [$NCurrent/$N] Making Directory: .\$DestSh
	# # if folder does not exist...
	# if (!(Test-Path $DestSh)){
		# # create it
		# [void](new-item $DestSh -itemType directory)
	# }
	# #$file = Get-Item "$DestSh"
	# #$file.Attributes = 'Hidden'
	# Move-Item .\LibJPEGcmd.sh "$DestSh\" -force
	# #copy $env:HOMEDRIVE$env:HOMEPATH\Allegro5.1\MinGW\msys\1.0\msys.bat .
	# cd ..\..\..\
	# & C:\MinGW\msys\1.0\msys --login
	####################################
	
	Write-Host
	$NCurrent += 1
 #>	
