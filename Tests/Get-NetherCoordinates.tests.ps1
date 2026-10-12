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

        It 'Get-NetherCoordinates -X requires an input' {
            { Get-NetherCoordinates -X } | Should -Throw
        }
        It 'Get-NetherCoordinates -X rejects non-numeric input' {
            { Get-NetherCoordinates -X 'Hello' -Y 8 } | Should -Throw
        }
        It 'Get-NetherCoordinates -Y requires an input' {
            { Get-NetherCoordinates -X 8 -Y } | Should -Throw
        }
        It 'Get-NetherCoordinates -Y rejects non-numeric input' {
            { Get-NetherCoordinates -X 8 -Y 'World' } | Should -Throw
        }
        It 'Get-NetherCoordinates requires both X and Y' {
            $Parameters = (Get-Command Get-NetherCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Y'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Divides positive X and Y coordinates by 8' {
            $Result = Get-NetherCoordinates -X 800 -Y 240
            $Result.X | Should -Be 100
            $Result.Y | Should -Be 30
        }

        It 'Divides negative X and Y coordinates by 8' {
            $Result = Get-NetherCoordinates -X -800 -Y -400
            $Result.X | Should -Be -100
            $Result.Y | Should -Be -50
        }

        It 'Accepts X and Y as positional parameters' {
            $Result = Get-NetherCoordinates 1600 88
            $Result.X | Should -Be 200
            $Result.Y | Should -Be 11
        }

        It 'Accepts X and Y via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 240; Y = 88 } | Get-NetherCoordinates
            $Result.X | Should -Be 30
            $Result.Y | Should -Be 11
        }

        It 'Rounds down to the nearest whole number when the result is not exact' {
            $Result = Get-NetherCoordinates -X 10 -Y 5
            $Result.X | Should -Be 1
            $Result.Y | Should -Be 0
        }

        It 'Rounds down (not towards zero) for negative coordinates' {
            $Result = Get-NetherCoordinates -X -1 -Y -10
            $Result.X | Should -Be -1
            $Result.Y | Should -Be -2
        }

        It 'Returns whole numbers as integers' {
            $Result = Get-NetherCoordinates -X 800 -Y 240
            $Result.X | Should -BeOfType [int]
            $Result.Y | Should -BeOfType [int]
        }
    }
}
