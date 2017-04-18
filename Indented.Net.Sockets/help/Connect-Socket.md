---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Connect-Socket

## SYNOPSIS
Connect a TCP socket to a remote IP address and port.

## SYNTAX

```
Connect-Socket [-Socket] <Socket> -RemoteIPAddress <IPAddress> -RemotePort <UInt16>
```

## DESCRIPTION
If a TCP socket is being used as a network client it must first connect to a server before Send-Bytes and Receive-Bytes can be used.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$Socket = New-Socket
```

C:\PS\> Connect-Socket $Socket -RemoteIPAddress 10.0.0.2 -RemotePort 25

## PARAMETERS

### -Socket
A socket created using New-Socket.

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
The remote IP address to connect to.

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases: IPAddress

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemotePort
The remote port to connect to.

```yaml
Type: UInt16
Parameter Sets: (All)
Aliases: Port

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Net.IPAddress
System.Net.Sockets.Socket
System.UInt16

## OUTPUTS

### System.Boolean

## NOTES
Change log:
  17/03/2017 - Chris Dent - Modernisation pass.
  06/01/2014 - Chris Dent - Created.

## RELATED LINKS

