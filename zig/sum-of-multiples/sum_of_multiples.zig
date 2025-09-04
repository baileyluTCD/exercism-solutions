const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples = std.AutoHashMap(u32, void).init(allocator);
    defer multiples.deinit();

    for (factors) |factor| {
        if (factor == 0) continue;

        var curr = factor;
        while (curr < limit) : (curr += factor)
            try multiples.put(curr, {});
    }

    var total: u64 = 0;
    var it = multiples.keyIterator();
    while (it.next()) |multiple| {
        total += multiple.*;
    }

    return total;
}
