const std = @import("std");
const math = std.math;

pub const ChessboardError = error{IndexOutOfBounds};

pub fn square(index: usize) ChessboardError!u64 {
    if (index == 0 or index > 64) return ChessboardError.IndexOutOfBounds;

    return math.pow(u64, 2, index - 1);
}

pub fn total() u64 {
    var sum: usize = 0;
    for (1..65) |i| sum += square(i) catch unreachable;
    return sum;
}
