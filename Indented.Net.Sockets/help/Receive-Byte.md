---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Receive-Byte

## SYNOPSIS
Receive bytes using a TCP or UDP socket.

## SYNTAX

```
Receive-Byte [-Socket] <Socket> [[-BufferSize] <UInt32>]
```

## DESCRIPTION
Receive-Bytes is used to accept inbound TCP or UDP packets as a client exepcting a response from a server, or as a server waiting for incoming connections.

Receive-Bytes will listen for bytes sent to broadcast addresses provided the socket has been created using EnableBroadcast.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$Socket = New-Socket
```

C:\PS\> Connect-Socket $Socket -RemoteIPAddress 10.0.0.1 -RemotePort 25
C:\PS\> $Bytes = Receive-Bytes $Socket
C:\PS\> $Bytes | ConvertTo-String

### -------------------------- EXAMPLE 2 --------------------------
```
$Socket = New-Socket -ProtocolType Udp -EnableBroadcast
```

C:\PS\> $Socket | Receive-Bytes

## PARAMETERS

### -Socket
A socket created using New-Socket.
If the ProtocolType is TCP the socket must be connected first.

```yaml
Type: Socket
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -BufferSize
The maximum buffer size used for each receive operation.

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: 1024
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Net.Sockets.Socket

## OUTPUTS

### Indented.Net.Sockets.SocketResponse

## NOTES
Change log:
  17/03/2017 - Chris Dent - Modernisation pass.
  25/11/2010 - Chris Dent - Created.

## RELATED LINKS

