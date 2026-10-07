<#
.SYNOPSIS
    Performs basic health checks on a Windows Server.

.DESCRIPTION
    Collects basic system information including:
    - Server name
    - Operating system
    - Last reboot
    - Uptime
    - Disk usage
    - Automatic services that are not running

.NOTES
    Project: PowerShell Server Health Toolkit
    Version: 1.0
#>

# Get basic operating system information
$OS = Get-CimInstance -ClassName Win32_OperatingSystem

# Calculate uptime
$LastBoot = $OS.LastBootUpTime
$Uptime = (Get-Date) - $LastBoot

# Display basic server information
Write-Host "========================================"
Write-Host "       SERVER HEALTH CHECK"
Write-Host "========================================"
Write-Host ""

Write-Host "Server Name : $env:COMPUTERNAME"
Write-Host "OS          : $($OS.Caption)"
Write-Host "Last Reboot : $LastBoot"
Write-Host "Uptime      : $($Uptime.Days) days, $($Uptime.Hours) hours"

Write-Host ""
Write-Host "DISK STATUS"
Write-Host "----------------------------------------"

Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" |
    Select-Object DeviceID,
        @{Name="SizeGB";Expression={[math]::Round($_.Size / 1GB,2)}},
        @{Name="FreeGB";Expression={[math]::Round($_.FreeSpace / 1GB,2)}},
        @{Name="FreePercent";Expression={[math]::Round(($_.FreeSpace / $_.Size) * 100,2)}} |
    Format-Table -AutoSize

Write-Host ""
Write-Host "AUTOMATIC SERVICES NOT RUNNING"
Write-Host "----------------------------------------"

$StoppedServices = Get-Service |
    Where-Object {
        $_.StartType -eq "Automatic" -and
        $_.Status -ne "Running"
    }

if ($StoppedServices) {
    $StoppedServices |
        Select-Object Name, DisplayName, Status |
        Format-Table -AutoSize
}
else {
    Write-Host "All automatic services are running."
}

Write-Host ""
Write-Host "Health check completed."
