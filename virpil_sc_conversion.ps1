<# 
.SYNOPSIS
    This script is a powershell script that will from a star citizen XML input file convert all input assignement (from VPC configuration tool)
	to the new input assignement set by virpil control configuration (alpha 0.1.0.0)
	A new file will be created after input conversion

.DESCRIPTION
    This script 
	into a new mapping file.
	The script support following configuration (default virpil input configuration)
			Virpil Alpha prime joystick
			MongoosT-50CM2/3 Throttle
			MongoosT-50CM2/3 Throttle in 5 mode selection
	        MongoosT-50CM2/3 Throttle in 5 mode selection (master) with virpil control panel 2 (slave).
	
	You will need to edit value for $inputFile and $outputFile to your need (line 29 & 32)
	

.EXAMPLE
    .\virpil_sc_conversion.ps1  from powershell terminal
	or powershell.exe -ep bypass -file "x:\xxx\virpil_sc_conversion.ps1" from a cmd terminal.

        Launch the script
    1.1     20.02.2025  Add choice selection
						Add user selection for js devic number use by the device in star citizen
						Add support for MongoosT-50CM2/3 Throttle
    1.0     18.02.2025  First version
.LINK
    https://github.com/Choum28/
 #>

# Path to file the star citizen input file (old mapping)
$inputFile = ".\layout_vpc46_exported.xml"

# new star citizen input xml file to create (new mapping)
$outputFile = ".\layout_vpc46_new.xml"

$found = 0
$linenumber = 0
$loop=1
$device = @()

function add-Device { 
    param(
        [string]$csv,
        [string]$jsnumber
		)
		$d = @{
			csv = $csv
			jsnumber = $jsnumber
		}
		return $d
}

Function Jsnumberchoice{
	$userInput = Read-Host "Which Js Number this device use in star citizen ?
	1. js1
	2. js2
	3. js3
	4. js4
	5. js5
	6. js6
	7. js7
	8. js8"

	switch ($userInput) {
			"1" { $jsnumber = "js1_"}
			"2" { $jsnumber = "js2_"}
			"3" { $jsnumber = "js3_"}
			"4" { $jsnumber = "js4_"}
			"5" { $jsnumber = "js5_"}
			"6" { $jsnumber = "js6_"}
			"7" { $jsnumber = "js7_"}
			"8" { $jsnumber = "js8_"}
			Default { Write-Host "Incorrect choice exiting"
						exit		}
		}
		return $jsnumber
}


While ($loop -ne 0) {
	cls
$userInput = Read-Host "Which virpil device configuration do you use ?
You will be able to select multiple device (one at a time)

1. Alpha Prime joystick
2. Throttle CM2/3 1 mode selection
3. Throttle CM2/3 5 mode selection
4. Throttle CM2/3 5 mode selection + slave Control Panel 2
0. I have finish to select devices.
"

	switch ($userInput) {
		
		"1" { $jsnumber = Jsnumberchoice
		$device+=add-Device -csv "Const_alpha_prime.csv" -jsNumber $jsnumber
		
		}
		"2" { $jsnumber = Jsnumberchoice
		$device+=add-Device -csv "ThrottleCM2-3.csv" -jsNumber $jsnumber
		
		}
		"3" { $jsnumber = Jsnumberchoice
		$device+=add-Device -csv "ThrottleCM2-3_5m.csv" -jsNumber $jsnumber
		
		}
		"4" { $jsnumber = Jsnumberchoice
		$device+=add-Device -csv "ThrottleCM2-3_5m_SlaveCP2.csv" -jsNumber $jsnumber
		
		}
		"0" { $loop = 0}
		Default { Write-Host "Select a valid choice, press 0 to end" }
	}
}


foreach ($virpil in $device) {
	$mapping += Import-Csv -Path $virpil.csv | ForEach-Object {
		foreach ($line in $_.PSObject.Properties) {
			$prefix = $virpil.jsNumber
			$line.Value = "$prefix$($line.Value)"
		}
		$_
	}
}
#for debug
#$mapping | Out-GridView


#Create output file fresh
if (Test-Path $outputFile) { Remove-Item $outputFile }

# Process source file line by line
Get-Content $inputFile | ForEach-Object {
    $line = $_
	$linenumber = $linenumber +1
	foreach ($row in $mapping) {
		$old = $row.OLD + '"'
		$new = $row.NEW + '"'
		if ($line -match $old) {
			$found =1
			Add-Content -Path $outputFile -Value ($line -replace $old, $new)
			$line = $_
			Write-host "Line $linenumber old value: $old new value: $new"
		}
    }
	if ($found -eq 0) {
		Add-Content -Path $outputFile -Value $line
	}
	$found = 0
}
Write-Host "File $outputFile created"
 #> #>