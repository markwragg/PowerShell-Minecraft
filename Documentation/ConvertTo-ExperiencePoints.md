# ConvertTo-ExperiencePoints

## SYNOPSIS
Converts a Minecraft experience level into the total experience points required to reach it.

## SYNTAX

```
ConvertTo-ExperiencePoints [-Level] <Int32> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The ConvertTo-ExperiencePoints cmdlet converts an experience level into the total number of
experience points a player must have accumulated to reach the start of that level, using the same
piecewise formula the game itself uses (one formula for levels 0-15, another for 16-30, and another
for 31 and above).

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-ExperiencePoints -Level 30
```

Returns 1395, the total experience points required to reach level 30.

### EXAMPLE 2
```
30 | ConvertTo-ExperiencePoints
```

-Level can also be supplied via the pipeline.

## PARAMETERS

### -Level
The experience level to convert.

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

### System.Int32
## NOTES

## RELATED LINKS
