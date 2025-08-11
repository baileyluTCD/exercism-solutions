const std = @import("std");
const ascii = std.ascii;

const LettersSet = std.StaticBitSet(26);

inline fn isSkippableLetter(letter: u8) bool {
    return letter == ' ' or letter == '-';
}

inline fn toBitIndex(letter: u8) u8 {
    const uppercase = ascii.toUpper(letter);

    return uppercase - 65;
}

pub fn isIsogram(str: []const u8) bool {
    var found_letters = LettersSet.initEmpty();

    return for (str) |letter| {
        if (isSkippableLetter(letter))
            continue;

        const index = toBitIndex(letter);

        if (found_letters.isSet(index))
            break false;

        found_letters.set(index);
    } else true;
}
