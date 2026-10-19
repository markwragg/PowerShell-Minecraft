function ConvertTo-ExperienceLevel {
    <#
    .SYNOPSIS
        Converts a total experience point count into the equivalent Minecraft experience level.

    .DESCRIPTION
        The ConvertTo-ExperienceLevel cmdlet converts a player's total accumulated experience points into
        their current experience level, and how far through that level they are (Progress, a value between
        0 and 1), using the same formula the game itself uses to calculate the points required for each
        level.

    .EXAMPLE
        ConvertTo-ExperienceLevel -Points 1200

        Returns the level and progress equivalent to 1200 total experience points.

    .EXAMPLE
        1200 | ConvertTo-ExperienceLevel

        -Points can also be supplied via the pipeline.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The total accumulated experience points to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 2147483647)]
        [int]
        $Points
    )
    Process {
        $Level = 0
        while ((ConvertTo-ExperiencePoints -Level ($Level + 1)) -le $Points) {
            $Level++
        }

        $LevelStart = ConvertTo-ExperiencePoints -Level $Level
        $NextLevelStart = ConvertTo-ExperiencePoints -Level ($Level + 1)

        [pscustomobject]@{
            Level    = $Level
            Progress = [Math]::Round(($Points - $LevelStart) / ($NextLevelStart - $LevelStart), 4)
        }
    }
}
