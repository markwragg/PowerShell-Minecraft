# Set-MinecraftDefault

## SYNOPSIS
Stores default values that other cmdlets in this module fall back to when not supplied explicitly.

## SYNTAX

```
Set-MinecraftDefault [[-Seed] <Int64>] [[-Edition] <String>] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Set-MinecraftDefault cmdlet saves settings to $HOME/.minecraft/defaults.json so they don't
need to be supplied on every call.
Currently supports:

- A default Seed, which Test-SlimeChunk uses automatically when -Seed isn't supplied explicitly
  (Java Edition only).
- A default Edition, which Test-SlimeChunk uses automatically when -Edition isn't supplied
  explicitly.

At least one of -Seed or -Edition must be supplied.
Either can be set independently -- supplying
just one leaves any previously stored value for the other untouched.

## EXAMPLES

### EXAMPLE 1
```
Set-MinecraftDefault -Seed 12345
```

Stores 12345 as the default Seed, so e.g.
Test-SlimeChunk -X 48 -Z -32 uses it automatically.

### EXAMPLE 2
```
Set-MinecraftDefault -Edition Bedrock
```

Stores Bedrock as the default Edition, so Test-SlimeChunk uses it automatically without needing
-Edition Bedrock on every call.

## PARAMETERS

### -Seed
The default world seed to store, for use by cmdlets that accept a -Seed parameter.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Edition
The default edition to store, for use by cmdlets that accept an -Edition parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
