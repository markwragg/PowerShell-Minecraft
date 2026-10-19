function Get-MinecraftDefault {
    <#
    .SYNOPSIS
        Gets the default values previously stored by Set-MinecraftDefault.

    .DESCRIPTION
        The Get-MinecraftDefault cmdlet reads the settings stored by Set-MinecraftDefault from
        $HOME/.minecraft/defaults.json, e.g. a default Seed or Edition that Test-SlimeChunk falls back to
        when -Seed or -Edition isn't supplied explicitly. Returns $null (or, with no -Name, an empty
        object) if no defaults have been stored yet.

    .EXAMPLE
        Get-MinecraftDefault

        Returns all currently stored default values.

    .EXAMPLE
        Get-MinecraftDefault -Name Seed

        Returns just the stored default Seed value, or $null if one hasn't been set.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    Param(
        # The name of a specific default value to return. If omitted, all stored defaults are returned.
        [Parameter(Position = 0)]
        [string]
        $Name
    )
    $Path = Join-Path -Path $HOME -ChildPath '.minecraft/defaults.json'

    $Defaults = if (Test-Path -Path $Path) {
        Get-Content -Path $Path -Raw | ConvertFrom-Json
    }
    else {
        [pscustomobject]@{}
    }

    if ($Name) {
        $Defaults.$Name
    }
    else {
        $Defaults
    }
}
