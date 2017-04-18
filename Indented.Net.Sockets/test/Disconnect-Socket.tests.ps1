InModuleScope Indented.Net.Sockets {
    Describe Disconnect-Socket {
        Mock Write-Warning

        Context 'Valid TCP socket' {
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

            It 'Disconnects a TCP connection to a IP and port' {
                { Disconnect-Socket -Socket $socket -ErrorAction Stop } | Should -Not -Throw
                $socket.Connected | Should -Be $false
            }

            It 'Does not call disconnect if the socket is already disconnnected' {
                $socket.Connected | Should -Be $true
                $socket.Close()
                $socket.Connected | Should -Be $false
                { Disconnect-Socket -Socket $socket -ErrorAction Stop } | Should -Not -Throw
                Assert-MockCalled Write-Warning -Times 1 -Exactly -Scope It
                $socket.Connected | Should -Be $false
            }
        }

        Context 'Protocol type is not TCP' {
            BeforeEach {
                $socket = New-Object System.Net.Sockets.Socket('Dgram', 'Udp')
            }

            It 'Throws an error if the protocol type is UDP' {
                { Disconnect-Socket -Socket $socket -ErrorAction Stop } | Should -Throw -ErrorId InvalidProtocol
            }
        }
    }
}