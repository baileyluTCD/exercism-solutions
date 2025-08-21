/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    for (s, 0..) |char, idx| {
        buffer[s.len - idx - 1] = char;
    }

    return buffer[0..s.len];
}
