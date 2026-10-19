function ConvertTo-OverworldCoordinates {
    <#
    .SYNOPSIS
        Converts Nether coordinates to their equivalent Overworld coordinates.

    .DESCRIPTION
        The ConvertTo-OverworldCoordinates cmdlet converts a pair of Nether X/Z coordinates into the equivalent
        Overworld coordinates, by multiplying each value by 8, reflecting the Nether's 1:8 scale relative to
        the Overworld.

    .EXAMPLE
        ConvertTo-OverworldCoordinates -X 100 -Z -50

        Returns the Overworld coordinates equivalent to Nether coordinates X 100, Z -50, i.e. X 800, Z -400.

    .EXAMPLE
        ConvertTo-OverworldCoordinates 200 30

        X and Z are positional, so they don't need to be named explicitly.

    .EXAMPLE
        [pscustomobject]@{ X = 30; Z = 11 } | ConvertTo-OverworldCoordinates

        X and Z can also be supplied via the pipeline by property name, e.g. from an object such as one
        recording a player's Nether position.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The Nether X coordinate to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [double]
        $X,

        # The Nether Z coordinate to convert.
        [Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
        [double]
        $Z
    )
    Process {
        [pscustomobject]@{
            X = [int]($X * 8)
            Z = [int]($Z * 8)
        }
    }
}
