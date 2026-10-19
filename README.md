# Powershell-Minecraft

[![Build Status](https://dev.azure.com/markwragg/GitHub/_apis/build/status/markwragg.Powershell-Minecraft?branchName=main)](https://dev.azure.com/markwragg/GitHub/_build/latest?definitionId=14&branchName=main)
![coverage](https://img.shields.io/badge/coverage-100%25-brightgreen.svg)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/minecraft?label=PS%20Gallery)](https://www.powershellgallery.com/packages/Minecraft)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/minecraft?color=D3D3D3)](https://www.powershellgallery.com/packages/Minecraft)

A PowerShell module of commands useful to Minecraft players, starting with coordinate conversion helpers.

![Minecraft PowerShell](Media/minecraft-powershell.jpeg)

## Requirements

- PowerShell 5.1 or newer.

## Installation

This module is published in the PowerShell Gallery so if you have PS5.1 or newer can be installed via:

```powershell
Install-Module Minecraft
```
## Usage Examples

1) `ConvertTo-NetherCoordinates -X 800 -Z -400`

Converts a pair of Overworld coordinates into their equivalent Nether coordinates, by dividing each value by 8 -- reflecting the Nether's 1:8 scale relative to the Overworld. Returns:

```
X   Z
-   -
100 -50
```

2) `ConvertTo-NetherCoordinates 1600 240`

X and Z are positional, so they don't need to be named explicitly.

3) `[pscustomobject]@{ X = 240; Z = 88 } | ConvertTo-NetherCoordinates`

X and Z can also be supplied via the pipeline by property name.

4) `ConvertTo-OverworldCoordinates -X 100 -Z -50`

Converts a pair of Nether coordinates into their equivalent Overworld coordinates, by multiplying each value by 8. Returns:

```
X   Z
-   -
800 -400
```

5) `New-Coordinates -X 800 -Z -400`

Returns a simple coordinates object with X and Z properties, e.g. for piping into `ConvertTo-NetherCoordinates` or `ConvertTo-OverworldCoordinates`.

6) `ConvertTo-ChunkCoordinates -X 48 -Z -5` / `ConvertTo-RegionCoordinates -X 600 -Z -5`

Converts block coordinates into the ChunkX/ChunkZ coordinates of the chunk (16x16 blocks), or the RegionX/RegionZ coordinates of the region file (32x32 chunks), that contains them.

7) `Get-Distance -From (New-Coordinates -X 0 -Z 0) -To (New-Coordinates -X 300 -Z 400)`

Returns 500, the horizontal block distance between two sets of coordinates.

8) `Test-SlimeChunk -Seed 12345 -X 48 -Z -32` / `Test-SlimeChunk -Edition Bedrock -X 48 -Z -32`

Returns whether the chunk containing the given block coordinates is a slime chunk, replicating each edition's own algorithm (`-Edition` defaults to `Java`). Any block coordinate within the same chunk returns the same result, so this can be fed directly from `New-Coordinates` or either of the Nether/Overworld converters. Java uses the world Seed; Bedrock doesn't depend on the seed at all, so `-Seed` is ignored when `-Edition Bedrock` is used.

9) `ConvertTo-ExperiencePoints -Level 30` / `ConvertTo-ExperienceLevel -Points 1200`

Converts between a Minecraft experience level and the total experience points required to reach it.

10) `ConvertTo-GameTicks -Time (New-TimeSpan -Minutes 20)` / `ConvertFrom-GameTicks -Ticks 24000`

Converts between real-world time and Minecraft game ticks (20 ticks per second; a full day/night cycle is 24000 ticks).

11) `Set-MinecraftDefault -Seed 12345 -Edition Bedrock`

Stores default values (currently Seed and Edition) in `$HOME/.minecraft/defaults.json`, so they don't need to be supplied on every call -- e.g. `Test-SlimeChunk -X 48 -Z -32` will then use the stored Seed/Edition automatically. Either can be set independently. Use `Get-MinecraftDefault` to view what's currently stored.

## Contributions

Code contributions via issues and/or pull requests are welcomed.
