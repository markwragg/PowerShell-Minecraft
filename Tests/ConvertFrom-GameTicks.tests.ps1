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

        It 'ConvertFrom-GameTicks -Ticks requires an input' {
            { ConvertFrom-GameTicks -Ticks } | Should -Throw
        }
        It 'ConvertFrom-GameTicks requires Ticks' {
            $Parameters = (Get-Command ConvertFrom-GameTicks).Parameters
            $Parameters['Ticks'].Attributes.Where({ $_ -is [Parameter] }).Mandatory | Should -Contain $true
        }
    }

    Context 'Conversion Tests' {

        It 'Converts 24000 ticks to a full day/night cycle' {
            (ConvertFrom-GameTicks -Ticks 24000) | Should -Be (New-TimeSpan -Minutes 20)
        }

        It 'Converts 20 ticks to 1 second' {
            (ConvertFrom-GameTicks -Ticks 20) | Should -Be (New-TimeSpan -Seconds 1)
        }

        It 'Accepts -Ticks via the pipeline' {
            (20 | ConvertFrom-GameTicks) | Should -Be (New-TimeSpan -Seconds 1)
        }

        It 'Is the inverse of ConvertTo-GameTicks' {
            $Time = New-TimeSpan -Minutes 20
            (ConvertTo-GameTicks -Time $Time | ConvertFrom-GameTicks) | Should -Be $Time
        }
    }
}
