if (-not $PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$PSVersion = $PSVersionTable.PSVersion.Major

Describe "Unit Tests PS$PSVersion" {

    BeforeAll {
        $Root = "$PSScriptRoot/../"
        $Module = 'Minecraft'

        Get-Module $Module | Remove-Module -Force -ErrorAction SilentlyContinue
        Import-Module "$Root/$Module" -Force
    }

    Context 'Persistence Tests' {

        It 'Returns $null for a named default when no defaults file exists' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $false }
            Get-MinecraftDefault -Name 'Seed' | Should -BeNullOrEmpty
        }

        It 'Returns an empty object when no defaults file exists and no -Name is given' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $false }
            $Result = Get-MinecraftDefault
            $Result.Seed | Should -BeNullOrEmpty
        }

        It 'Returns the stored Seed value when the defaults file exists' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $true }
            Mock -CommandName Get-Content -ModuleName $Module -MockWith { '{"Seed":12345}' }
            Get-MinecraftDefault -Name 'Seed' | Should -Be 12345
        }

        It 'Returns all stored defaults when no -Name is given' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $true }
            Mock -CommandName Get-Content -ModuleName $Module -MockWith { '{"Seed":12345}' }
            (Get-MinecraftDefault).Seed | Should -Be 12345
        }

        It 'Returns the stored Edition value when the defaults file exists' {
            Mock -CommandName Test-Path -ModuleName $Module -MockWith { $true }
            Mock -CommandName Get-Content -ModuleName $Module -MockWith { '{"Seed":12345,"Edition":"Bedrock"}' }
            Get-MinecraftDefault -Name 'Edition' | Should -Be 'Bedrock'
        }
    }
}
