const std = @import("std");
const Io = std.Io;

const line =
    \\On the {s} day of Christmas my true love gave to me: 
;

const day = struct { []const u8, []const u8 };

const days: []const day = &.{
    .{ "twelfth", "twelve Drummers Drumming" },
    .{ "eleventh", "eleven Pipers Piping" },
    .{ "tenth", "ten Lords-a-Leaping" },
    .{ "ninth", "nine Ladies Dancing" },
    .{ "eighth", "eight Maids-a-Milking" },
    .{ "seventh", "seven Swans-a-Swimming" },
    .{ "sixth", "six Geese-a-Laying" },
    .{ "fifth", "five Gold Rings" },
    .{ "fourth", "four Calling Birds" },
    .{ "third", "three French Hens" },
    .{ "second", "two Turtle Doves" },
    .{ "first", "a Partridge in a Pear Tree" },
};

const end_idx = days.len - 1;

pub fn reciteVerse(writer: *Io.Writer, verse_idx: usize) !void {
    try writer.print(line, .{days[verse_idx].@"0"});

    for (verse_idx..end_idx) |idx| {
        try writer.print("{s}, ", .{days[idx].@"1"});
    }

    if (verse_idx == end_idx)
        try writer.print("{s}.", .{days[days.len - 1].@"1"})
    else
        try writer.print("and {s}.", .{days[days.len - 1].@"1"});
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    var writer = Io.Writer.fixed(buffer);

    for (start_verse..end_verse + 1) |verse| {
        reciteVerse(&writer, 12 - verse) catch continue;

        if (verse != end_verse)
            writer.writeByte('\n') catch continue;
    }

    return buffer[0..writer.end];
}
