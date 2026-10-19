# Get-MinecraftDefault

## SYNOPSIS
Gets the default values previously stored by Set-MinecraftDefault.

## SYNTAX

```
Get-MinecraftDefault [[-Name] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Get-MinecraftDefault cmdlet reads the settings stored by Set-MinecraftDefault from
$HOME/.minecraft/defaults.json, e.g.
a default Seed or Edition that Test-SlimeChunk falls back to
when -Seed or -Edition isn't supplied explicitly.
Returns $null (or, with no -Name, an empty
object) if no defaults have been stored yet.

## EXAMPLES

### EXAMPLE 1
```
Get-MinecraftDefault
```

Returns all currently stored default values.

### EXAMPLE 2
```
Get-MinecraftDefault -Name Seed
```

Returns just the stored default Seed value, or $null if one hasn't been set.

## PARAMETERS

### -Name
The name of a specific default value to return.
If omitted, all stored defaults are returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
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
