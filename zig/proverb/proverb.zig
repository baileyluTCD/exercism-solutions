const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    var output = try allocator.alloc([]u8, words.len);
    var line: usize = 1;

    while (line < words.len) : (line += 1)
        output[line - 1] = try fmt.allocPrint(
            allocator,
            "For want of a {s} the {s} was lost.\n",
            .{ words[line - 1], words[line] },
        );

    if (words.len > 0)
        output[words.len - 1] = try fmt.allocPrint(
            allocator,
            "And all for the want of a {s}.\n",
            .{words[0]},
        );

    return output;
}
