InModuleScope Indented.Net.Sockets {
    Describe Remove-Socket {
        BeforeEach {
            $remoteIPAddress =  [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces() |
                Where-Object { $_.OperationalStatus -eq 'Up' -and $_.NetworkInterfaceType -match 'Ethernet|Wireless' } |
                ForEach-Object -MemberName GetIPProperties |
                Select-Object -ExpandProperty DnsAddresses -Unique |
                Where-Object AddressFamily -eq 'InterNetwork' |
                Select-Object -First 1

            $socket = New-Object System.Net.Sockets.Socket('Stream', 'Tcp')
            $socket.Connect($remoteIPAddress, 53)
        }

        It 'Closes an open socket' {
            $socket.Connected | Should -Be $true
            Remove-Socket $socket
            $socket.Connected | Should -Be $false
        }
    }
}