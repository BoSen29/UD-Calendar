$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.UD-Calendar"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.map $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.UD-Calendar.psm1 $OutputPath
Copy-Item $BuildFolder\Scripts $OutputPath\Scripts -Recurse -Force

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.UD-Calendar.psd1"
	Author = "BoSen29"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.UD-Calendar.psm1"
	Description = "Calendar for UD"
	ModuleVersion = $Version
	Tags = @("universaldashboard")
	ReleaseNotes = "First edition"
	FunctionsToExport = @(
		"New-UDCalendar"
	)
}

New-ModuleManifest @manifestParameters

