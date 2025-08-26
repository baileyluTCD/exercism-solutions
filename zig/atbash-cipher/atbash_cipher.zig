const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;
const fixedBufferStream = std.io.fixedBufferStream;

fn transpose(letter: u8) u8 {
    if (ascii.isDigit(letter)) return letter;

    const alphabet_idx = if (ascii.isLower(letter)) letter - 'a' else letter - 'A';

    return (25 - alphabet_idx) + 'a';
}

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var out = try std.ArrayList(u8).initCapacity(allocator, s.len);

    var count: usize = 0;

    for (s) |letter| {
        if (!ascii.isAlphanumeric(letter)) continue;

        if (count != 0 and count % 5 == 0) try out.append(allocator, ' ');

        try out.append(allocator, transpose(letter));
        count += 1;
    }

    return out.toOwnedSlice(allocator);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var out = try std.ArrayList(u8).initCapacity(allocator, s.len);

    for (s) |letter| {
        if (!ascii.isAlphanumeric(letter)) continue;

        try out.append(allocator, transpose(letter));
    }

    return out.toOwnedSlice(allocator);
}
