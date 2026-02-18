# Path to a csv file with 2 Colunns "OLD" and "NEW" with correct mapping
#     OLD		   NEW
# js2_button14 js2_button15
#
$csvMapping   = ".\mapping.csv"

# Path to file the star citizen input file (old mapping)
$inputFile = ".\layout_vpc46_exported.xml"

# new star citizen input xml file to create (new mapping)
$outputFile = ".\layout_vpc46_new.xml"

# Load mapping
$mapping = Import-Csv -Path $csvMapping
$found = 0
$linenumber = 0
# Create output file fresh
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
