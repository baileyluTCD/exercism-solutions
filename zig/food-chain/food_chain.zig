const std = @import("std");
const io = std.io;

const verses = [_]struct { []const u8, []const u8 }{
    .{ "How absurd to swallow", "bird" },
    .{ "Imagine that, to swallow", "cat" },
    .{ "What a hog, to swallow", "dog" },
    .{ "Just opened her throat and swallowed", "goat" },
    .{ "I don't know how she swallowed", "cow" },
};

fn reciteVerse(stream: *io.FixedBufferStream([]u8), start_verse: usize) !void {
    if (start_verse == 8) {
        _ = try stream.write(
            \\I know an old lady who swallowed a horse.
            \\She's dead, of course!
        );
        return;
    }

    var writer = stream.writer();

    if (start_verse == 1) {
        try writer.writeAll("I know an old lady who swallowed a fly.\n");
    }

    if (start_verse == 2) {
        try writer.writeAll("I know an old lady who swallowed a spider.\n");
    }

    if (start_verse >= 3) {
        const first_verse = verses[start_verse - 3];

        try writer.print("I know an old lady who swallowed a {s}.\n", .{first_verse.@"1"});
        try writer.print("{s} a {s}!\n", .{ first_verse.@"0", first_verse.@"1" });

        var index = start_verse - 3;
        while (index > 0) : (index -= 1) {
            const subject = verses[index - 1].@"1";
            const prev_subject = verses[index].@"1";

            try writer.print("She swallowed the {s} to catch the {s}.\n", .{ prev_subject, subject });
        }
    }

    if (start_verse > 1) {
        if (start_verse > 2) {
            try writer.writeAll("She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n");
            try writer.writeAll("She swallowed the spider to catch the fly.\n");
        } else {
            try writer.writeAll(
                \\It wriggled and jiggled and tickled inside her.
                \\She swallowed the spider to catch the fly.
                \\
            );
        }
    }

    try writer.writeAll("I don't know why she swallowed the fly. Perhaps she'll die.");
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    var poem = io.fixedBufferStream(buffer);

    for (start_verse..end_verse + 1) |index| {
        reciteVerse(&poem, index) catch unreachable;

        if (index != end_verse) _ = poem.write("\n\n") catch unreachable;
    }

    return buffer[0..poem.pos];
}
