function Get-Mt19937FirstUInt32 {
    <#
    .SYNOPSIS
        Returns the first 32-bit value produced by a Mersenne Twister (MT19937) PRNG for a given seed.

    .DESCRIPTION
        Implements the standard MT19937 algorithm just far enough to extract the very first tempered
        output, which is all that Test-SlimeChunk needs for Bedrock Edition's slime-chunk check. A full
        implementation would track an index and lazily re-twist every 624 values, but since only one
        value is ever drawn here, the state is seeded, twisted once, and the first word is tempered and
        returned directly.
    #>
    [CmdletBinding()]
    [OutputType([System.Numerics.BigInteger])]
    Param(
        # The 32-bit (0 to 2^32-1) seed to initialize the generator with.
        [Parameter(Mandatory)]
        [System.Numerics.BigInteger]
        $Seed
    )
    # A hex literal with its top bit set (e.g. 0x80000000) parses as a *signed* Int32 in PowerShell, so
    # casting it straight to BigInteger carries that sign through as infinite-precision two's complement --
    # corrupting every -band/-bxor against a value with bits set above position 31. The L suffix forces
    # Int64 parsing first, which (unlike the cast) correctly zero-extends the 32-bit pattern as positive.
    $Mask32 = [System.Numerics.BigInteger]::Pow(2, 32)
    $UpperMask = [System.Numerics.BigInteger]0x80000000L
    $LowerMask = [System.Numerics.BigInteger]0x7fffffffL
    $MatrixA = [System.Numerics.BigInteger]0x9908b0dfL

    $StateSize = 624
    $Offset = 397

    $State = [System.Numerics.BigInteger[]]::new($StateSize)
    $State[0] = $Seed % $Mask32
    for ($i = 1; $i -lt $StateSize; $i++) {
        $Previous = $State[$i - 1]
        $State[$i] = ((1812433253 * ($Previous -bxor ($Previous -shr 30))) + $i) % $Mask32
    }

    # The standard twist pass, applied once since only the first output word is ever needed.
    for ($i = 0; $i -lt $StateSize; $i++) {
        $Combined = ($State[$i] -band $UpperMask) -bor ($State[($i + 1) % $StateSize] -band $LowerMask)
        $Shifted = $Combined -shr 1
        if (($Combined % 2) -ne 0) {
            $Shifted = $Shifted -bxor $MatrixA
        }
        $State[$i] = $State[($i + $Offset) % $StateSize] -bxor $Shifted
    }

    $Value = $State[0]
    $Value = $Value -bxor ($Value -shr 11)
    $Value = $Value -bxor (($Value -shl 7) -band 0x9D2C5680L)
    $Value = $Value -bxor (($Value -shl 15) -band 0xEFC60000L)
    $Value = $Value -bxor ($Value -shr 18)
    $Value % $Mask32
}
