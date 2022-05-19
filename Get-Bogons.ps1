#
# This script pulls the list of bogon networks from Team Cymru and formats them for standard and extended Cisco ACLs
#

function Get-Bogons {

    $results = (((((Invoke-WebRequest https://team-cymru.com/community-services/bogon-reference/bogon-dotted-decimal/).content -split "`n" | Select-String -Pattern "\d{1,3}(\.\d{1,3}){3}" | Select-String -Pattern " 2" -NotMatch | Sort-Object | Get-Unique) -split "<p>") -split "<br />") -split "</p>") | Select-String -Pattern "^$" -notmatch

    clear
    Write-Host "Cisco Standard ACL" -ForegroundColor Blue
    foreach ($i in $results) {
	   Write-Host "access-list 10 deny $i log"
    }

    Write-Host "Cisco Extended ACL" -ForegroundColor Blue
    foreach ($i in $results) {
        Write-Host "access-list 101 deny ip $i any log"
    }
}

Get-Bogons