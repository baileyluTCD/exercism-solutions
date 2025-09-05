const std = @import("std");
const mem = std.mem;

inline fn toUpper(letter: u8) u8 {
    return switch (letter) {
        'a'...'z' => letter - 32,
        else => letter,
    };
}

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var output: std.ArrayList(u8) = .empty;
    defer output.deinit(allocator);

    var words_it = mem.tokenizeAny(u8, words, " -_");
    while (words_it.next()) |word| {
        try output.append(allocator, toUpper(word[0]));
    }

    return output.toOwnedSlice(allocator);
}
