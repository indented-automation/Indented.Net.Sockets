---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Disconnect-Socket

## SYNOPSIS
Disconnect a connected TCP socket.

## SYNTAX

```
Disconnect-Socket [-Socket] <Socket> [-Shutdown <Boolean>]
```

## DESCRIPTION
A TCP socket which has been connected using Connect-Socket may be disconnected using this CmdLet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$Socket = New-Socket
```

C:\PS\>$Socket | Connect-Socket -RemoteIPAddress 10.0.0.2 -RemotePort 25
C:\PS\>$Socket | Disconnect-Socket

## PARAMETERS

### -Socket
A socket created using New-Socket and connected using Connect-Socket.

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

### -Shutdown
By default, Disconnect-Socket attempts to shutdown the connection before disconnecting.
This behaviour can be overridden by setting this parameter to False.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Net.Sockets.Socket

## OUTPUTS

### None

## NOTES
Author: Chris Dent

Change log:
  17/03/2017 - Chris Dent - Modernisation pass.
  06/01/2014 - Chris Dent - Created.

## RELATED LINKS

