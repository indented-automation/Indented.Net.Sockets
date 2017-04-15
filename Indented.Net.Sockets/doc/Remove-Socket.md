---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Remove-Socket

## SYNOPSIS
Removes a socket, releasing all resources.

## SYNTAX

```
Remove-Socket [-Socket] <Socket>
```

## DESCRIPTION
A socket may be removed using Remove-Socket if it is no longer required.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$Socket = New-Socket
```

C:\PS\> $Socket | Connect-Socket -RemoteIPAddress 10.0.0.2 -RemotePort 25
C:\PS\> $Socket | Disconnect-Socket
C:\PS\> $Socket | Remove-Socket

## PARAMETERS

### -Socket
A socket created using New-Socket.

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

## INPUTS

### System.Net.Sockets.Socket

## OUTPUTS

### None

## NOTES
Author: Chris Dent

Change log:
  17/03/2017 - Chris Dent - Modernisation pass.
  25/11/2010 - Chris Dent - Created.

## RELATED LINKS

