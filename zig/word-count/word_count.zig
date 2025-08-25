const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;
const fixedBufferStream = std.io.fixedBufferStream;

pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    var found = std.StringHashMap(u32).init(allocator);

    const lower: []const u8 = try std.ascii.allocLowerString(allocator, s);
    defer allocator.free(lower);

    var iter = std.mem.tokenizeAny(u8, lower, " ,.:;|!&@$%^\n\t\r");

    while (iter.next()) |word| {
        const without_quotes = std.mem.trim(u8, word, "'");
        if (without_quotes.len == 0) continue;

        if (found.get(without_quotes)) |val| {
            try found.put(without_quotes, val + 1);
        } else {
            const key = try allocator.dupe(u8, without_quotes);
            try found.put(key, 1);
        }
    }

    return found;
}
