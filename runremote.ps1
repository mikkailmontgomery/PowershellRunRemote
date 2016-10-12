#DOTO - add AD OU dump and selection functionality
# -ADSelection
#TODO - Add params
#TODO - Add array of pcs
-Targets server1,server2,etc
#TODO - Add ability to remove pcs from array right before running command
#TODO -CompName server1 param
#TODO ad searchbase DC= filed in non static(portability)
Import-module activedirectory
$command = "diskperf -Y"
#$CompName = "server1.example.com"
$cred = get-credential
if (Get-Variable CompName -Scope Global -ErrorAction SilentlyContinue) {
$output = "Starting: {" + $command + "} on " + $CompName
Write-Output $output
#$process = get-wmiobject -query "SELECT * FROM Meta_Class WHERE __Class = 'Win32_Process'" -namespace "root\cimv2" -computername $CompName -credential $cred
#$results = $process.Create( $command )
} else {
$C=get-adcomputer -filter * -searchbase "ou=Computers,dc=example,dc=com"| ForEach-Object {$_.Name}
Write-Output $C
foreach($CompName in $C){
$output = "Starting: {" + $command + "} on " + $CompName
Write-Output $output
$process = get-wmiobject -query "SELECT * FROM Meta_Class WHERE __Class = 'Win32_Process'" -namespace "root\cimv2" -computername $CompName -credential $cred
$results = $process.Create( $command )
write-output $results
}
}
