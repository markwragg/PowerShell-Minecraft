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

### ConvertTo-NetherCoordinates

Convert a pair of Overworld coordinates into their equivalent Nether coordinates, by dividing each value by 8 -- reflecting the Nether's 1:8 scale relative to the Overworld:

```powershell
ConvertTo-NetherCoordinates -X 800 -Z -400
```

Returns:

```
X   Z
-   -
100 -50
```

X and Z are positional, so they don't need to be named explicitly:

```powershell
ConvertTo-NetherCoordinates 1600 240
```

X and Z can also be supplied via the pipeline by property name:

```powershell
[pscustomobject]@{ X = 240; Z = 88 } | ConvertTo-NetherCoordinates
```

### ConvertTo-OverworldCoordinates

Convert a pair of Nether coordinates into their equivalent Overworld coordinates, by multiplying each value by 8:

```powershell
ConvertTo-OverworldCoordinates -X 100 -Z -50
```

Returns:

```
X   Z
-   -
800 -400
```

### New-Coordinates

Return a simple coordinates object with X and Z properties, e.g. for piping into `ConvertTo-NetherCoordinates` or `ConvertTo-OverworldCoordinates`:

```powershell
New-Coordinates -X 800 -Z -400
```

### ConvertTo-ChunkCoordinates / ConvertTo-RegionCoordinates

Convert block coordinates into the ChunkX/ChunkZ coordinates of the chunk (16x16 blocks), or the RegionX/RegionZ coordinates of the region file (32x32 chunks), that contains them:

```powershell
ConvertTo-ChunkCoordinates -X 48 -Z -5
```
```plaintext
ChunkX ChunkZ
------ ------
     3     -1
```
```powershell
ConvertTo-RegionCoordinates -X 600 -Z -5
```
```plaintext
RegionX RegionZ
------- -------
      1      -1
```

### Get-Distance

Return the horizontal block distance between two sets of coordinates:

```powershell
Get-Distance -From (New-Coordinates -X 0 -Z 0) -To (New-Coordinates -X 300 -Z 400)
```
```plaintext
500
```

### Test-SlimeChunk

Return whether the chunk containing the given block coordinates is a slime chunk, replicating each edition's own algorithm (`-Edition` defaults to `Java`). Any block coordinate within the same chunk returns the same result, so this can be fed directly from `New-Coordinates` or either of the Nether/Overworld converters. Java uses the world Seed; Bedrock doesn't depend on the seed at all, so `-Seed` is ignored when `-Edition Bedrock` is used:

```powershell
Test-SlimeChunk -Seed 12345 -X 48 -Z -32
```
```plaintext
False
```
```powershell
Test-SlimeChunk -Edition Bedrock -X 48 -Z -32
```
```plaintext
False
```

### ConvertTo-ExperiencePoints / ConvertTo-ExperienceLevel

Convert between a Minecraft experience level and the total experience points required to reach it:

```powershell
ConvertTo-ExperiencePoints -Level 30
```
```plaintext
1395
```
```powershell
ConvertTo-ExperienceLevel -Points 1200
```
```plaintext
Level Progress
----- --------
   28     0.14
```

### ConvertTo-GameTicks / ConvertFrom-GameTicks

Convert between real-world time and Minecraft game ticks (20 ticks per second; a full day/night cycle is 24000 ticks):

```powershell
ConvertTo-GameTicks -Time (New-TimeSpan -Minutes 20)
```
```plaintext
24000
```
```powershell
ConvertFrom-GameTicks -Ticks 24000
```
```plaintext
Days              : 0
Hours             : 0
Minutes           : 20
Seconds           : 0
Milliseconds      : 0
Ticks             : 12000000000
TotalDays         : 0.0138888888888889
TotalHours        : 0.333333333333333
TotalMinutes      : 20
TotalSeconds      : 1200
TotalMilliseconds : 1200000
```

### Set-MinecraftDefault / Get-MinecraftDefault

Store default values (currently Seed and Edition) in `$HOME/.minecraft/defaults.json`, so they don't need to be supplied on every call -- e.g. `Test-SlimeChunk -X 48 -Z -32` will then use the stored Seed/Edition automatically. Either can be set independently. Use `Get-MinecraftDefault` to view what's currently stored:

```powershell
Set-MinecraftDefault -Seed 12345 -Edition Bedrock
```

## Contributions

Code contributions via issues and/or pull requests are welcomed.
