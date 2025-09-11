const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;
const Io = std.Io;

fn rotateChar(char: u8, shiftKey: u5) u8 {
    if (!ascii.isAlphabetic(char)) return char;

    const isLower = ascii.isLower(char);

    const alphabet_idx = if (isLower) char - 'a' else char - 'A';

    const shifted_idx = (alphabet_idx + shiftKey) % 26;

    return if (isLower) shifted_idx + 'a' else shifted_idx + 'A';
}

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) ![]u8 {
    const output = try allocator.alloc(u8, text.len);
    var writer = Io.Writer.fixed(output);

    for (text) |char|
        try writer.writeByte(rotateChar(char, shiftKey));

    return output;
}
