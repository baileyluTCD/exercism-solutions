pub const Plant = enum(u8) {
    clover = 'C',
    grass = 'G',
    radishes = 'R',
    violets = 'V',
};

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const index = (student[0] - 'A') * 2;

    const wrap_point = (diagram.len / 2) + 1;

    return .{
        @enumFromInt(diagram[index]),
        @enumFromInt(diagram[index + 1]),
        @enumFromInt(diagram[index + wrap_point]),
        @enumFromInt(diagram[index + wrap_point + 1]),
    };
}
