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

        It 'ConvertTo-ExperiencePoints -Level requires an input' {
            { ConvertTo-ExperiencePoints -Level } | Should -Throw
        }
        It 'ConvertTo-ExperiencePoints -Level rejects negative input' {
            { ConvertTo-ExperiencePoints -Level -1 } | Should -Throw
        }
        It 'ConvertTo-ExperiencePoints requires Level' {
            $Parameters = (Get-Command ConvertTo-ExperiencePoints).Parameters
            $Parameters['Level'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Calculates points for a level in the 0-15 range' {
            ConvertTo-ExperiencePoints -Level 10 | Should -Be 160
        }

        It 'Calculates points for a level in the 16-30 range' {
            ConvertTo-ExperiencePoints -Level 30 | Should -Be 1395
        }

        It 'Calculates points for a level of 31 or above' {
            ConvertTo-ExperiencePoints -Level 31 | Should -Be 1507
        }

        It 'Calculates points for level 0' {
            ConvertTo-ExperiencePoints -Level 0 | Should -Be 0
        }

        It 'Agrees at the boundary between the 0-15 and 16-30 formulas' {
            ConvertTo-ExperiencePoints -Level 16 | Should -Be 352
        }

        It 'Accepts -Level via the pipeline' {
            (30 | ConvertTo-ExperiencePoints) | Should -Be 1395
        }

        It 'Returns a whole number as an int' {
            ConvertTo-ExperiencePoints -Level 30 | Should -BeOfType [int]
        }
    }
}
