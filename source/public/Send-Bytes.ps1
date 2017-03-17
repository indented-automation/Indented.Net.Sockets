using namespace System.Management.Automation
using namespace System.Net
using namespace System.Net.Sockets

function Send-Bytes {
    # .SYNOPSIS
    #   Sends bytes using a TCP or UDP socket.
    # .DESCRIPTION
    #   Send-Bytes is used to send outbound TCP or UDP packets as a server responding to a cilent, or as a client sending to a server.
    # .PARAMETER Broadcast
    #   Sets the RemoteIPAddress to the undirected broadcast address.
    # .PARAMETER RemoteIPAddress
    #   If the Protocol Type is UDP a remote IP address must be defined. Directed or undirected broadcast addresses may be used if EnableBroadcast has been set on the socket.
    # .PARAMETER Socket
    #   A socket created using New-Socket. If the ProtocolType is TCP the socket must be connected first.
    # .INPUTS
    #   System.Net.Sockets.Socket
    #   System.UInt32
    # .EXAMPLE
    #   C:\PS>$Socket = New-Socket
    #   C:\PS>Connect-Socket $Socket -RemoteIPAddress 10.0.0.1 -RemotePort 25
    #   C:\PS>Send-Bytes $Socket -Data 0
    # .EXAMPLE
    #   C:\PS>$Socket = New-Socket -ProtocolType Udp -EnableBroadcast
    #   C:\PS>Send-Bytes $Socket -Data 0
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     25/11/2010 - Chris Dent - Created.

    [CmdletBinding(DefaultParameterSetName = 'DirectedTcpSend')]
    param(
        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [Socket]$Socket,

        [Parameter(Mandatory = $true, ParameterSetName = 'DirectedUdpSend')]
        [IPAddress]$RemoteIPAddress,

        [Parameter(Mandatory = $true, ParameterSetName = 'BroadcastUdpSend')]
        [Switch]$Broadcast,

        [Parameter(Mandatory = $true, ParameterSetname = 'DirectedUdpSend')]
        [Parameter(Mandatory = $true, ParameterSetName = 'BroadcastUdpSend')]
        [UInt16]$RemotePort,

        [Parameter(Mandatory = $true)]
        [Byte[]]$Data
    )

    # Broadcast parameter set checking
    if ($pscmdlet.ParameterSetName -eq 'BroadcastUdpSend') {
        # IPv6 error checking
        if ($Socket.AddressFamily -eq [AddressFamily]::InterNetworkv6) {
            $errorRecord = New-Object ErrorRecord(
                (New-Object ArgumentException "EnableBroadcast cannot be set for IPv6 sockets."),
                "ArgumentException",
                [ErrorCategory]::InvalidArgument,
                $Socket
            )
        }

        # TCP socket error checking
        if (-not $Socket.ProtocolType) {
            $errorRecord = New-Object ErrorRecord(
                (New-Object ArgumentException "EnableBroadcast cannot be set for TCP sockets."),
                "ArgumentException",
                [ErrorCategory]::InvalidArgument,
                $Socket
            )
        }

        # Broadcast flag checking
        if (-not $Socket.EnableBroadcast) {
            $errorRecord = New-Object ErrorRecord(
                (New-Object InvalidOperationException "EnableBroadcast is not set on the socket."),
                "InvalidOperation",
                [ErrorCategory]::InvalidOperation,
                $Socket
            )
        }
        if ($errorRecord) {
            $pscmdlet.ThrowTerminatingError($errorRecord)
        }

        $RemoteIPAddress = [IPAddress]::Broadcast
    }

    switch ($Socket.ProtocolType) {
        ([ProtocolType]::Tcp) {
            $Socket.Send($Data) | Out-Null
        }
        ([ProtocolType]::Udp) {
            $remoteEndPoint = [EndPoint](New-Object IPEndPoint($RemoteIPAddress, $RemotePort))

            $Socket.SendTo($Data, $RemoteEndPoint) | Out-Null
        }
    }
}