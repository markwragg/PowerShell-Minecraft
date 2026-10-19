function Get-Distance {
    <#
    .SYNOPSIS
        Calculates the horizontal block distance between two sets of coordinates.

    .DESCRIPTION
        The Get-Distance cmdlet calculates the straight-line distance between two X/Z coordinate pairs,
        such as those returned by New-Coordinates, ConvertTo-NetherCoordinates or
        ConvertTo-OverworldCoordinates.

    .EXAMPLE
        Get-Distance -From (New-Coordinates -X 0 -Z 0) -To (New-Coordinates -X 300 -Z 400)

        Returns 500, the distance between the two points.

    .EXAMPLE
        New-Coordinates -X 0 -Z 0 | Get-Distance -To (New-Coordinates -X 300 -Z 400)

        -From can also be supplied via the pipeline.
    #>
    [CmdletBinding()]
    [OutputType([double])]
    Param(
        # The coordinates to measure from.
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [pscustomobject]
        $From,

        # The coordinates to measure to.
        [Parameter(Mandatory, Position = 1)]
        [pscustomobject]
        $To
    )
    Process {
        [Math]::Round([Math]::Sqrt([Math]::Pow($To.X - $From.X, 2) + [Math]::Pow($To.Z - $From.Z, 2)), 2)
    }
}
