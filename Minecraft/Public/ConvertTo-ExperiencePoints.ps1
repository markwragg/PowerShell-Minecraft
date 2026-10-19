function ConvertTo-ExperiencePoints {
    <#
    .SYNOPSIS
        Converts a Minecraft experience level into the total experience points required to reach it.

    .DESCRIPTION
        The ConvertTo-ExperiencePoints cmdlet converts an experience level into the total number of
        experience points a player must have accumulated to reach the start of that level, using the same
        piecewise formula the game itself uses (one formula for levels 0-15, another for 16-30, and another
        for 31 and above).

    .EXAMPLE
        ConvertTo-ExperiencePoints -Level 30

        Returns 1395, the total experience points required to reach level 30.

    .EXAMPLE
        30 | ConvertTo-ExperiencePoints

        -Level can also be supplied via the pipeline.
    #>
    [CmdletBinding()]
    [OutputType([int])]
    Param(
        # The experience level to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 2147483647)]
        [int]
        $Level
    )
    Process {
        if ($Level -le 15) {
            [int]([Math]::Pow($Level, 2) + (6 * $Level))
        }
        elseif ($Level -le 30) {
            [int]((2.5 * [Math]::Pow($Level, 2)) - (40.5 * $Level) + 360)
        }
        else {
            [int]((4.5 * [Math]::Pow($Level, 2)) - (162.5 * $Level) + 2220)
        }
    }
}
