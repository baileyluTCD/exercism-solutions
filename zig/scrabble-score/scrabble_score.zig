const std = @import("std");

inline fn scoreLetter(letter: u8) u32 {
    const fixed_case = std.ascii.toLower(letter);

    return switch (fixed_case) {
        'a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't' => 1,
        'd', 'g' => 2,
        'b', 'c', 'm', 'p' => 3,
        'f', 'h', 'v', 'w', 'y' => 4,
        'k' => 5,
        'j', 'x' => 8,
        'q', 'z' => 10,
        else => 0,
    };
}

pub fn score(s: []const u8) u32 {
    var sum: u32 = 0;

    for (s) |letter| sum += scoreLetter(letter);

    return sum;
}
