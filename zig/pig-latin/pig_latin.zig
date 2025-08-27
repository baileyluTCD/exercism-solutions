const std = @import("std");
const mem = std.mem;

inline fn isVowel(char: u8) bool {
    return switch (char) {
        'a', 'e', 'i', 'o', 'u' => true,
        else => false,
    };
}

fn translateWord(allocator: mem.Allocator, output: *std.ArrayList(u8), word: []const u8) !void {
    if (isVowel(word[0]) or
        mem.startsWith(u8, word, "xr") or
        mem.startsWith(u8, word, "yt"))
    {
        try output.print(allocator, "{s}ay", .{word});
        return;
    }

    var consonant_count: usize = 0;
    while (!isVowel(word[consonant_count]) and
        word[consonant_count] != 'y' and
        !mem.startsWith(u8, word[consonant_count..], "qu"))
    {
        consonant_count += 1;
    }

    if (mem.startsWith(u8, word[consonant_count..], "qu")) {
        consonant_count += 2;
    }

    if (word[consonant_count] == 'y') {
        if (consonant_count == 0) {
            consonant_count += 1;
        } else {
            try output.print(allocator, "y{s}{s}ay", .{
                word[consonant_count + 1 ..],
                word[0..consonant_count],
            });

            return;
        }
    }

    try output.print(allocator, "{s}{s}ay", .{
        word[consonant_count..],
        word[0..consonant_count],
    });
}

pub fn translate(allocator: mem.Allocator, phrase: []const u8) mem.Allocator.Error![]u8 {
    var output: std.ArrayList(u8) = .empty;
    defer output.deinit(allocator);

    var word_it = mem.tokenizeAny(u8, phrase, " ");
    var print_space = false;

    while (word_it.next()) |word| {
        if (print_space) try output.append(allocator, ' ') else print_space = true;
        try translateWord(allocator, &output, word);
    }

    return output.toOwnedSlice(allocator);
}
