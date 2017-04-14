function Test-TcpPort {
    # .SYNOPSIS
    #   Test a TCP Port using System.Net.Sockets.TcpClient.
    # .DESCRIPTION
    #   Test-TcpPort establishes a TCP connection to the sepecified port then immediately closes the connection, returning whether or not the connection succeeded.
    #       
    #   This function fully opens TCP connections (3-way handshake), it does not half-open connections.
    # .PARAMETER ComputerName
    #   An host name or IP address for the target system.
    # .PARAMETER Port
    #   The port number to connect to (between 1 and 655535).
    # .INPUTS
    #   System.String
    #   System.UInt16
    # .OUTPUTS
    #   System.Boolean
    # .EXAMPLE
    #   Test-TcpPort 10.0.0.1 3389
    #
    #   Opens a TCP connection to 10.0.0.1 using port 3389.
    # .NOTES
    #   Author: Chris Dent
    #
    #   Change log:
    #     17/03/2017 - Chris Dent - Modernisation pass.
    #     25/11/2010 - Chris Dent - Created.

    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        [Parameter(Mandatory = $true)]
        [String]$ComputerName,

        [Parameter(Mandatory = $true)]
        [UInt16]$Port
    )

    try {
        $tcpClient = New-Object TcpClient
        $tcpClient.Connect($ComputerName, $Port)
        $tcpClient.Close()

        return $true
    } catch {
        Write-Verbose $_.Exception.Message

        return $false
    }
}