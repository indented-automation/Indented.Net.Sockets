---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Send-Bytes

## SYNOPSIS
Sends bytes using a TCP or UDP socket.

## SYNTAX

### DirectedTcpSend (Default)
```
Send-Bytes [-Socket] <Socket> -Data <Byte[]>
```

### DirectedUdpSend
```
Send-Bytes [-Socket] <Socket> -RemoteIPAddress <IPAddress> -RemotePort <UInt16> -Data <Byte[]>
```

### BroadcastUdpSend
```
Send-Bytes [-Socket] <Socket> [-Broadcast] -RemotePort <UInt16> -Data <Byte[]>
```

## DESCRIPTION
Send-Bytes is used to send outbound TCP or UDP packets as a server responding to a cilent, or as a client sending to a server.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$Socket = New-Socket
```

C:\PS\>Connect-Socket $Socket -RemoteIPAddress 10.0.0.1 -RemotePort 25
C:\PS\>Send-Bytes $Socket -Data 0

### -------------------------- EXAMPLE 2 --------------------------
```
$Socket = New-Socket -ProtocolType Udp -EnableBroadcast
```

C:\PS\>Send-Bytes $Socket -Data 0

## PARAMETERS

### -Socket
A socket created using New-Socket.
If the ProtocolType is TCP the socket must be connected first.

```yaml
Type: Socket
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RemoteIPAddress
If the protocol type is UDP a remote IP address must be specified.
Directed or undirected broadcast addresses may be used if EnableBroadcast has been set on the socket.

```yaml
Type: IPAddress
Parameter Sets: DirectedUdpSend
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Broadcast
Sets the RemoteIPAddress to the undirected broadcast address.

```yaml
Type: SwitchParameter
Parameter Sets: BroadcastUdpSend
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemotePort
If the protocol type is UDP, a remote port must be specified.

```yaml
Type: UInt16
Parameter Sets: DirectedUdpSend, BroadcastUdpSend
Aliases: 

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Data
The data to send (as a byte array).

```yaml
Type: Byte[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Net.Sockets.Socket
System.UInt32

## OUTPUTS

### None

## NOTES
Author: Chris Dent

Change log:
  25/11/2010 - Chris Dent - Created.

## RELATED LINKS

