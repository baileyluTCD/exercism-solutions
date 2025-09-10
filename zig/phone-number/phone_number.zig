const std = @import("std");
const mem = std.mem;
const io = std.io;
const ascii = std.ascii;

pub fn clean(phrase: []const u8) ?[10]u8 {
    const stripped = mem.trimLeft(u8, phrase, "+1");

    var buf = mem.zeroes([10]u8);
    var writer = io.Writer.fixed(&buf);

    for (stripped) |char| if (ascii.isDigit(char))
        writer.writeByte(char) catch return null;

    if (buf[0] <= '1' or
        buf[3] <= '1' or
        writer.end != 10) return null;

    return buf;
}
