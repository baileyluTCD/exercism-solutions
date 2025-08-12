const std = @import("std");
const io = std.io;

const verses = [_]struct { []const u8, []const u8 }{
    .{ "malt", "lay in" },
    .{ "rat", "ate" },
    .{ "cat", "killed" },
    .{ "dog", "worried" },
    .{ "cow with the crumpled horn", "tossed" },
    .{ "maiden all forlorn", "milked" },
    .{ "man all tattered and torn", "kissed" },
    .{ "priest all shaven and shorn", "married" },
    .{ "rooster that crowed in the morn", "woke" },
    .{ "farmer sowing his corn", "kept" },
    .{ "horse and the hound and the horn", "belonged to" },
};

fn reciteVerse(poem: *io.FixedBufferStream([]u8), start_verse: usize) void {
    var writer = poem.writer();

    _ = writer.write("This is") catch unreachable;

    var index = start_verse;
    while (index > 1) : (index -= 1) {
        const verse = verses[index - 2];

        writer.print(" the {s} that {s}", .{ verse.@"0", verse.@"1" }) catch unreachable;
    }

    _ = writer.write(" the house that Jack built.") catch unreachable;
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    var poem = io.fixedBufferStream(buffer);

    for (start_verse..end_verse + 1) |index| {
        reciteVerse(&poem, index);

        if (index != end_verse) _ = poem.write("\n") catch unreachable;
    }

    return buffer[0..poem.pos];
}
