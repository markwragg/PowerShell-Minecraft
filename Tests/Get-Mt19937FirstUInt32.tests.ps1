if (-not $PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$PSVersion = $PSVersionTable.PSVersion.Major

Describe "Unit Tests PS$PSVersion" {

    BeforeAll {
        $Root = "$PSScriptRoot/../"
        $Module = 'Minecraft'

        Get-Module $Module | Remove-Module -Force -ErrorAction SilentlyContinue
        Import-Module "$Root/$Module" -Force
    }

    Context 'Algorithm Tests' {

        It 'Matches the canonical MT19937 reference value for the default seed 5489' {
            InModuleScope $Module {
                Get-Mt19937FirstUInt32 -Seed 5489 | Should -Be 3499211612
            }
        }

        It 'Returns a value that fits in 32 bits' {
            InModuleScope $Module {
                $Result = Get-Mt19937FirstUInt32 -Seed 12345
                $Result | Should -BeGreaterOrEqual 0
                $Result | Should -BeLessOrEqual ([System.Numerics.BigInteger]::Pow(2, 32) - 1)
            }
        }

        It 'Is deterministic for a given seed' {
            InModuleScope $Module {
                (Get-Mt19937FirstUInt32 -Seed 777) | Should -Be (Get-Mt19937FirstUInt32 -Seed 777)
            }
        }

        It 'Returns a different value for a different seed' {
            InModuleScope $Module {
                (Get-Mt19937FirstUInt32 -Seed 1) | Should -Not -Be (Get-Mt19937FirstUInt32 -Seed 2)
            }
        }
    }
}
