$a = Get-Content -ReadCount 0 -Encoding byte "C:\MoHFiles\soothingmusic.wma"

Set-CsCallParkServiceMusicOnHoldFile -Service ApplicationServer:pool0.litwareinc.com -Content $a