# Test-SlimeChunk

## SYNOPSIS
Tests whether the chunk containing a block coordinate is a slime chunk.

## SYNTAX

```
Test-SlimeChunk [-X] <Double> [-Z] <Double> [[-Seed] <Int64>] [-Edition <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Test-SlimeChunk cmdlet converts a pair of block X/Z coordinates to the chunk that contains
them (as ConvertTo-ChunkCoordinates does), then tests whether that chunk is a slime chunk, using
either edition's own algorithm:

- Java (the default): seeds a java.util.Random instance from the world seed and the chunk's
  coordinates, and treats the chunk as a slime chunk if the first number it draws between 0 and 9
  is 0 (a 10% chance per chunk).
If -Seed isn't supplied, the default Seed previously stored via
  Set-MinecraftDefault is used instead.

- Bedrock: hashes only the chunk's coordinates (the world seed plays no part) and runs that
  through a Mersenne Twister PRNG, with the same 1-in-10 check.
Because the world seed isn't
  used, slime chunks sit at the same coordinates in every Bedrock world, and -Seed (explicit or
  default) is ignored.

If -Edition isn't supplied, the default Edition previously stored via Set-MinecraftDefault is
used instead, falling back to Java if no default Edition has been stored either.

Slimes can otherwise only naturally spawn in swamp biomes, so slime chunks are the usual way to
farm them below layer 40 elsewhere.

## EXAMPLES

### EXAMPLE 1
```
Test-SlimeChunk -Seed 12345 -X 48 -Z -32
```

Returns whether the chunk containing block X 48, Z -32 is a slime chunk for Java world seed 12345.

### EXAMPLE 2
```
Test-SlimeChunk -Edition Bedrock -X 48 -Z -32
```

Returns whether the chunk containing block X 48, Z -32 is a slime chunk in Bedrock Edition.
No
-Seed is needed, since Bedrock slime chunks don't depend on the world seed.

### EXAMPLE 3
```
[pscustomobject]@{ X = 48; Z = -32 } | Test-SlimeChunk -Seed 12345
```

X and Z can also be supplied via the pipeline by property name, e.g.
from New-Coordinates,
ConvertTo-NetherCoordinates or ConvertTo-OverworldCoordinates.

### EXAMPLE 4
```
Set-MinecraftDefault -Seed 12345
Test-SlimeChunk -X 48 -Z -32
```

Once a default Seed has been stored, -Seed can be omitted (Java only).

### EXAMPLE 5
```
Set-MinecraftDefault -Edition Bedrock
Test-SlimeChunk -X 48 -Z -32
```

Once a default Edition has been stored, -Edition can be omitted too.

## PARAMETERS

### -X
The block X coordinate to test.

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
The block Z coordinate to test.

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

### -Seed
The world seed.
Only used for the Java edition; if omitted there, the default Seed stored via
Set-MinecraftDefault is used instead.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Edition
Which edition's slime-chunk algorithm to use.
If omitted, the default Edition stored via
Set-MinecraftDefault is used, falling back to Java if no default Edition has been stored either.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### System.Boolean
## NOTES

## RELATED LINKS
