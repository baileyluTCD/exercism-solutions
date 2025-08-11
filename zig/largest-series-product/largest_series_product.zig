const std = @import("std");
const fmt = std.fmt;

pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

fn calculateDigitProduct(digits: []const u8) SeriesError!u64 {
    var product: u64 = 1;

    for (digits) |digit| {
        const digit_string = [_]u8{digit};

        const digit_val = fmt.parseInt(u64, &digit_string, 10) catch {
            return SeriesError.InvalidCharacter;
        };

        product *= digit_val;
    }

    return product;
}

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    if (span < 0) return SeriesError.NegativeSpan;
    if (digits.len < span) return SeriesError.InsufficientDigits;

    var largest: u64 = 0;

    const span_usize: usize = @intCast(span);

    for (0..(digits.len - span_usize + 1)) |index| {
        const window = digits[index .. index + span_usize];

        const current = try calculateDigitProduct(window);

        if (current > largest) largest = current;
    }

    return largest;
}
