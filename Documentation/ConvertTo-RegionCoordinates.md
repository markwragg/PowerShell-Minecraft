# ConvertTo-RegionCoordinates

## SYNOPSIS
Converts block coordinates to the coordinates of the region file that contains them.

## SYNTAX

```
ConvertTo-RegionCoordinates [-X] <Double> [-Z] <Double> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-RegionCoordinates cmdlet converts a pair of block X/Z coordinates into the
RegionX/RegionZ coordinates of the 32x32 chunk (512x512 block) region that contains them, by
dividing each value by 512.
The result is rounded down to the nearest whole number, matching the
game's own region file naming (e.g.
r.0.0.mca).

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-RegionCoordinates -X 600 -Z -5
```

Returns the region coordinates that contain block X 600, Z -5, i.e.
RegionX 1, RegionZ -1.

### EXAMPLE 2
```
ConvertTo-RegionCoordinates 1600 240
```

X and Z are positional, so they don't need to be named explicitly.

### EXAMPLE 3
```
[pscustomobject]@{ X = 600; Z = -5 } | ConvertTo-RegionCoordinates
```

X and Z can also be supplied via the pipeline by property name.

## PARAMETERS

### -X
The block X coordinate to convert.

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

### -Z
The block Z coordinate to convert.

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
