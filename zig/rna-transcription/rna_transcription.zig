const std = @import("std");
const mem = std.mem;

inline fn strandToRna(strand: u8) u8 {
    return switch (strand) {
        'G' => 'C',
        'C' => 'G',
        'T' => 'A',
        'A' => 'U',
        else => unreachable,
    };
}

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var output = try std.ArrayList(u8).initCapacity(allocator, dna.len);
    defer output.deinit(allocator);

    for (dna) |strand| try output.append(allocator, strandToRna(strand));

    return output.toOwnedSlice(allocator);
}
