# Powershell-Minecraft

[![Build Status](https://dev.azure.com/markwragg/GitHub/_apis/build/status/markwragg.Powershell-Minecraft?branchName=main)](https://dev.azure.com/markwragg/GitHub/_build/latest?definitionId=1&branchName=main)
![coverage](https://img.shields.io/badge/coverage-100%25-brightgreen.svg)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/xkcd?label=PS%20Gallery)](https://www.powershellgallery.com/packages/Minecraft)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/minecraft?color=D3D3D3)](https://www.powershellgallery.com/packages/Minecraft)

A PowerShell module of commands useful to Minecraft players, starting with coordinate conversion helpers.

![Minecraft PowerShell](Media/minecraft-powershell.jpeg)

## Requirements

- PowerShell 1.0 or newer.

## Installation

This module is published in the PowerShell Gallery so if you have PS5.1 or newer can be installed via:

```powershell
Install-Module Minecraft
```
## Usage Examples

1) `Get-NetherCoordinates -X 800 -Y -400`

Converts a pair of Overworld coordinates into their equivalent Nether coordinates, by dividing each value by 8 -- reflecting the Nether's 1:8 scale relative to the Overworld. Returns:

```
X   Y
-   -
100 -50
```

2) `Get-NetherCoordinates 1600 240`

X and Y are positional, so they don't need to be named explicitly.

3) `[pscustomobject]@{ X = 240; Y = 88 } | Get-NetherCoordinates`

X and Y can also be supplied via the pipeline by property name.

## Contributions

Code contributions via issues and/or pull requests are welcomed.
