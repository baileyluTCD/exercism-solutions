const std = @import("std");
const mem = std.mem;
const math = std.math;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var found: std.ArrayList(u64) = .empty;
    defer found.deinit(allocator);

    var curr: u64 = value;
    var divisor: u64 = 2;

    while (divisor * divisor <= curr) if (curr % divisor == 0) {
        try found.append(allocator, divisor);

        curr /= divisor;
    } else {
        divisor += 1;
    };

    if (curr > 1) try found.append(allocator, curr);

    return found.toOwnedSlice(allocator);
}
