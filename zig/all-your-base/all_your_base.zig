const std = @import("std");
const mem = std.mem;
const math = std.math;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

fn fromBaseN(digits: []const u32, n: u32) !u32 {
    if (n < 2) return ConversionError.InvalidInputBase;

    var it = std.mem.reverseIterator(digits);

    var value: u32 = 0;
    var power: u32 = 0;
    while (it.next()) |digit| {
        if (digit >= n) return ConversionError.InvalidDigit;

        value += digit * math.pow(u32, n, power);
        power += 1;
    }

    return value;
}

fn toBaseN(allocator: mem.Allocator, n: u32, value: u32) ![]u32 {
    if (n < 2) return ConversionError.InvalidOutputBase;

    var output: std.ArrayList(u32) = .empty;
    defer output.deinit(allocator);

    if (value == 0) {
        try output.append(allocator, 0);
        return output.toOwnedSlice(allocator);
    }

    var curr = value;
    while (curr > 0) {
        const rem = math.rem(u32, curr, n) catch {
            return ConversionError.InvalidOutputBase;
        };

        try output.append(allocator, rem);

        const mod = math.divFloor(u32, curr, n) catch {
            return ConversionError.InvalidOutputBase;
        };

        curr = mod;
    }

    return output.toOwnedSlice(allocator);
}

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    const value = try fromBaseN(digits, input_base);

    const output = try toBaseN(allocator, output_base, value);
    mem.reverse(u32, output);

    return output;
}
