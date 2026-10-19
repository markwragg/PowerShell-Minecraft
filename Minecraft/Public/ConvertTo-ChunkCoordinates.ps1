function ConvertTo-ChunkCoordinates {
    <#
    .SYNOPSIS
        Converts block coordinates to the coordinates of the chunk that contains them.

    .DESCRIPTION
        The ConvertTo-ChunkCoordinates cmdlet converts a pair of block X/Z coordinates into the ChunkX/
        ChunkZ coordinates of the 16x16 chunk that contains them, by dividing each value by 16. The result
        is rounded down to the nearest whole number, matching the game's own chunk indexing.

    .EXAMPLE
        ConvertTo-ChunkCoordinates -X 48 -Z -5

        Returns the chunk coordinates that contain block X 48, Z -5, i.e. ChunkX 3, ChunkZ -1.

    .EXAMPLE
        ConvertTo-ChunkCoordinates 1600 240

        X and Z are positional, so they don't need to be named explicitly.

    .EXAMPLE
        [pscustomobject]@{ X = 48; Z = -5 } | ConvertTo-ChunkCoordinates

        X and Z can also be supplied via the pipeline by property name.

    .EXAMPLE
        ConvertTo-ChunkCoordinates -X 48 -Z -5 | Test-SlimeChunk -Seed 12345

        The returned ChunkX/ChunkZ properties can be piped directly into Test-SlimeChunk.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The block X coordinate to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [double]
        $X,

        # The block Z coordinate to convert.
        [Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
        [double]
        $Z
    )
    Process {
        [pscustomobject]@{
            ChunkX = [int][Math]::Floor($X / 16)
            ChunkZ = [int][Math]::Floor($Z / 16)
        }
    }
}
