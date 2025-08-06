param(
    [string]$action,
    [string]$siteName = "site33211"
)

$server = "site33211.siteasp.net"
$username = "site33211"
$password = "x?5AG4o#fR_2"

# Upload command file via FTP
function Send-IISCommand($command) {
    $tempFile = [System.IO.Path]::GetTempFileName()
    Set-Content $tempFile $command
    curl -T $tempFile ftp://$server/apppool-command.txt -u "$username`:$password" --ftp-create-dirs
    Remove-Item $tempFile
}

# Action logic
switch ($action) {
    "stop" { 
        Send-IISCommand "APPCMD stop apppool /apppool.name:`"$siteName`""
        Start-Sleep -Seconds 5
    }
    "start" { 
        Send-IISCommand "APPCMD start apppool /apppool.name:`"$siteName`"" 
        Start-Sleep -Seconds 5
    }
}