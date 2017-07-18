#Powershell Script to cleanup disabled accounts from AD and move to a centralized disabled OU
#Created by Charles Weber 7/18/2017

#Variables to Edit#
$searchfordisabledaccounts = 'ou=employees,dc=domain,dc=local' #Can be specific OU's or the entire directory
$centraldisabled = 'ou=employee,ou=disabled accounts,dc=domain,dc=local' #should be a specific OU/location
$users = Get-ADUser -filter * -SearchBase $centraldisabled


Get-aduser -Filter {(Enabled -eq $false) -and (GivenName -notlike '_*')} -SearchBase $searchfordisabledaccounts | Move-ADObject -TargetPath $centraldisabled -WhatIf 
#Delete or Comment "#" -Whatif when ready to run the script

#Comment out if you do not want to remove disabled accounts from their associated AD group membership
Get-ADGroup -Filter * | Remove-ADGroupMember -Members $users -Confirm:$false
