$url = "https://team-cymru.org/Services/Bogons/fullbogons-ipv4.txt"
$response = Invoke-WebRequest -Uri $url
$responseText = $response.Content -split "`n" | Where-Object { $_ -notlike "#*" -and $_ -ne "" }
Write-Output $responseText
