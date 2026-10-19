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

        It 'Set-MinecraftDefault -Seed requires an input' {
            { Set-MinecraftDefault -Seed } | Should -Throw
        }
        It 'Set-MinecraftDefault -Edition only accepts known editions' {
            { Set-MinecraftDefault -Edition 'Pocket' } | Should -Throw
        }
        It 'Set-MinecraftDefault requires at least one of -Seed or -Edition' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $false }
            { Set-MinecraftDefault } | Should -Throw
        }
    }

    Context 'Persistence Tests' {

        BeforeEach {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $false }
            Mock -CommandName New-Item -ModuleName $Module
            Mock -CommandName Set-Content -ModuleName $Module
            Mock -CommandName Get-Content -ModuleName $Module -MockWith { '{}' }
        }

        It 'Does not write to disk when -WhatIf is used' {
            Set-MinecraftDefault -Seed 12345 -WhatIf
            Should -Invoke -CommandName Set-Content -ModuleName $Module -Times 0
        }

        It 'Creates the .minecraft directory if it does not already exist' {
            Set-MinecraftDefault -Seed 12345 | Out-Null
            Should -Invoke -CommandName New-Item -ModuleName $Module -Times 1 -ParameterFilter {
                $Path -like '*.minecraft'
            }
        }

        It 'Writes the Seed value to the defaults file' {
            Set-MinecraftDefault -Seed 12345 | Out-Null
            Should -Invoke -CommandName Set-Content -ModuleName $Module -Times 1 -ParameterFilter {
                $Path -like '*defaults.json'
            }
        }

        It 'Returns the stored defaults when setting Seed' {
            $Result = Set-MinecraftDefault -Seed 12345
            $Result.Seed | Should -Be 12345
        }

        It 'Returns the stored defaults when setting Edition' {
            $Result = Set-MinecraftDefault -Edition Bedrock
            $Result.Edition | Should -Be 'Bedrock'
        }

        It 'Can set Seed and Edition together' {
            $Result = Set-MinecraftDefault -Seed 12345 -Edition Bedrock
            $Result.Seed | Should -Be 12345
            $Result.Edition | Should -Be 'Bedrock'
        }

        It 'Setting Edition alone does not remove a previously stored Seed' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $true }
            Mock -CommandName Get-Content -ModuleName $Module -MockWith { '{"Seed":12345}' }
            $Result = Set-MinecraftDefault -Edition Bedrock
            $Result.Seed | Should -Be 12345
            $Result.Edition | Should -Be 'Bedrock'
        }
    }
}
