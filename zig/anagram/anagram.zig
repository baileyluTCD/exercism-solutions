const std = @import("std");
const mem = std.mem;

const AlphabetMap = [26]u8;

fn mkAlphabetSet(word: []const u8) AlphabetMap {
    var letters: AlphabetMap = std.mem.zeroes(AlphabetMap);

    for (word) |letter| letters[std.ascii.toLower(letter) - 'a'] += 1;

    return letters;
}

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var anagrams = std.BufSet.init(allocator);

    const expected_letters = mkAlphabetSet(word);

    for (candidates) |candidate| {
        if (std.ascii.eqlIgnoreCase(word, candidate)) continue;

        const candidate_letters = mkAlphabetSet(candidate);

        if (std.meta.eql(expected_letters, candidate_letters))
            try anagrams.insert(candidate);
    }

    return anagrams;
}
