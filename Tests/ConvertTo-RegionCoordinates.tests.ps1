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

        It 'ConvertTo-RegionCoordinates -X requires an input' {
            { ConvertTo-RegionCoordinates -X } | Should -Throw
        }
        It 'ConvertTo-RegionCoordinates -X rejects non-numeric input' {
            { ConvertTo-RegionCoordinates -X 'Hello' -Z 8 } | Should -Throw
        }
        It 'ConvertTo-RegionCoordinates -Z requires an input' {
            { ConvertTo-RegionCoordinates -X 8 -Z } | Should -Throw
        }
        It 'ConvertTo-RegionCoordinates -Z rejects non-numeric input' {
            { ConvertTo-RegionCoordinates -X 8 -Z 'World' } | Should -Throw
        }
        It 'ConvertTo-RegionCoordinates requires both X and Z' {
            $Parameters = (Get-Command ConvertTo-RegionCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Z'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Divides positive X and Z coordinates by 512' {
            $Result = ConvertTo-RegionCoordinates -X 600 -Z 1024
            $Result.RegionX | Should -Be 1
            $Result.RegionZ | Should -Be 2
        }

        It 'Divides negative X and Z coordinates by 512' {
            $Result = ConvertTo-RegionCoordinates -X -600 -Z -5
            $Result.RegionX | Should -Be -2
            $Result.RegionZ | Should -Be -1
        }

        It 'Accepts X and Z as positional parameters' {
            $Result = ConvertTo-RegionCoordinates 1024 512
            $Result.RegionX | Should -Be 2
            $Result.RegionZ | Should -Be 1
        }

        It 'Accepts X and Z via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 600; Z = -5 } | ConvertTo-RegionCoordinates
            $Result.RegionX | Should -Be 1
            $Result.RegionZ | Should -Be -1
        }

        It 'Returns whole numbers as integers' {
            $Result = ConvertTo-RegionCoordinates -X 600 -Z 1024
            $Result.RegionX | Should -BeOfType [int]
            $Result.RegionZ | Should -BeOfType [int]
        }
    }
}
