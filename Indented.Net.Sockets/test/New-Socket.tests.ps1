InModuleScope Indented.Net.Sockets {
    Describe New-Socket {
        Context 'TCP socket' {
            It 'Creates IPv4 TCP sockets' {
                $socket = New-Socket
                $socket | Should -BeOfType [System.Net.Sockets.Socket]
                $socket.ProtocolType | Should -Be ([System.Net.Sockets.ProtocolType]::Tcp)
                $socket.SocketType | Should -Be ([System.Net.Sockets.SocketType]::Stream)
                $socket.AddressFamily | Should -Be ([System.Net.Sockets.AddressFamily]::InterNetwork)
            }

            It 'Creates IPv6 TCP sockets' {
                $socket = New-Socket -IPv6
                $socket | Should -BeOfType [System.Net.Sockets.Socket]
                $socket.ProtocolType | Should -Be ([System.Net.Sockets.ProtocolType]::Tcp)
                $socket.SocketType | Should -Be ([System.Net.Sockets.SocketType]::Stream)
                $socket.AddressFamily | Should -Be ([System.Net.Sockets.AddressFamily]::InterNetworkV6)
            }
        }

        Context 'UDP socket' {
            It 'Creates IPv4 UDP sockets' {
                $socket = New-Socket -ProtocolType UDP
                $socket | Should -BeOfType [System.Net.Sockets.Socket]
                $socket.ProtocolType | Should -Be ([System.Net.Sockets.ProtocolType]::Udp)
                $socket.SocketType | Should -Be ([System.Net.Sockets.SocketType]::Dgram)
                $socket.AddressFamily | Should -Be ([System.Net.Sockets.AddressFamily]::InterNetwork)
            }

            It 'Creates IPv6 UDP sockets' {
                $socket = New-Socket -ProtocolType UDP -IPv6
                $socket | Should -BeOfType [System.Net.Sockets.Socket]
                $socket.ProtocolType | Should -Be ([System.Net.Sockets.ProtocolType]::Udp)
                $socket.SocketType | Should -Be ([System.Net.Sockets.SocketType]::Dgram)
                $socket.AddressFamily | Should -Be ([System.Net.Sockets.AddressFamily]::InterNetworkV6)
            }            
        }

        Context 'Listening socket' {
            It 'Creates a listening TCP socket' {
                try {
                    $socket = New-Socket -LocalPort 45000
                    $socket.LocalEndPoint.Address | Should -Be ([IPAddress]::Any)
                    $socket.LocalEndPoint.Port | Should -Be 45000
                    $socket.IsBound | Should -Be $true

                    $tcpListener = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().GetActiveTcpListeners() |
                        Where-Object Port -eq 45000

                    $tcpListener | Should -Not -BeNullOrEmpty
                    $tcpListener.Address | Should -Be ([IPAddress]::Any)
                } catch {
                    throw
                } finally {
                    if ($socket -and $socket.IsBound) {
                        $socket.Close()
                        $socket.Dispose()
                    }
                }
            }

            It 'Creates a listening IPv6 TCP socket' {
                try {
                    $socket = New-Socket -LocalPort 45000 -IPv6
                    $socket.LocalEndPoint.Address | Should -Be ([IPAddress]::IPv6Any)
                    $socket.LocalEndPoint.Port | Should -Be 45000
                    $socket.IsBound | Should -Be $true

                    $tcpListener = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().GetActiveTcpListeners() |
                        Where-Object Port -eq 45000

                    $tcpListener | Should -Not -BeNullOrEmpty
                    $tcpListener.Address | Should -Be ([IPAddress]::IPv6Any)
                } catch {
                    throw
                } finally {
                    if ($socket -and $socket.IsBound) {
                        $socket.Close()
                        $socket.Dispose()
                    }
                }
            }

            It 'Creates a listening UDP socket' {
                try {
                    $socket = New-Socket -ProtocolType UDP -LocalPort 45000
                    $socket.LocalEndPoint.Address | Should -Be ([IPAddress]::Any)
                    $socket.LocalEndPoint.Port | Should -Be 45000
                    $socket.IsBound | Should -Be $true

                    $udpListener = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().GetActiveUdpListeners() |
                        Where-Object Port -eq 45000

                    $udpListener | Should -Not -BeNullOrEmpty
                    $udpListener.Address | Should -Be ([IPAddress]::Any)
                } catch {
                    throw
                } finally {
                    if ($socket -and $socket.IsBound) {
                        $socket.Close()
                        $socket.Dispose()
                    }
                }
            }

            It 'Creates a listening IPv6 UDP socket' {
                try {
                    $socket = New-Socket -ProtocolType UDP -LocalPort 45000 -IPv6
                    $socket.LocalEndPoint.Address | Should -Be ([IPAddress]::IPv6Any)
                    $socket.LocalEndPoint.Port | Should -Be 45000
                    $socket.IsBound | Should -Be $true

                    $udpListener = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().GetActiveUdpListeners() |
                        Where-Object Port -eq 45000

                    $udpListener | Should -Not -BeNullOrEmpty
                    $udpListener.Address | Should -Be ([IPAddress]::IPv6Any)
                } catch {
                    throw
                } finally {
                    if ($socket -and $socket.IsBound) {
                        $socket.Close()
                        $socket.Dispose()
                    }
                }
            }
        }

        Context 'Broadcast socket' {
            It 'Creates a UDP socket capable of working with broadcast messages' {
                $socket = New-Socket -ProtocolType UDP -EnableBroadcast
                $socket.EnableBroadcast | Should -be $true
            }

            It 'Throws an error if an attempt is made to create a TCP socket with a broadcast flag' {
                { New-Socket -EnableBroadcast } | Should -Throw -ErrorId 'CannotSetEnableBroadcastForTcp'
            }
        }
    }
}