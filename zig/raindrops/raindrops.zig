const std = @import("std");
const fixedBufferStream = std.io.fixedBufferStream;

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var fbs = fixedBufferStream(buffer);
    const writer = fbs.writer();

    const is_divisible_by = .{
        .@"3" = n % 3 == 0,
        .@"5" = n % 5 == 0,
        .@"7" = n % 7 == 0,
    };

    if (is_divisible_by.@"3") writer.print("Pling", .{}) catch unreachable;
    if (is_divisible_by.@"5") writer.print("Plang", .{}) catch unreachable;
    if (is_divisible_by.@"7") writer.print("Plong", .{}) catch unreachable;

    if (!is_divisible_by.@"3" and !is_divisible_by.@"5" and !is_divisible_by.@"7")
        writer.print("{}", .{n}) catch unreachable;

    return fbs.getWritten();
}
