InModuleScope Indented.Net.Sockets {
    Describe Connect-Socket {
        Mock Write-Verbose

        Context 'Valid TCP socket' {
            BeforeEach {
                $remoteIPAddress =  [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces() |
                    Where-Object { $_.OperationalStatus -eq 'Up' -and $_.NetworkInterfaceType -match 'Ethernet|Wireless' } |
                    ForEach-Object -MemberName GetIPProperties |
                    Select-Object -ExpandProperty DnsAddresses -Unique |
                    Where-Object AddressFamily -eq 'InterNetwork' |
                    Select-Object -First 1

                $socket = New-Object System.Net.Sockets.Socket('Stream', 'Tcp')
            }

            AfterEach {
                $socket.Close()
                $socket.Dispose()
            }

            It 'Connects to a an IP and port' {
                { Connect-Socket -Socket $socket -RemoteIPAddress $remoteIPAddress -RemotePort 53 -ErrorAction Stop } | Should -Not -Throw
                $socket.Connected | Should -Be $true
            }

            It 'Does not call connect if the socket is already connected' {
                $socket.Connect($remoteIPAddress, 53)
                $socket.Connected | Should -Be $true
                { Connect-Socket -Socket $socket -RemoteIPAddress $remoteIPAddress -RemotePort 53 -ErrorAction Stop } | Should -Not -Throw
                Assert-MockCalled Write-Verbose -Times 1 -Exactly -Scope It
                $socket.Connected | Should -Be $true
            }
        }

        Context 'Protocol type is not TCP' {
            BeforeEach {
                $socket = New-Object System.Net.Sockets.Socket('Dgram', 'Udp')
            }

            It 'Throws an error and returns false if the protocol type is UDP' {
                { Connect-Socket -Socket $socket -RemoteIPAddress '127.0.0.1' -RemotePort 45000 -ErrorAction Stop } | Should -Throw -ErrorId InvalidProtocol
                Connect-Socket -Socket $socket -RemoteIPAddress '127.0.0.1' -RemotePort 45000 -ErrorAction SilentlyContinue | Should -Be $false
            }
        }

        Context 'Connect failed' {
            BeforeEach {
                $socket = New-Object System.Net.Sockets.Socket('Stream', 'Tcp')
            }

            It 'Throws an error and returns false if the connection fails' {
                { Connect-Socket -Socket $socket -RemoteIPAddress '127.0.0.1' -RemotePort 46000 -ErrorAction Stop } | Should -Throw
                Connect-Socket -Socket $socket -RemoteIPAddress '127.0.0.1' -RemotePort 46000 -ErrorAction SilentlyContinue | Should -Be $false
            }
        }
    }
}