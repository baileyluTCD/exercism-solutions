const std = @import("std");
const mem = std.mem;

const numerals = &[_]struct { i16, []const u8 }{
    .{ 1000, "M" },
    .{ 900, "CM" },
    .{ 500, "D" },
    .{ 400, "CD" },
    .{ 100, "C" },
    .{ 90, "XC" },
    .{ 50, "L" },
    .{ 40, "XL" },
    .{ 10, "X" },
    .{ 9, "IX" },
    .{ 5, "V" },
    .{ 4, "IV" },
    .{ 1, "I" },
};

pub fn toRoman(allocator: mem.Allocator, arabicNumeral: i16) mem.Allocator.Error![]u8 {
    var output: std.ArrayList(u8) = .empty;
    defer output.deinit(allocator);

    var current = arabicNumeral;
    var numerals_index: usize = 0;
    while (numerals_index < numerals.len and current != 0) {
        const numeral = numerals[numerals_index];

        if (@divFloor(current, numeral.@"0") >= 1) {
            try output.appendSlice(allocator, numeral.@"1");
            current -= numeral.@"0";
            numerals_index = 0;
        } else {
            numerals_index += 1;
        }
    }

    return output.toOwnedSlice(allocator);
}
