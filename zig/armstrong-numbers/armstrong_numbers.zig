const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    var count: usize = 0;
    var curr = num;
    while (curr > 0) : (curr = curr / 10) count += 1;

    var sum: u128 = 0;
    curr = num;
    while (curr > 0) : (curr = curr / 10) {
        const digit = @rem(curr, 10);

        sum += std.math.pow(u128, digit, count);
    }

    return num == sum;
}
