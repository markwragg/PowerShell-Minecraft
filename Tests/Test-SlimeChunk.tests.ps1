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

        It 'Test-SlimeChunk -X requires an input' {
            { Test-SlimeChunk -Seed 1 -X -Z 0 } | Should -Throw
        }
        It 'Test-SlimeChunk -Z requires an input' {
            { Test-SlimeChunk -Seed 1 -X 0 -Z } | Should -Throw
        }
        It 'Test-SlimeChunk requires both X and Z, but not Seed' {
            $Parameters = (Get-Command Test-SlimeChunk).Parameters
            $Parameters['X'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Z'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['Seed'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Not -Contain $true
        }
    }

    Context 'Algorithm Tests' {

        It 'Returns a deterministic result for a given seed and coordinate' {
            $Result1 = Test-SlimeChunk -Seed 999 -X 160 -Z -160
            $Result2 = Test-SlimeChunk -Seed 999 -X 160 -Z -160
            $Result1 | Should -Be $Result2
        }

        It 'Returns the expected result for a known seed and chunk (slime chunk)' {
            Test-SlimeChunk -Seed 1 -X 80 -Z 80 | Should -BeTrue
        }

        It 'Returns the expected result for a known seed and chunk (not a slime chunk)' {
            Test-SlimeChunk -Seed 999 -X 160 -Z -160 | Should -BeFalse
        }

        It 'Returns the same result for any block coordinate within the same chunk' {
            $Result1 = Test-SlimeChunk -Seed 1 -X 80 -Z 80
            $Result2 = Test-SlimeChunk -Seed 1 -X 95 -Z 89
            $Result1 | Should -Be $Result2
        }

        It 'Returns a different result for the same coordinate under a different seed' {
            $Result1 = Test-SlimeChunk -Seed 1 -X 80 -Z 80
            $Result2 = Test-SlimeChunk -Seed 2 -X 80 -Z 80
            $Result1 | Should -Not -Be $Result2
        }

        It 'Accepts X and Z via the pipeline by property name' {
            $Result = [pscustomobject]@{ X = 80; Z = 80 } | Test-SlimeChunk -Seed 1
            $Result | Should -BeTrue
        }

        It 'Returns approximately 10% true across many chunks (statistical sanity check)' {
            $TrueCount = 0
            $Total = 400
            for ($x = 0; $x -lt 20; $x++) {
                for ($z = 0; $z -lt 20; $z++) {
                    if (Test-SlimeChunk -Seed 12345 -X ($x * 16) -Z ($z * 16)) { $TrueCount++ }
                }
            }
            ($TrueCount / $Total) | Should -BeGreaterThan 0.05
            ($TrueCount / $Total) | Should -BeLessThan 0.15
        }
    }

    Context 'Default Seed Tests' {

        It 'Uses the stored default Seed when -Seed is not supplied' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Seed' } -MockWith { 1 }
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Edition' } -MockWith { $null }
            Test-SlimeChunk -X 80 -Z 80 | Should -BeTrue
        }

        It 'Throws when -Seed is not supplied and no default Seed has been stored' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -MockWith { $null }
            { Test-SlimeChunk -X 80 -Z 80 } | Should -Throw
        }

        It 'Uses an explicitly supplied -Seed instead of the stored default' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Seed' } -MockWith { 999 }
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Edition' } -MockWith { $null }
            Test-SlimeChunk -Seed 1 -X 80 -Z 80 | Should -BeTrue
        }
    }

    Context 'Default Edition Tests' {

        It 'Uses the stored default Edition when -Edition is not supplied' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Edition' } -MockWith { 'Bedrock' }
            Test-SlimeChunk -X 48 -Z 0 | Should -BeTrue
        }

        It 'Falls back to Java when no default Edition has been stored' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Edition' } -MockWith { $null }
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Seed' } -MockWith { 1 }
            Test-SlimeChunk -X 80 -Z 80 | Should -BeTrue
        }

        It 'Uses an explicitly supplied -Edition instead of the stored default' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module -ParameterFilter { $Name -eq 'Edition' } -MockWith { 'Java' }
            Test-SlimeChunk -Edition Bedrock -X 48 -Z 0 | Should -BeTrue
        }
    }

    Context 'Bedrock Edition Tests' {

        It 'Does not require -Seed and does not consult the stored default' {
            Mock -CommandName Get-MinecraftDefault -ModuleName $Module
            { Test-SlimeChunk -Edition Bedrock -X 48 -Z -32 } | Should -Not -Throw
            Should -Invoke -CommandName Get-MinecraftDefault -ModuleName $Module -Times 0
        }

        It 'Ignores an explicitly supplied -Seed' {
            $Result1 = Test-SlimeChunk -Edition Bedrock -Seed 1 -X 48 -Z 0
            $Result2 = Test-SlimeChunk -Edition Bedrock -Seed 2 -X 48 -Z 0
            $Result1 | Should -Be $Result2
        }

        It 'Returns the expected result for a known coordinate (slime chunk)' {
            Test-SlimeChunk -Edition Bedrock -X 48 -Z 0 | Should -BeTrue
        }

        It 'Returns the expected result for a known coordinate (not a slime chunk)' {
            Test-SlimeChunk -Edition Bedrock -X 48 -Z -32 | Should -BeFalse
        }

        It 'Returns the same result for any block coordinate within the same chunk' {
            $Result1 = Test-SlimeChunk -Edition Bedrock -X 48 -Z 0
            $Result2 = Test-SlimeChunk -Edition Bedrock -X 63 -Z 15
            $Result1 | Should -Be $Result2
        }

        It 'Returns approximately 10% true across many chunks (statistical sanity check)' {
            $TrueCount = 0
            $Total = 400
            for ($x = 0; $x -lt 20; $x++) {
                for ($z = 0; $z -lt 20; $z++) {
                    if (Test-SlimeChunk -Edition Bedrock -X ($x * 16) -Z ($z * 16)) { $TrueCount++ }
                }
            }
            ($TrueCount / $Total) | Should -BeGreaterThan 0.05
            ($TrueCount / $Total) | Should -BeLessThan 0.15
        }
    }
}
