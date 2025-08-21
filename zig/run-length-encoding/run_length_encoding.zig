const std = @import("std");
const io = std.io;
const fixedBufferStream = std.io.fixedBufferStream;

inline fn writeCharWithCount(writer: anytype, char: u8, count: usize) void {
    if (count == 1) {
        writer.writeByte(char) catch unreachable;
    } else {
        writer.print("{any}{c}", .{ count, char }) catch unreachable;
    }
}

pub fn encode(buffer: []u8, string: []const u8) []u8 {
    if (string.len == 0) return &.{};

    var fbs = fixedBufferStream(buffer);
    var writer = fbs.writer();

    var count: usize = 0;
    var current: u8 = string[0];

    for (string) |char| {
        if (char == current) {
            count += 1;
            continue;
        }

        writeCharWithCount(&writer, current, count);

        count = 1;
        current = char;
    }

    writeCharWithCount(&writer, current, count);

    return buffer[0..fbs.pos];
}

pub fn decode(buffer: []u8, string: []const u8) []u8 {
    var fbs = fixedBufferStream(buffer);
    var writer = fbs.writer();

    var current_count: usize = 0;

    for (string) |byte| {
        switch (byte) {
            '0'...'9' => |ascii_num| {
                const num = ascii_num - '0';

                current_count *= 10;
                current_count += num;
            },
            else => |char| {
                if (current_count == 0) {
                    writer.writeByte(char) catch unreachable;
                } else {
                    writer.writeByteNTimes(char, current_count) catch unreachable;
                }

                current_count = 0;
            },
        }
    }

    return buffer[0..fbs.pos];
}
