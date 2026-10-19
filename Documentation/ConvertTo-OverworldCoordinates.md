# ConvertTo-OverworldCoordinates

## SYNOPSIS
Converts Nether coordinates to their equivalent Overworld coordinates.

## SYNTAX

```
ConvertTo-OverworldCoordinates [-X] <Double> [-Y] <Double> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-OverworldCoordinates cmdlet converts a pair of Nether X/Y coordinates into the equivalent
Overworld coordinates, by multiplying each value by 8, reflecting the Nether's 1:8 scale relative to
the Overworld.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-OverworldCoordinates -X 100 -Y -50
```

Returns the Overworld coordinates equivalent to Nether coordinates X 100, Y -50, i.e.
X 800, Y -400.

### EXAMPLE 2
```
ConvertTo-OverworldCoordinates 200 30
```

X and Y are positional, so they don't need to be named explicitly.

### EXAMPLE 3
```
[pscustomobject]@{ X = 30; Y = 11 } | ConvertTo-OverworldCoordinates
```

X and Y can also be supplied via the pipeline by property name, e.g.
from an object such as one
recording a player's Nether position.

## PARAMETERS

### -X
The Nether X coordinate to convert.

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Y
The Nether Y coordinate to convert.

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
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
