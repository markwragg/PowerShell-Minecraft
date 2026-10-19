# ConvertTo-NetherCoordinates

## SYNOPSIS
Converts Overworld coordinates to their equivalent Nether coordinates.

## SYNTAX

```
ConvertTo-NetherCoordinates [-X] <Double> [-Y] <Double> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-NetherCoordinates cmdlet converts a pair of Overworld X/Y coordinates into the equivalent
Nether coordinates, by dividing each value by 8.
The result is rounded down to the nearest whole
number (block coordinates in Minecraft are always whole numbers), matching the game's own conversion
behavior.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-NetherCoordinates -X 800 -Y -400
```

Returns the Nether coordinates equivalent to Overworld coordinates X 800, Y -400, i.e.
X 100, Y -50.

### EXAMPLE 2
```
ConvertTo-NetherCoordinates 1600 240
```

X and Y are positional, so they don't need to be named explicitly.

### EXAMPLE 3
```
[pscustomobject]@{ X = 240; Y = 88 } | ConvertTo-NetherCoordinates
```

X and Y can also be supplied via the pipeline by property name, e.g.
from an object such as one
recording a player's Overworld position.

## PARAMETERS

### -X
The Overworld X coordinate to convert.

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
The Overworld Y coordinate to convert.

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
