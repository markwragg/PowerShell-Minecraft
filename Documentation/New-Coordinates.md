# New-Coordinates

## SYNOPSIS
Creates a coordinates object with X and Z properties.

## SYNTAX

```
New-Coordinates [-X] <Double> [-Z] <Double> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The New-Coordinates cmdlet returns a PowerShell object with X and Z properties, for use as input to
the other coordinate conversion cmdlets in this module, or anywhere else a simple X/Z position is
needed.

## EXAMPLES

### EXAMPLE 1
```
New-Coordinates -X 800 -Z -400
```

Returns a coordinates object with X 800, Z -400.

### EXAMPLE 2
```
New-Coordinates 1600 240
```

X and Z are positional, so they don't need to be named explicitly.

### EXAMPLE 3
```
New-Coordinates -X 800 -Z -400 | ConvertTo-NetherCoordinates
```

The returned object can be passed directly into ConvertTo-NetherCoordinates or
ConvertTo-OverworldCoordinates via the pipeline.

## PARAMETERS

### -X
The X coordinate.

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Z
The Z coordinate.

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
