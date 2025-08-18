const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, count: usize) mem.Allocator.Error![][]u128 {
    const triangle = try allocator.alloc([]u128, count);

    for (0..count) |row| {
        const line = try allocator.alloc(u128, row + 1);

        for (0..line.len) |col| {
            line[col] = if (col == 0 or col == row) 1 else triangle[row - 1][col - 1] + triangle[row - 1][col];
        }

        triangle[row] = line;
    }

    return triangle;
}
