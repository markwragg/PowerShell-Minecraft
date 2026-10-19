function New-Coordinates {
    <#
    .SYNOPSIS
        Creates a coordinates object with X and Z properties.

    .DESCRIPTION
        The New-Coordinates cmdlet returns a PowerShell object with X and Z properties, for use as input to
        the other coordinate conversion cmdlets in this module, or anywhere else a simple X/Z position is
        needed.

    .EXAMPLE
        New-Coordinates -X 800 -Z -400

        Returns a coordinates object with X 800, Z -400.

    .EXAMPLE
        New-Coordinates 1600 240

        X and Z are positional, so they don't need to be named explicitly.

    .EXAMPLE
        New-Coordinates -X 800 -Z -400 | ConvertTo-NetherCoordinates

        The returned object can be passed directly into ConvertTo-NetherCoordinates or
        ConvertTo-OverworldCoordinates via the pipeline.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'Creates an in-memory object only; there is no system state to confirm changing.')]
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The X coordinate.
        [Parameter(Mandatory, Position = 0)]
        [double]
        $X,

        # The Z coordinate.
        [Parameter(Mandatory, Position = 1)]
        [double]
        $Z
    )
    [pscustomobject]@{
        X = $X
        Z = $Z
    }
}
