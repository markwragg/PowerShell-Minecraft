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

        It 'ConvertTo-ChunkCoordinates -X requires an input' {
            { ConvertTo-ChunkCoordinates -X } | Should -Throw
        }
        It 'ConvertTo-ChunkCoordinates -X rejects non-numeric input' {
            { ConvertTo-ChunkCoordinates -X 'Hello' -Z 8 } | Should -Throw
        }
        It 'ConvertTo-ChunkCoordinates -Z requires an input' {
            { ConvertTo-ChunkCoordinates -X 8 -Z } | Should -Throw
        }
        It 'ConvertTo-ChunkCoordinates -Z rejects non-numeric input' {
            { ConvertTo-ChunkCoordinates -X 8 -Z 'World' } | Should -Throw
        }
        It 'ConvertTo-ChunkCoordinates requires both X and Z' {
            $Parameters = (Get-Command ConvertTo-ChunkCoordinates).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Z'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Divides positive X and Z coordinates by 16' {
            $Result = ConvertTo-ChunkCoordinates -X 48 -Z 160
            $Result.ChunkX | Should -Be 3
            $Result.ChunkZ | Should -Be 10
        }

        It 'Divides negative X and Z coordinates by 16' {
            $Result = ConvertTo-ChunkCoordinates -X -48 -Z -5
            $Result.ChunkX | Should -Be -3
            $Result.ChunkZ | Should -Be -1
        }

        It 'Accepts X and Z as positional parameters' {
            $Result = ConvertTo-ChunkCoordinates 160 32
            $Result.ChunkX | Should -Be 10
            $Result.ChunkZ | Should -Be 2
        }

        It 'Accepts X and Z via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 48; Z = -5 } | ConvertTo-ChunkCoordinates
            $Result.ChunkX | Should -Be 3
            $Result.ChunkZ | Should -Be -1
        }

        It 'Rounds down (not towards zero) for negative coordinates' {
            $Result = ConvertTo-ChunkCoordinates -X -1 -Z -16
            $Result.ChunkX | Should -Be -1
            $Result.ChunkZ | Should -Be -1
        }

        It 'Returns whole numbers as integers' {
            $Result = ConvertTo-ChunkCoordinates -X 48 -Z 160
            $Result.ChunkX | Should -BeOfType [int]
            $Result.ChunkZ | Should -BeOfType [int]
        }
    }
}
