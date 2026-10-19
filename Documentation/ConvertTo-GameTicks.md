# ConvertTo-GameTicks

## SYNOPSIS
Converts a real-world time span into the equivalent number of Minecraft game ticks.

## SYNTAX

```
ConvertTo-GameTicks [-Time] <TimeSpan> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-GameTicks cmdlet converts a \[timespan\] into the number of game ticks it represents,
at the game's standard rate of 20 ticks per second.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-GameTicks -Time (New-TimeSpan -Minutes 20)
```

Returns 24000, the number of ticks in one full Minecraft day/night cycle.

### EXAMPLE 2
```
New-TimeSpan -Seconds 30 | ConvertTo-GameTicks
```

-Time can also be supplied via the pipeline.

## PARAMETERS

### -Time
The real-world time span to convert.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Int64
## NOTES

## RELATED LINKS
