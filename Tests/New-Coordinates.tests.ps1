if (-not $PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$PSVersion = $PSVersionTable.PSVersion.Major

Describe "Unit Tests PS$PSVersion" {

    BeforeAll {
        $Root = "$PSScriptRoot/../"
        $Module = 'Minecraft'

        Get-Module $Module | Remove-Module -Force -ErrorAction SilentlyContinue
        Import-Module "$Root/$Module" -Force
    }

    Context 'Parameter Input Tests' {

        It 'New-Coordinates -X requires an input' {
            { New-Coordinates -X } | Should -Throw
        }
        It 'New-Coordinates -X rejects non-numeric input' {
            { New-Coordinates -X 'Hello' -Z 8 } | Should -Throw
        }
        It 'New-Coordinates -Z requires an input' {
            { New-Coordinates -X 8 -Z } | Should -Throw
        }
        It 'New-Coordinates -Z rejects non-numeric input' {
            { New-Coordinates -X 8 -Z 'World' } | Should -Throw
        }
        It 'New-Coordinates requires both X and Z' {
            $Parameters = (Get-Command New-Coordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Z'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Object Creation Tests' {

        It 'Returns an object with the supplied X and Z values' {
            $Result = New-Coordinates -X 800 -Z -400
            $Result.X | Should -Be 800
            $Result.Z | Should -Be -400
        }

        It 'Accepts X and Z as positional parameters' {
            $Result = New-Coordinates 1600 240
            $Result.X | Should -Be 1600
            $Result.Z | Should -Be 240
        }

        It 'Can be piped into ConvertTo-NetherCoordinates' {
            $Result = New-Coordinates -X 800 -Z -400 | ConvertTo-NetherCoordinates
            $Result.X | Should -Be 100
            $Result.Z | Should -Be -50
        }
    }
}
