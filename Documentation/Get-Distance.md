# Get-Distance

## SYNOPSIS
Calculates the horizontal block distance between two sets of coordinates.

## SYNTAX

```
Get-Distance [-From] <PSObject> [-To] <PSObject> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Get-Distance cmdlet calculates the straight-line distance between two X/Z coordinate pairs,
such as those returned by New-Coordinates, ConvertTo-NetherCoordinates or
ConvertTo-OverworldCoordinates.

## EXAMPLES

### EXAMPLE 1
```
Get-Distance -From (New-Coordinates -X 0 -Z 0) -To (New-Coordinates -X 300 -Z 400)
```

Returns 500, the distance between the two points.

### EXAMPLE 2
```
New-Coordinates -X 0 -Z 0 | Get-Distance -To (New-Coordinates -X 300 -Z 400)
```

-From can also be supplied via the pipeline.

## PARAMETERS

### -From
The coordinates to measure from.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -To
The coordinates to measure to.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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

### System.Double
## NOTES

## RELATED LINKS
