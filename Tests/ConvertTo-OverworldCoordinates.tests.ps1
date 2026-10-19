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

        It 'ConvertTo-OverworldCoordinates -X requires an input' {
            { ConvertTo-OverworldCoordinates -X } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates -X rejects non-numeric input' {
            { ConvertTo-OverworldCoordinates -X 'Hello' -Z 8 } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates -Z requires an input' {
            { ConvertTo-OverworldCoordinates -X 8 -Z } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates -Z rejects non-numeric input' {
            { ConvertTo-OverworldCoordinates -X 8 -Z 'World' } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates requires both X and Z' {
            $Parameters = (Get-Command ConvertTo-OverworldCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Z'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Multiplies positive X and Z coordinates by 8' {
            $Result = ConvertTo-OverworldCoordinates -X 100 -Z 30
            $Result.X | Should -Be 800
            $Result.Z | Should -Be 240
        }

        It 'Multiplies negative X and Z coordinates by 8' {
            $Result = ConvertTo-OverworldCoordinates -X -100 -Z -50
            $Result.X | Should -Be -800
            $Result.Z | Should -Be -400
        }

        It 'Accepts X and Z as positional parameters' {
            $Result = ConvertTo-OverworldCoordinates 200 11
            $Result.X | Should -Be 1600
            $Result.Z | Should -Be 88
        }

        It 'Accepts X and Z via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 30; Z = 11 } | ConvertTo-OverworldCoordinates
            $Result.X | Should -Be 240
            $Result.Z | Should -Be 88
        }

        It 'Returns whole numbers as integers' {
            $Result = ConvertTo-OverworldCoordinates -X 100 -Z 30
            $Result.X | Should -BeOfType [int]
            $Result.Z | Should -BeOfType [int]
        }

        It 'Is the inverse of ConvertTo-NetherCoordinates for exact multiples of 8' {
            $Result = ConvertTo-OverworldCoordinates -X 100 -Z -50 | ConvertTo-NetherCoordinates
            $Result.X | Should -Be 100
            $Result.Z | Should -Be -50
        }
    }
}
