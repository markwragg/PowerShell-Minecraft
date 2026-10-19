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

        It 'Get-Distance -From requires an input' {
            { Get-Distance -From } | Should -Throw
        }
        It 'Get-Distance -To requires an input' {
            { Get-Distance -From ([pscustomobject]@{ X = 0; Z = 0 }) -To } | Should -Throw
        }
        It 'Get-Distance requires both From and To' {
            $Parameters = (Get-Command Get-Distance).Parameters
            $Parameters['From'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
            $Parameters['To'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Calculation Tests' {

        It 'Calculates the distance between two points using a 3-4-5 triangle' {
            $From = [pscustomobject]@{ X = 0; Z = 0 }
            $To = [pscustomobject]@{ X = 300; Z = 400 }
            Get-Distance -From $From -To $To | Should -Be 500
        }

        It 'Calculates the distance between two negative points' {
            $From = [pscustomobject]@{ X = -100; Z = -100 }
            $To = [pscustomobject]@{ X = -100; Z = -100 }
            Get-Distance -From $From -To $To | Should -Be 0
        }

        It 'Accepts -From via the pipeline' {
            $To = [pscustomobject]@{ X = 300; Z = 400 }
            $Result = [pscustomobject]@{ X = 0; Z = 0 } | Get-Distance -To $To
            $Result | Should -Be 500
        }

        It 'Rounds the result to 2 decimal places' {
            $From = [pscustomobject]@{ X = 0; Z = 0 }
            $To = [pscustomobject]@{ X = 1; Z = 1 }
            Get-Distance -From $From -To $To | Should -Be 1.41
        }
    }
}
