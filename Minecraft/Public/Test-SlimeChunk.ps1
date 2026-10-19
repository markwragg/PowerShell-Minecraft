function Test-SlimeChunk {
    <#
    .SYNOPSIS
        Tests whether the chunk containing a block coordinate is a slime chunk.

    .DESCRIPTION
        The Test-SlimeChunk cmdlet converts a pair of block X/Z coordinates to the chunk that contains
        them (as ConvertTo-ChunkCoordinates does), then tests whether that chunk is a slime chunk, using
        either edition's own algorithm:

        - Java (the default): seeds a java.util.Random instance from the world seed and the chunk's
          coordinates, and treats the chunk as a slime chunk if the first number it draws between 0 and 9
          is 0 (a 10% chance per chunk). If -Seed isn't supplied, the default Seed previously stored via
          Set-MinecraftDefault is used instead.

        - Bedrock: hashes only the chunk's coordinates (the world seed plays no part) and runs that
          through a Mersenne Twister PRNG, with the same 1-in-10 check. Because the world seed isn't
          used, slime chunks sit at the same coordinates in every Bedrock world, and -Seed (explicit or
          default) is ignored.

        If -Edition isn't supplied, the default Edition previously stored via Set-MinecraftDefault is
        used instead, falling back to Java if no default Edition has been stored either.

        Slimes can otherwise only naturally spawn in swamp biomes, so slime chunks are the usual way to
        farm them below layer 40 elsewhere.

    .EXAMPLE
        Test-SlimeChunk -Seed 12345 -X 48 -Z -32

        Returns whether the chunk containing block X 48, Z -32 is a slime chunk for Java world seed 12345.

    .EXAMPLE
        Test-SlimeChunk -Edition Bedrock -X 48 -Z -32

        Returns whether the chunk containing block X 48, Z -32 is a slime chunk in Bedrock Edition. No
        -Seed is needed, since Bedrock slime chunks don't depend on the world seed.

    .EXAMPLE
        [pscustomobject]@{ X = 48; Z = -32 } | Test-SlimeChunk -Seed 12345

        X and Z can also be supplied via the pipeline by property name, e.g. from New-Coordinates,
        ConvertTo-NetherCoordinates or ConvertTo-OverworldCoordinates.

    .EXAMPLE
        Set-MinecraftDefault -Seed 12345
        Test-SlimeChunk -X 48 -Z -32

        Once a default Seed has been stored, -Seed can be omitted (Java only).

    .EXAMPLE
        Set-MinecraftDefault -Edition Bedrock
        Test-SlimeChunk -X 48 -Z -32

        Once a default Edition has been stored, -Edition can be omitted too.
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    Param(
        # The block X coordinate to test.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [double]
        $X,

        # The block Z coordinate to test.
        [Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
        [double]
        $Z,

        # The world seed. Only used for the Java edition; if omitted there, the default Seed stored via
        # Set-MinecraftDefault is used instead.
        [Parameter(Position = 2)]
        [long]
        $Seed,

        # Which edition's slime-chunk algorithm to use. If omitted, the default Edition stored via
        # Set-MinecraftDefault is used, falling back to Java if no default Edition has been stored either.
        [ValidateSet('Java', 'Bedrock')]
        [string]
        $Edition
    )
    Begin {
        if ($PSBoundParameters.ContainsKey('Edition')) {
            $EffectiveEdition = $Edition
        }
        else {
            $DefaultEdition = Get-MinecraftDefault -Name 'Edition'
            $EffectiveEdition = if ($DefaultEdition) { $DefaultEdition } else { 'Java' }
        }

        if ($EffectiveEdition -eq 'Java') {
            if ($PSBoundParameters.ContainsKey('Seed')) {
                $EffectiveSeed = $Seed
            }
            else {
                $DefaultSeed = Get-MinecraftDefault -Name 'Seed'
                if ($null -eq $DefaultSeed) {
                    throw 'No -Seed was supplied and no default Seed has been set. Use Set-MinecraftDefault -Seed <value> to set one.'
                }
                $EffectiveSeed = [long]$DefaultSeed
            }
        }
    }
    Process {
        $ChunkX = [int][Math]::Floor($X / 16)
        $ChunkZ = [int][Math]::Floor($Z / 16)
        $Mask32 = [System.Numerics.BigInteger]::Pow(2, 32)

        if ($EffectiveEdition -eq 'Java') {
            # Minecraft derives the per-chunk seed using Java's wrapping 32-bit integer arithmetic, so
            # each intermediate multiplication below is explicitly wrapped to 32 bits to match it -- using
            # the true (unwrapped) product at those steps would produce a different, incorrect seed.
            $Half32 = [System.Numerics.BigInteger]::Pow(2, 31)

            function ConvertTo-WrappedInt32 {
                param([System.Numerics.BigInteger]$Value)
                $Wrapped = (($Value % $Mask32) + $Mask32) % $Mask32
                if ($Wrapped -ge $Half32) { $Wrapped - $Mask32 } else { $Wrapped }
            }

            $ChunkXSquared = ConvertTo-WrappedInt32 ([System.Numerics.BigInteger]$ChunkX * $ChunkX)
            $ChunkZSquared = ConvertTo-WrappedInt32 ([System.Numerics.BigInteger]$ChunkZ * $ChunkZ)

            $Term1 = ConvertTo-WrappedInt32 ($ChunkXSquared * 0x4c1906)
            $Term2 = ConvertTo-WrappedInt32 ([System.Numerics.BigInteger]$ChunkX * 0x5ac0db)
            $Term3 = $ChunkZSquared * [System.Numerics.BigInteger]0x4307a7
            $Term4 = ConvertTo-WrappedInt32 ([System.Numerics.BigInteger]$ChunkZ * 0x5f24f)

            $ChunkSeed = ([System.Numerics.BigInteger]$EffectiveSeed + $Term1 + $Term2 + $Term3 + $Term4) -bxor 0x3ad8025f

            # Java's java.util.Random linear congruential generator.
            $Multiplier = [System.Numerics.BigInteger]0x5DEECE66D
            $Mask48 = ([System.Numerics.BigInteger]1 -shl 48) - 1

            $State = ($ChunkSeed -bxor $Multiplier) -band $Mask48
            $State = ($State * $Multiplier + 0xB) -band $Mask48

            # Equivalent to Random.nextInt(10): take the top 31 bits of the state and reduce modulo 10.
            $Bits = [int]($State -shr 17)
            ($Bits % 10) -eq 0
        }
        else {
            # Bedrock doesn't use the world seed at all -- it hashes only the chunk coordinates, so the
            # same chunk is a slime chunk (or isn't) in every Bedrock world.
            $ProductUnsigned = ((([System.Numerics.BigInteger]$ChunkX * 0x1f1f1f1f) % $Mask32) + $Mask32) % $Mask32
            $ChunkZUnsigned = (([System.Numerics.BigInteger]$ChunkZ % $Mask32) + $Mask32) % $Mask32
            $BedrockSeed = $ProductUnsigned -bxor $ChunkZUnsigned

            $Value = Get-Mt19937FirstUInt32 -Seed $BedrockSeed
            ($Value % 10) -eq 0
        }
    }
}
