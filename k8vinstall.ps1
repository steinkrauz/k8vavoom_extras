#Requires -Version 7.0
<#
    .SYNOPSIS
        Copies K8Vavoom.exe and all the needed files to the installation directory
    
    .DESCRIPTION  

    .NOTES
    	This Powershell script is intended to automate creation of k8vavoom installation and meant to run from the directory where k8vavoom was built. It's recommened to separate build and sources directories.

	Copyright © 2000 Stein Krauz <steinkrauz@yahoo.com>
	This work is free. You can redistribute it and/or modify it under the terms of the Do What The Fuck You Want To Public License, Version 2, as published by Sam Hocevar. See http://www.wtfpl.net/ for more details. 

    .LINK
	http://ketmar.no-ip.org/fossil/k8vavoom/index.cgi/wiki?name=winbuild&p
        
    .Parameter sources
        The full path to the cloned repository. This parameter is mandatory.

    .Parameter tgtdir
    	Full path to the install directory. This parameter is mandatory

    .Parameter srcdir
        Optional path to build directory. The default value is the current directory
       
#>

param(
	[Parameter(Mandatory = $true)]
	[string]$sources, 
	[Parameter(Mandatory = $true)]
	[string]$tgtdir, 
	[string]$srcdir = (pwd).Path 
)

if (($sources -eq $null) -or ($tgtdir -eq $null)) {
    write-host "Usage: k8vinstall -sources <sources dir> -tgtdir <install dir>\n"
    exit
}

Function Copy-ByType() 
{
  param($cp_src, $cp_tgt, $cp_type)

  $cp_srclen = $cp_src.length
  Get-ChildItem $cp_src -Recurse -Include $cp_type | % {
    $file = $_
    $subdir=Join-Path $cp_tgt ($file.DirectoryName).Substring($cp_srclen)
    New-Item -ItemType Directory -Force $subdir 
    Copy-Item -Path $file -Destination $subdir -Force
  }
   
}


New-Item $tgtdir -ItemType Directory -Force

Copy-Item k8vavoom.exe $tgtdir

$sharedir = (Join-Path $tgtdir share)

New-Item $sharedir -ItemType Directory -Force


$basev = Join-Path $srcdir basev
$srcbasev = Join-Path $sources basev
$tgtbasev = Join-Path $sharedir basev

Copy-ByType $basev $tgtbasev "*.pk3"
Copy-ByType $srcbasev $tgtbasev @('games.txt', 'detectors.txt')

$tgtdocs = Join-Path $sharedir docs
New-Item $tgtdocs -ItemType Directory -Force

Copy-Item (Join-Path $sources docs code_of_conduct.txt) -Destination $tgtdocs -Force
Copy-Item (Join-Path $sources dox_vavoomc vavoomc.txt) -Destination $tgtdocs -Force
Copy-Item (Join-Path $sources Readme) -Destination $tgtdocs -Force
Copy-Item (Join-Path $sources docs k8vavoom.txt) -Destination $sharedir -Force
Copy-Item (Join-Path $sources res k8vavoom.png) -Destination $sharedir -Force

Get-ChildItem -Path $sharedir -Include CMakeFiles -Recurse -force | Remove-Item -Force -Recurse

$ico = (Join-Path $sources res ico )
$icons = (Join-Path $sharedir icons)
Copy-ByType $ico $icons *.ico
