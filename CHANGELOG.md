# Changelog

## [0.2.0] - 2026-10-19

- Added `ConvertTo-ChunkCoordinates` and `ConvertTo-RegionCoordinates`, to convert block coordinates to their containing chunk/region.
- Added `Get-Distance`, to calculate the horizontal distance between two sets of coordinates.
- Added `Test-SlimeChunk`, to test whether the chunk containing a block coordinate is a slime chunk, for either Java (`-Seed`-based) or Bedrock (`-Edition Bedrock`, seed-independent) Edition.
- Added `ConvertTo-ExperiencePoints` and `ConvertTo-ExperienceLevel`, to convert between experience levels and total experience points.
- Added `ConvertTo-GameTicks` and `ConvertFrom-GameTicks`, to convert between real-world time and game ticks.
- Added `Set-MinecraftDefault` and `Get-MinecraftDefault`, to store and retrieve default values (Seed and/or Edition) used by other cmdlets when not explicitly supplied.

## [0.1.1] - 2026-10-19

- Renamed Y parameters to Z as Y in Minecraft is height (breaking change).
- Added `New-Coordinates`, to create a coordinates object with X and Z properties.

## [0.1.0] - 2026-10-19

- Renamed `Get-NetherCoordinates` to `ConvertTo-NetherCoordinates` (breaking change).
- Added `ConvertTo-OverworldCoordinates`, to convert Nether coordinates back to Overworld coordinates.

## [0.0.2] - 2026-10-13

- Initial release with `Get-NetherCoordinates`.
