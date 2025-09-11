const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u5) {
    wink = 1 << 0,
    double_blink = 1 << 1,
    close_your_eyes = 1 << 2,
    jump = 1 << 3,
};

const reverse = 1 << 4;

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var found: std.ArrayList(Signal) = .empty;
    defer found.deinit(allocator);

    inline for (std.meta.fields(Signal)) |field| if (number & field.value != 0) {
        try found.append(allocator, @enumFromInt(field.value));
    };

    const should_reverse = number & reverse != 0;

    return if (should_reverse) rev: {
        const items = try found.toOwnedSlice(allocator);
        mem.reverse(Signal, items);
        break :rev items;
    } else found.toOwnedSlice(allocator);
}
