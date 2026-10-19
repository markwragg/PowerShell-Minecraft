# ConvertFrom-GameTicks

## SYNOPSIS
Converts a number of Minecraft game ticks into the equivalent real-world time span.

## SYNTAX

```
ConvertFrom-GameTicks [-Ticks] <Int64> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The ConvertFrom-GameTicks cmdlet converts a number of game ticks into a \[timespan\] representing how
long that is in the real world, at the game's standard rate of 20 ticks per second.

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-GameTicks -Ticks 24000
```

Returns a TimeSpan of 00:20:00, i.e.
the length of one full Minecraft day/night cycle.

### EXAMPLE 2
```
24000 | ConvertFrom-GameTicks
```

-Ticks can also be supplied via the pipeline.

## PARAMETERS

### -Ticks
The number of game ticks to convert.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProgressAction
{{Fill ProgressAction Description}}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.TimeSpan
## NOTES

## RELATED LINKS
