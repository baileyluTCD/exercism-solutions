const std = @import("std");
const mem = std.mem;

inline fn toInt(digit: u8) u8 {
    return digit - '0';
}

inline fn isAllowed(digit: u8) bool {
    return ('0' <= digit and digit <= '9') or digit == ' ';
}

inline fn isOdd(a: usize) bool {
    return @rem(a, 2) == 1;
}

pub fn isValid(s: []const u8) bool {
    var non_space_digit_count: usize = 0;
    var sum: usize = 0;

    var it = mem.reverseIterator(s);

    while (it.next()) |digit| {
        if (!isAllowed(digit)) return false;
        if (digit == ' ') continue;

        const value = if (isOdd(non_space_digit_count)) toInt(digit) * 2 else toInt(digit);

        sum += if (value > 9) value - 9 else value;

        non_space_digit_count += 1;
    }

    if (non_space_digit_count <= 1) return false;

    return sum % 10 == 0;
}
