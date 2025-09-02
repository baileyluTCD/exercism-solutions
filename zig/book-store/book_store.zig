const std = @import("std");
const mem = std.mem;

pub fn total(basket: []const u32) u32 {
    var counts = std.mem.zeroes([5]u32);

    for (basket) |book| counts[book - 1] += 1;

    std.mem.sort(u32, &counts, {}, comptime std.sort.asc(u32));

    var groups = .{
        counts[4] - counts[3],
        counts[3] - counts[2],
        counts[2] - counts[1],
        counts[1] - counts[0],
        counts[0],
    };

    const adjust = @min(groups[4], groups[2]);

    groups[4] -= adjust;
    groups[2] -= adjust;

    groups[3] += 2 * adjust;

    return 8 * (100 * groups[0] +
        95 * 2 * groups[1] +
        90 * 3 * groups[2] +
        80 * 4 * groups[3] +
        75 * 5 * groups[4]);
}
