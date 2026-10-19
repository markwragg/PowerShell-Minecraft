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

        It 'ConvertTo-NetherCoordinates -X requires an input' {
            { ConvertTo-NetherCoordinates -X } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates -X rejects non-numeric input' {
            { ConvertTo-NetherCoordinates -X 'Hello' -Z 8 } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates -Z requires an input' {
            { ConvertTo-NetherCoordinates -X 8 -Z } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates -Z rejects non-numeric input' {
            { ConvertTo-NetherCoordinates -X 8 -Z 'World' } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates requires both X and Z' {
            $Parameters = (Get-Command ConvertTo-NetherCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Z'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Divides positive X and Z coordinates by 8' {
            $Result = ConvertTo-NetherCoordinates -X 800 -Z 240
            $Result.X | Should -Be 100
            $Result.Z | Should -Be 30
        }

        It 'Divides negative X and Z coordinates by 8' {
            $Result = ConvertTo-NetherCoordinates -X -800 -Z -400
            $Result.X | Should -Be -100
            $Result.Z | Should -Be -50
        }

        It 'Accepts X and Z as positional parameters' {
            $Result = ConvertTo-NetherCoordinates 1600 88
            $Result.X | Should -Be 200
            $Result.Z | Should -Be 11
        }

        It 'Accepts X and Z via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 240; Z = 88 } | ConvertTo-NetherCoordinates
            $Result.X | Should -Be 30
            $Result.Z | Should -Be 11
        }

        It 'Rounds down to the nearest whole number when the result is not exact' {
            $Result = ConvertTo-NetherCoordinates -X 10 -Z 5
            $Result.X | Should -Be 1
            $Result.Z | Should -Be 0
        }

        It 'Rounds down (not towards zero) for negative coordinates' {
            $Result = ConvertTo-NetherCoordinates -X -1 -Z -10
            $Result.X | Should -Be -1
            $Result.Z | Should -Be -2
        }

        It 'Returns whole numbers as integers' {
            $Result = ConvertTo-NetherCoordinates -X 800 -Z 240
            $Result.X | Should -BeOfType [int]
            $Result.Z | Should -BeOfType [int]
        }
    }
}
