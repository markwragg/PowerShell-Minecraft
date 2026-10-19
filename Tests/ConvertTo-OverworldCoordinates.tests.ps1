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
            { ConvertTo-OverworldCoordinates -X 'Hello' -Y 8 } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates -Y requires an input' {
            { ConvertTo-OverworldCoordinates -X 8 -Y } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates -Y rejects non-numeric input' {
            { ConvertTo-OverworldCoordinates -X 8 -Y 'World' } | Should -Throw
        }
        It 'ConvertTo-OverworldCoordinates requires both X and Y' {
            $Parameters = (Get-Command ConvertTo-OverworldCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Y'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Multiplies positive X and Y coordinates by 8' {
            $Result = ConvertTo-OverworldCoordinates -X 100 -Y 30
            $Result.X | Should -Be 800
            $Result.Y | Should -Be 240
        }

        It 'Multiplies negative X and Y coordinates by 8' {
            $Result = ConvertTo-OverworldCoordinates -X -100 -Y -50
            $Result.X | Should -Be -800
            $Result.Y | Should -Be -400
        }

        It 'Accepts X and Y as positional parameters' {
            $Result = ConvertTo-OverworldCoordinates 200 11
            $Result.X | Should -Be 1600
            $Result.Y | Should -Be 88
        }

        It 'Accepts X and Y via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 30; Y = 11 } | ConvertTo-OverworldCoordinates
            $Result.X | Should -Be 240
            $Result.Y | Should -Be 88
        }

        It 'Returns whole numbers as integers' {
            $Result = ConvertTo-OverworldCoordinates -X 100 -Y 30
            $Result.X | Should -BeOfType [int]
            $Result.Y | Should -BeOfType [int]
        }

        It 'Is the inverse of ConvertTo-NetherCoordinates for exact multiples of 8' {
            $Result = ConvertTo-OverworldCoordinates -X 100 -Y -50 | ConvertTo-NetherCoordinates
            $Result.X | Should -Be 100
            $Result.Y | Should -Be -50
        }
    }
}
