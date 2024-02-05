Write-Host 'CRM Solution Export / Unpack Script
This script will remove any unrelated files within the working folder
===========================================================
This action is destructive.
Are you sure you want to continue? (Y/N)
==========================================================='
$check = Read-Host
if($check = "Y") {
	Write-Host 'What is the solution name? '
	$solutionName = Read-Host
	Write-Host 'Copying scripts to parent directory'
	Copy-Item -Path 'ExplodeSolution.ps1' -Destination '../ExplodeSolution.ps1'

	Write-Host 'Exporting Unmanaged'
	pac solution export --path './'+$solutionName+'.zip' --name $solutionName

	Write-Host 'Exporting Managed'
	pac solution export --path './'+$solutionName+'_managed.zip' --name $solutionName --managed


	Write-Host 'Unpacking Unmanaged'
	pac solution unpack --zipfile './'+$solutionName+'.zip' --packagetype 'both' -ad

	Write-Host 'Recreating PowerShell scripts'
	Move-Item -Path '../ExplodeSolution.ps1' -Destination './ExplodeSolution.ps1'

	Write-Host 'CRM Export / Unpack Complete'
} else {
	Write-Host 'Aborted'
}