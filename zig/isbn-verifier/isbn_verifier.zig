const std = @import("std");
const ascii = std.ascii;

pub fn isValidIsbn10(s: []const u8) bool {
    var curr: usize = 10;
    var sum: usize = 0;

    for (s, 0..) |char, idx| {
        if (char == '-') continue;

        const is_allowed_char = if (idx == s.len - 1)
            ascii.isDigit(char) or char == 'X'
        else
            ascii.isDigit(char);

        if (curr == 0 or !is_allowed_char) return false;

        const digit = if (char == 'X') 10 else char - '0';

        sum += digit * curr;
        curr -= 1;
    }

    return (sum % 11 == 0) and (curr == 0);
}
