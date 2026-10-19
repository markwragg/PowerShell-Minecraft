# ConvertTo-ExperienceLevel

## SYNOPSIS
Converts a total experience point count into the equivalent Minecraft experience level.

## SYNTAX

```
ConvertTo-ExperienceLevel [-Points] <Int32> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-ExperienceLevel cmdlet converts a player's total accumulated experience points into
their current experience level, and how far through that level they are (Progress, a value between
0 and 1), using the same formula the game itself uses to calculate the points required for each
level.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-ExperienceLevel -Points 1200
```

Returns the level and progress equivalent to 1200 total experience points.

### EXAMPLE 2
```
1200 | ConvertTo-ExperienceLevel
```

-Points can also be supplied via the pipeline.

## PARAMETERS

### -Points
The total accumulated experience points to convert.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
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

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
