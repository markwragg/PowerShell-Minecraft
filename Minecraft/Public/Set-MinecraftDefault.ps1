function Set-MinecraftDefault {
    <#
    .SYNOPSIS
        Stores default values that other cmdlets in this module fall back to when not supplied explicitly.

    .DESCRIPTION
        The Set-MinecraftDefault cmdlet saves settings to $HOME/.minecraft/defaults.json so they don't
        need to be supplied on every call. Currently supports:

        - A default Seed, which Test-SlimeChunk uses automatically when -Seed isn't supplied explicitly
          (Java Edition only).
        - A default Edition, which Test-SlimeChunk uses automatically when -Edition isn't supplied
          explicitly.

        At least one of -Seed or -Edition must be supplied. Either can be set independently -- supplying
        just one leaves any previously stored value for the other untouched.

    .EXAMPLE
        Set-MinecraftDefault -Seed 12345

        Stores 12345 as the default Seed, so e.g. Test-SlimeChunk -X 48 -Z -32 uses it automatically.

    .EXAMPLE
        Set-MinecraftDefault -Edition Bedrock

        Stores Bedrock as the default Edition, so Test-SlimeChunk uses it automatically without needing
        -Edition Bedrock on every call.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([pscustomobject])]
    Param(
        # The default world seed to store, for use by cmdlets that accept a -Seed parameter.
        [Parameter()]
        [long]
        $Seed,

        # The default edition to store, for use by cmdlets that accept an -Edition parameter.
        [Parameter()]
        [ValidateSet('Java', 'Bedrock')]
        [string]
        $Edition
    )
    if (-not $PSBoundParameters.ContainsKey('Seed') -and -not $PSBoundParameters.ContainsKey('Edition')) {
        throw 'At least one of -Seed or -Edition must be supplied.'
    }

    $Directory = Join-Path -Path $HOME -ChildPath '.minecraft'
    $Path = Join-Path -Path $Directory -ChildPath 'defaults.json'

    $Defaults = if (Test-Path -Path $Path) {
        Get-Content -Path $Path -Raw | ConvertFrom-Json
    }
    else {
        [pscustomobject]@{}
    }

    $Changes = [System.Collections.Generic.List[string]]::new()

    if ($PSBoundParameters.ContainsKey('Seed')) {
        $Defaults | Add-Member -MemberType NoteProperty -Name 'Seed' -Value $Seed -Force
        $Changes.Add("Seed to $Seed")
    }
    if ($PSBoundParameters.ContainsKey('Edition')) {
        $Defaults | Add-Member -MemberType NoteProperty -Name 'Edition' -Value $Edition -Force
        $Changes.Add("Edition to $Edition")
    }

    if ($PSCmdlet.ShouldProcess($Path, "Set default $($Changes -join ' and ')")) {
        if (-not (Test-Path -Path $Directory)) {
            New-Item -Path $Directory -ItemType Directory -Force | Out-Null
        }

        $Defaults | ConvertTo-Json | Set-Content -Path $Path
        $Defaults
    }
}
