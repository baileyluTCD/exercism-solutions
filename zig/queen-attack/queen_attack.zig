const std = @import("std");
const math = std.math;

const HALF_RIGHT = math.pi / 4.0;

pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = packed struct {
    row: u3,
    col: u3,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        return Queen{
            .row = math.cast(u3, row) orelse return QueenError.InitializationFailure,
            .col = math.cast(u3, col) orelse return QueenError.InitializationFailure,
        };
    }

    inline fn castI4(self: Queen) struct { row: i4, col: i4 } {
        return .{ .row = @intCast(self.row), .col = @intCast(self.col) };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        const self_i4 = self.castI4();
        const other_i4 = other.castI4();

        return (self_i4.row == other_i4.row or self_i4.col == other_i4.col) or
            (self_i4.row - other_i4.row) == (self_i4.col - other_i4.col) or
            (self_i4.row - other_i4.row) == (other_i4.col - self_i4.col);
    }
};
