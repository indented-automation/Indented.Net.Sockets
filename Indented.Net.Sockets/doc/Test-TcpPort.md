---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Test-TcpPort

## SYNOPSIS
Test a TCP Port using System.Net.Sockets.TcpClient.

## SYNTAX

```
Test-TcpPort [-ComputerName] <String> [-Port] <UInt16>
```

## DESCRIPTION
Test-TcpPort establishes a TCP connection to the sepecified port then immediately closes the connection, returning whether or not the connection succeeded.

This function fully opens TCP connections (3-way handshake), it does not half-open connections.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Test-TcpPort 10.0.0.1 3389
```

Opens a TCP connection to 10.0.0.1 using port 3389.

## PARAMETERS

### -ComputerName
An host name or IP address for the target system.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
The port number to connect to (between 1 and 655535).

```yaml
Type: UInt16
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String
System.UInt16

## OUTPUTS

### System.Boolean

## NOTES
Author: Chris Dent

Change log:
  17/03/2017 - Chris Dent - Modernisation pass.
  25/11/2010 - Chris Dent - Created.

## RELATED LINKS

