# PowerShell Server Health Toolkit

A collection of PowerShell scripts designed to automate common Windows Server health checks and administrative tasks.

## Features

- Server health checks
- Disk space monitoring
- Last reboot information
- Uptime monitoring
- Windows services status
- CSV reporting

## Available Scripts

### Get-ServerHealth.ps1

Performs basic health checks on a Windows Server.

The script collects:

- Server name
- Operating system information
- Last reboot time
- System uptime
- Local disk usage
- Automatic services that are not running

## Requirements

- Windows PowerShell 5.1 or later
- Windows Server 2019 / 2022 / 2025
- Appropriate administrative permissions

## Usage

Run PowerShell with the appropriate permissions and execute:

`.\Get-ServerHealth.ps1`

## Project Structure

`PowerShell-Server-Health-Toolkit/`
- `README.md`
- `scripts/`
  - `Get-ServerHealth.ps1`

## Roadmap

Planned improvements:

- CPU monitoring
- Memory monitoring
- Windows Update status
- Event Log analysis
- CSV export
- HTML reporting
- Remote server support
