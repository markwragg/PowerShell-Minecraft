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

        It 'ConvertTo-ExperienceLevel -Points requires an input' {
            { ConvertTo-ExperienceLevel -Points } | Should -Throw
        }
        It 'ConvertTo-ExperienceLevel -Points rejects negative input' {
            { ConvertTo-ExperienceLevel -Points -1 } | Should -Throw
        }
        It 'ConvertTo-ExperienceLevel requires Points' {
            $Parameters = (Get-Command ConvertTo-ExperienceLevel).Parameters
            $Parameters['Points'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Returns level 0 and no progress for 0 points' {
            $Result = ConvertTo-ExperienceLevel -Points 0
            $Result.Level | Should -Be 0
            $Result.Progress | Should -Be 0
        }

        It 'Returns the exact level with no progress at a level boundary' {
            $Result = ConvertTo-ExperienceLevel -Points 1395
            $Result.Level | Should -Be 30
            $Result.Progress | Should -Be 0
        }

        It 'Returns the correct level and progress partway through a level' {
            $Result = ConvertTo-ExperienceLevel -Points 1200
            $Result.Level | Should -Be 28
            $Result.Progress | Should -Be 0.1373
        }

        It 'Accepts -Points via the pipeline' {
            (1395 | ConvertTo-ExperienceLevel).Level | Should -Be 30
        }

        It 'Is the inverse of ConvertTo-ExperiencePoints at a level boundary' {
            (ConvertTo-ExperiencePoints -Level 30 | ConvertTo-ExperienceLevel).Level | Should -Be 30
        }
    }
}
