const std = @import("std");

pub const ColorBand = enum(usize) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

pub fn colorCode(color: ColorBand) usize {
    return @intFromEnum(color);
}

pub fn colors() []const ColorBand {
    return comptime blk: {
        var colors_list: []const ColorBand = &.{};

        for (std.meta.fields(ColorBand)) |color| {
            colors_list = colors_list ++ .{@as(ColorBand, @enumFromInt(color.value))};
        }

        break :blk colors_list;
    };
}
