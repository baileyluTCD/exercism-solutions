const std = @import("std");
const mem = std.mem;
const math = std.math;

const PrimeError = error{NoPrimeExists};

pub fn prime(allocator: mem.Allocator, n: usize) !usize {
    if (n == 1) return 2;
    if (n == 2) return 3;

    const max = (math.pow(usize, n, 2) - 3) / 2;
    const buf = try allocator.alloc(bool, max);
    defer allocator.free(buf);

    @memset(buf, true);

    var prime_count: usize = 2;
    for (buf, 0..) |is_prime, idx| {
        const current_number = (idx * 2) + 3;

        if (!is_prime) continue;

        if (prime_count == n) return current_number;
        prime_count += 1;

        var i: usize = idx + current_number;
        while (i < buf.len) : (i += current_number) {
            buf[i] = false;
        }
    }

    return PrimeError.NoPrimeExists;
}
