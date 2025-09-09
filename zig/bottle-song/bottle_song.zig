const std = @import("std");
const ascii = std.ascii;
const io = std.io;

const terms = [_][]const u8{
    "No",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
};

const curr_line = .{
    .singular = "{s} green bottle hanging on the wall,\n",
    .plural = "{s} green bottles hanging on the wall,\n",
};

const fall_line = "And if one green bottle should accidentally fall,\n";

const next_line = .{
    .singular = "There'll be {c}{s} green bottle hanging on the wall.",
    .plural = "There'll be {c}{s} green bottles hanging on the wall.",
};

fn reciteVerse(writer: *io.Writer, verse: usize) !void {
    const curr = terms[verse];
    const next = terms[verse - 1];

    for (0..2) |_| if (verse == 1)
        try writer.print(curr_line.singular, .{curr})
    else
        try writer.print(curr_line.plural, .{curr});

    try writer.writeAll(fall_line);

    const lower_first_character = ascii.toLower(next[0]);

    if (verse == 2)
        try writer.print(next_line.singular, .{ lower_first_character, next[1..] })
    else
        try writer.print(next_line.plural, .{ lower_first_character, next[1..] });
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) []const u8 {
    var writer = io.Writer.fixed(buffer);

    for (0..take_down) |taken_down| {
        reciteVerse(&writer, start_bottles - taken_down) catch continue;

        if (taken_down != take_down - 1)
            writer.writeAll("\n\n") catch continue;
    }

    return writer.buffer[0..writer.end];
}
