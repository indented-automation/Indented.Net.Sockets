#
# Indented.Net.Sockets
#
# Version:   $version$
# Changeset: $sha$
#
# Change log:
#   12/12/2015 - Chris Dent - Refactored / recreated.

Set-StrictMode -Version Latest

#
# Public
#

[Array]$Public = 'Connect-Socket',
                 'Disconnect-Socket',
                 'New-Socket',
                 'Receive-Bytes',
                 'Remove-Socket',
                 'Send-Bytes',
                 'Test-TcpPort',
                 'Test-UdpPort'

if ($Public.Count -ge 1) {
  $Public | ForEach-Object {
    Import-Module "$psscriptroot\functions\$_.ps1" 
  }
}