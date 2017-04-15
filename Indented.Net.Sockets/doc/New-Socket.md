---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# New-Socket

## SYNOPSIS
Creates a new network socket to use to send and receive packets over a network.

## SYNTAX

### ClientSocket (Default)
```
New-Socket [-ProtocolType <ProtocolType>] [-EnableBroadcast] [-IPv6] [-NoTimeout] [-ReceiveTimeOut <Int32>]
 [-SendTimeOut <Int32>]
```

### ServerSocket
```
New-Socket [-ProtocolType <ProtocolType>] [-LocalIPAddress <IPAddress>] -LocalPort <UInt16> [-IPv6]
 [-NoTimeout] [-ReceiveTimeOut <Int32>] [-SendTimeOut <Int32>]
```

## DESCRIPTION
New-Socket creates an instance of System.Net.Sockets.Socket for use with Send-Bytes and Receive-Bytes.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-Socket -LocalPort 25
```

Configure a socket to listen using TCP/25 (as a network server) on all locally configured IP addresses.

### -------------------------- EXAMPLE 2 --------------------------
```
New-Socket -ProtocolType Udp
```

Configure a socket for sending UDP datagrams (as a network client).

### -------------------------- EXAMPLE 3 --------------------------
```
New-Socket -LocalPort 23 -LocalIPAddress 10.0.0.1
```

Configure a socket to listen using TCP/23 (as a network server) on the IP address 10.0.0.1 (the IP address must exist and be bound to an interface).

## PARAMETERS

### -ProtocolType
ProtocolType must be either TCP or UDP.
This parameter also sets the SocketType to Stream for TCP and Datagram for UDP.

```yaml
Type: ProtocolType
Parameter Sets: (All)
Aliases: 
Accepted values: IPv6HopByHopOptions, IP, Unspecified, Icmp, Igmp, Ggp, IPv4, Tcp, Pup, Udp, Idp, IPv6, IPv6RoutingHeader, IPv6FragmentHeader, IPSecEncapsulatingSecurityPayload, IPSecAuthenticationHeader, IcmpV6, IPv6NoNextHeader, IPv6DestinationOptions, ND, Raw, Ipx, Spx, SpxII, Unknown

Required: False
Position: Named
Default value: Tcp
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocalIPAddress
If configuring a server port (to listen for requests) an IP address may be defined.
By default the Socket is created to listen on all available addresses.

```yaml
Type: IPAddress
Parameter Sets: ServerSocket
Aliases: 

Required: False
Position: Named
Default value: [IPAddress]::Any
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocalPort
If configuring a server port (to listen for requests) the local port number must be defined.

```yaml
Type: UInt16
Parameter Sets: ServerSocket
Aliases: 

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableBroadcast
Allows a UDP socket to send and receive datagrams from the directed or undirected broadcast IP address.

```yaml
Type: SwitchParameter
Parameter Sets: ClientSocket
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPv6
Use IPv6 as the transport.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoTimeout
By default, send and receive timeout values are set for all operations.
These values can be overridden to allow configuration of a socket which will never stop either attempting to send or attempting to receive.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReceiveTimeOut
A timeout for individual Receive operations performed with this socket.
The default value is 5 seconds; this command allows the value to be set between 1 and 30 seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendTimeOut
A timeout for individual Send operations performed with this socket.
The default value is 5 seconds; this command allows the value to be set between 1 and 30 seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Int32
System.Net.IPAddress
System.Net.Sockets.ProtocolType
System.UInt16

## OUTPUTS

### System.Net.Sockets.Socket

## NOTES
Author: Chris Dent

Change log:
  17/03/2017 - Chris Dent - Modernisation pass.
  25/11/2010 - Chris Dent - Created.

## RELATED LINKS

