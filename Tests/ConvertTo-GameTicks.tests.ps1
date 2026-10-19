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

        It 'ConvertTo-GameTicks -Time requires an input' {
            { ConvertTo-GameTicks -Time } | Should -Throw
        }
        It 'ConvertTo-GameTicks requires Time' {
            $Parameters = (Get-Command ConvertTo-GameTicks).Parameters
            $Parameters['Time'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Converts a full day/night cycle to 24000 ticks' {
            ConvertTo-GameTicks -Time (New-TimeSpan -Minutes 20) | Should -Be 24000
        }

        It 'Converts 1 second to 20 ticks' {
            ConvertTo-GameTicks -Time (New-TimeSpan -Seconds 1) | Should -Be 20
        }

        It 'Accepts -Time via the pipeline' {
            (New-TimeSpan -Seconds 1) | ConvertTo-GameTicks | Should -Be 20
        }

        It 'Returns a whole number as a long' {
            ConvertTo-GameTicks -Time (New-TimeSpan -Seconds 1) | Should -BeOfType [long]
        }
    }
}
