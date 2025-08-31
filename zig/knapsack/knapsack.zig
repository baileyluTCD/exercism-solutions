const std = @import("std");
const mem = std.mem;

pub const Item = struct {
    weight: usize,
    value: usize,

    const Self = @This();

    pub fn init(weight: usize, value: usize) Self {
        return Self{
            .weight = weight,
            .value = value,
        };
    }
};

pub fn maximumValue(allocator: mem.Allocator, maximumWeight: usize, items: []const Item) !usize {
    var weights = try allocator.alloc(usize, maximumWeight + 1);
    defer allocator.free(weights);

    @memset(weights, 0);

    for (items) |item| {
        var curr_weight = maximumWeight;

        while (item.weight <= curr_weight) : (curr_weight -= 1)
            weights[curr_weight] = @max(weights[curr_weight], weights[curr_weight - item.weight] + item.value);
    }

    return weights[maximumWeight];
}
