function ConvertTo-RegionCoordinates {
    <#
    .SYNOPSIS
        Converts block coordinates to the coordinates of the region file that contains them.

    .DESCRIPTION
        The ConvertTo-RegionCoordinates cmdlet converts a pair of block X/Z coordinates into the
        RegionX/RegionZ coordinates of the 32x32 chunk (512x512 block) region that contains them, by
        dividing each value by 512. The result is rounded down to the nearest whole number, matching the
        game's own region file naming (e.g. r.0.0.mca).

    .EXAMPLE
        ConvertTo-RegionCoordinates -X 600 -Z -5

        Returns the region coordinates that contain block X 600, Z -5, i.e. RegionX 1, RegionZ -1.

    .EXAMPLE
        ConvertTo-RegionCoordinates 1600 240

        X and Z are positional, so they don't need to be named explicitly.

    .EXAMPLE
        [pscustomobject]@{ X = 600; Z = -5 } | ConvertTo-RegionCoordinates

        X and Z can also be supplied via the pipeline by property name.
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
            RegionX = [int][Math]::Floor($X / 512)
            RegionZ = [int][Math]::Floor($Z / 512)
        }
    }
}
