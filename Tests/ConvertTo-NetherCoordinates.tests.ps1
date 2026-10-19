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
            { ConvertTo-NetherCoordinates -X 'Hello' -Y 8 } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates -Y requires an input' {
            { ConvertTo-NetherCoordinates -X 8 -Y } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates -Y rejects non-numeric input' {
            { ConvertTo-NetherCoordinates -X 8 -Y 'World' } | Should -Throw
        }
        It 'ConvertTo-NetherCoordinates requires both X and Y' {
            $Parameters = (Get-Command ConvertTo-NetherCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Y'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Divides positive X and Y coordinates by 8' {
            $Result = ConvertTo-NetherCoordinates -X 800 -Y 240
            $Result.X | Should -Be 100
            $Result.Y | Should -Be 30
        }

        It 'Divides negative X and Y coordinates by 8' {
            $Result = ConvertTo-NetherCoordinates -X -800 -Y -400
            $Result.X | Should -Be -100
            $Result.Y | Should -Be -50
        }

        It 'Accepts X and Y as positional parameters' {
            $Result = ConvertTo-NetherCoordinates 1600 88
            $Result.X | Should -Be 200
            $Result.Y | Should -Be 11
        }

        It 'Accepts X and Y via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 240; Y = 88 } | ConvertTo-NetherCoordinates
            $Result.X | Should -Be 30
            $Result.Y | Should -Be 11
        }

        It 'Rounds down to the nearest whole number when the result is not exact' {
            $Result = ConvertTo-NetherCoordinates -X 10 -Y 5
            $Result.X | Should -Be 1
            $Result.Y | Should -Be 0
        }

        It 'Rounds down (not towards zero) for negative coordinates' {
            $Result = ConvertTo-NetherCoordinates -X -1 -Y -10
            $Result.X | Should -Be -1
            $Result.Y | Should -Be -2
        }

        It 'Returns whole numbers as integers' {
            $Result = ConvertTo-NetherCoordinates -X 800 -Y 240
            $Result.X | Should -BeOfType [int]
            $Result.Y | Should -BeOfType [int]
        }
    }
}
