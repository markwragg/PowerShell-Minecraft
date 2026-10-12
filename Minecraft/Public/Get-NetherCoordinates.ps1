function Get-NetherCoordinates {
    <#
    .SYNOPSIS
        Converts Overworld coordinates to their equivalent Nether coordinates.

    .DESCRIPTION
        The Get-NetherCoordinates cmdlet converts a pair of Overworld X/Y coordinates into the equivalent
        Nether coordinates, by dividing each value by 8. The result is rounded down to the nearest whole
        number (block coordinates in Minecraft are always whole numbers), matching the game's own conversion
        behavior.

    .EXAMPLE
        Get-NetherCoordinates -X 800 -Y -400

        Returns the Nether coordinates equivalent to Overworld coordinates X 800, Y -400, i.e. X 100, Y -50.

    .EXAMPLE
        Get-NetherCoordinates 1600 240

        X and Y are positional, so they don't need to be named explicitly.

    .EXAMPLE
        [pscustomobject]@{ X = 240; Y = 88 } | Get-NetherCoordinates

        X and Y can also be supplied via the pipeline by property name, e.g. from an object such as one
        recording a player's Overworld position.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The Overworld X coordinate to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [double]
        $X,

        # The Overworld Y coordinate to convert.
        [Parameter(Mandatory, Position = 1, ValueFromPipelineByPropertyName)]
        [double]
        $Y
    )
    Process {
        [pscustomobject]@{
            X = [int][Math]::Floor($X / 8)
            Y = [int][Math]::Floor($Y / 8)
        }
    }
}
