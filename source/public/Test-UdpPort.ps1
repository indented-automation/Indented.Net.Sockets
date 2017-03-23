using namespace System.Net
using namespace System.Net.Sockets

function Test-UdpPort {
    # .SYNOPSIS
    #   Attempt to whether a UDP port is willing to receive packets.
    # .DESCRIPTION
    #   Test-UdpPort has a number of limitations due to the nature of UDP:
    #
    #     * UDP is a connectionless protocol, reciept of the packet by the target cannot be guaranteed (or tested remotely).
    #     * The remote server may elect to ignore the packet even if it has been received.
    #
    # .INPUTS
    #   System.String
    #   System.UInt16
    # .OUTPUTS
    #   System.Boolean
    # .EXAMPLE
    #   Test-UdpPort 10.0.0.1 1001
    #
    #   Send a single-byte packet to the UDP service running on port 1001 on the remote server.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     17/03/2017 - Chris Dent - Modernisation pass.
    #     09/01/2015 - Chris Dent - Created.

    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        # A host name or IP address for the target system.
        [Parameter(Mandatory = $true)]
        [String]$ComputerName,

        # The port number to connect to (between 1 and 655535).
        [Parameter(Mandatory = $true)]
        [UInt16]$Port
    )

    try {
        # Set up a socket with a 5 second receive timeout.
        $udpClient = New-Object UdpClient
        $udpClient.Client.ReceiveTimeout = 5000
        # Send one byte
        $bytesSent = $udpClient.Send(1, 1, $ComputerName, $Port)
        $remoteIPEndPoint = New-Object IPEndPoint
        
        $bytes = $udpClient.Receive([Ref]$remoteIPEndPoint)

    } catch {
        Write-Verbose $_.Exception.Message
        
        return $false
    }
    return $true
}