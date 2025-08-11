const bufPrint = @import("std").fmt.bufPrint;

pub fn twoFer(buffer: []u8, name: ?[]const u8) anyerror![]u8 {
    const noun = name orelse "you";

    return bufPrint(buffer, "One for {s}, one for me.", .{noun});
}
