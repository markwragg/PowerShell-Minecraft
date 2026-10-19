function ConvertFrom-GameTicks {
    <#
    .SYNOPSIS
        Converts a number of Minecraft game ticks into the equivalent real-world time span.

    .DESCRIPTION
        The ConvertFrom-GameTicks cmdlet converts a number of game ticks into a [timespan] representing how
        long that is in the real world, at the game's standard rate of 20 ticks per second.

    .EXAMPLE
        ConvertFrom-GameTicks -Ticks 24000

        Returns a TimeSpan of 00:20:00, i.e. the length of one full Minecraft day/night cycle.

    .EXAMPLE
        24000 | ConvertFrom-GameTicks

        -Ticks can also be supplied via the pipeline.
    #>
    [CmdletBinding()]
    [OutputType([timespan])]
    Param(
        # The number of game ticks to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [long]
        $Ticks
    )
    Process {
        [timespan]::FromSeconds($Ticks / 20)
    }
}
