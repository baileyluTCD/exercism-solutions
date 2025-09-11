const std = @import("std");

pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    if (limit <= 1) return &.{};

    var output = std.ArrayList(u32).initBuffer(buffer);
    var found = std.StaticBitSet(limit - 1).initFull();

    for (0..limit - 1) |pos| if (found.isSet(pos)) {
        const num = pos + 2;

        var curr = pos;
        while (curr < limit - 1) : (curr += num)
            found.unset(curr);

        output.appendAssumeCapacity(@intCast(num));
    };

    return output.items;
}
