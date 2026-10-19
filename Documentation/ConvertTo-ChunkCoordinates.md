# ConvertTo-ChunkCoordinates

## SYNOPSIS
Converts block coordinates to the coordinates of the chunk that contains them.

## SYNTAX

```
ConvertTo-ChunkCoordinates [-X] <Double> [-Z] <Double> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-ChunkCoordinates cmdlet converts a pair of block X/Z coordinates into the ChunkX/
ChunkZ coordinates of the 16x16 chunk that contains them, by dividing each value by 16.
The result
is rounded down to the nearest whole number, matching the game's own chunk indexing.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-ChunkCoordinates -X 48 -Z -5
```

Returns the chunk coordinates that contain block X 48, Z -5, i.e.
ChunkX 3, ChunkZ -1.

### EXAMPLE 2
```
ConvertTo-ChunkCoordinates 1600 240
```

X and Z are positional, so they don't need to be named explicitly.

### EXAMPLE 3
```
[pscustomobject]@{ X = 48; Z = -5 } | ConvertTo-ChunkCoordinates
```

X and Z can also be supplied via the pipeline by property name.

### EXAMPLE 4
```
ConvertTo-ChunkCoordinates -X 48 -Z -5 | Test-SlimeChunk -Seed 12345
```

The returned ChunkX/ChunkZ properties can be piped directly into Test-SlimeChunk.

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
{{Fill ProgressAction Description}}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
