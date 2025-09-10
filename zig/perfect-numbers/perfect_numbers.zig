const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    std.debug.assert(n != 0);

    var sum: usize = 0;
    for (1..n / 2 + 1) |val| {
        if (n % val == 0) sum += val;
    }

    return if (sum > n)
        Classification.abundant
    else if (sum < n)
        Classification.deficient
    else
        Classification.perfect;
}
