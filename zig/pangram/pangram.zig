const std = @import("std");
const ascii = std.ascii;
const StaticBitSet = std.bit_set.StaticBitSet;

const full_set = StaticBitSet(26).initFull();

pub fn isPangram(str: []const u8) bool {
    var found = StaticBitSet(26).initEmpty();

    for (str) |letter| {
        if (!ascii.isAlphabetic(letter)) continue;

        const alphabet_pos = ascii.toLower(letter) - 'a';

        found.set(alphabet_pos);
    }

    return found.eql(full_set);
}
