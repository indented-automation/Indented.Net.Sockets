---
external help file: Indented.Net.Sockets-help.xml
online version: 
schema: 2.0.0
---

# Test-UdpPort

## SYNOPSIS
Attempt to whether a UDP port is willing to receive packets.

## SYNTAX

```
Test-UdpPort [-ComputerName] <String> [-Port] <UInt16>
```

## DESCRIPTION
Test-UdpPort has a number of limitations due to the nature of UDP:

  * UDP is a connectionless protocol, reciept of the packet by the target cannot be guaranteed (or tested remotely).
  * The remote server may elect to ignore the packet even if it has been received.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Test-UdpPort 10.0.0.1 1001
```

Send a single-byte packet to the UDP service running on port 1001 on the remote server.

## PARAMETERS

### -ComputerName
A host name or IP address for the target system.

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
  09/01/2015 - Chris Dent - Created.

## RELATED LINKS

