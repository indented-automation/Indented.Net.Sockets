using namespace System.Net
using namespace System.Net.Sockets

function Connect-InSocket {
    # .SYNOPSIS
    #   Connect a TCP socket to a remote IP address and port.
    # .DESCRIPTION
    #   If a TCP socket is being used as a network client it must first connect to a server before Send-Bytes and Receive-Bytes can be used.
    # .INPUTS
    #   System.Net.IPAddress
    #   System.Net.Sockets.Socket
    #   System.UInt16
    # .OUTPUTS
    #   System.Boolean
    # .EXAMPLE
    #   C:\PS> $Socket = New-Socket
    #   C:\PS> Connect-Socket $Socket -RemoteIPAddress 10.0.0.2 -RemotePort 25
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     17/03/2017 - Chris Dent - Modernisation pass.
    #     06/01/2014 - Chris Dent - Created.

    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        # A socket created using New-Socket.
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [Socket]$Socket,

        # The remote IP address to connect to.
        [Parameter(Mandatory = $true)]
        [Alias('IPAddress')]
        [IPAddress]$RemoteIPAddress,

        # The remote port to connect to.
        [Parameter(Mandatory = $true)]
        [Alias('Port')]
        [UInt16]$RemotePort
    )

    process {
        if ($Socket.ProtocolType -ne [ProtocolType]::Tcp) {
            Write-Warning "The protocol type must be TCP to use Connect-Socket."
        } else {
            $remoteEndPoint = [EndPoint](New-Object IPEndPoint($RemoteIPAddress, $RemotePort))

            if ($Socket.Connected) {
                Write-Warning "Connect-Socket: The socket is connected to $($Socket.RemoteEndPoint). No action taken."
                return $true
            } else {
                $Socket.Connect($RemoteEndPoint)
            }
        }
    }
}