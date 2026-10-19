function ConvertTo-NetherCoordinates {
    <#
    .SYNOPSIS
        Converts Overworld coordinates to their equivalent Nether coordinates.

    .DESCRIPTION
        The ConvertTo-NetherCoordinates cmdlet converts a pair of Overworld X/Z coordinates into the equivalent
        Nether coordinates, by dividing each value by 8. The result is rounded down to the nearest whole
        number (block coordinates in Minecraft are always whole numbers), matching the game's own conversion
        behavior.

    .EXAMPLE
        ConvertTo-NetherCoordinates -X 800 -Z -400

        Returns the Nether coordinates equivalent to Overworld coordinates X 800, Z -400, i.e. X 100, Z -50.

    .EXAMPLE
        ConvertTo-NetherCoordinates 1600 240

        X and Z are positional, so they don't need to be named explicitly.

    .EXAMPLE
        [pscustomobject]@{ X = 240; Z = 88 } | ConvertTo-NetherCoordinates

        X and Z can also be supplied via the pipeline by property name, e.g. from an object such as one
        recording a player's Overworld position.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The Overworld X coordinate to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [double]
        $X,

        # The Overworld Z coordinate to convert.
        [Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
        [double]
        $Z
    )
    Process {
        [pscustomobject]@{
            X = [int][Math]::Floor($X / 8)
            Z = [int][Math]::Floor($Z / 8)
        }
    }
}
