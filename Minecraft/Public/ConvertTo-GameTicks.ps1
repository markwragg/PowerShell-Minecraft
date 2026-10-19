function ConvertTo-GameTicks {
    <#
    .SYNOPSIS
        Converts a real-world time span into the equivalent number of Minecraft game ticks.

    .DESCRIPTION
        The ConvertTo-GameTicks cmdlet converts a [timespan] into the number of game ticks it represents,
        at the game's standard rate of 20 ticks per second.

    .EXAMPLE
        ConvertTo-GameTicks -Time (New-TimeSpan -Minutes 20)

        Returns 24000, the number of ticks in one full Minecraft day/night cycle.

    .EXAMPLE
        New-TimeSpan -Seconds 30 | ConvertTo-GameTicks

        -Time can also be supplied via the pipeline.
    #>
    [CmdletBinding()]
    [OutputType([long])]
    Param(
        # The real-world time span to convert.
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [timespan]
        $Time
    )
    Process {
        [long][Math]::Round($Time.TotalSeconds * 20)
    }
}
