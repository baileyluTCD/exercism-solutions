const std = @import("std");
const mem = std.mem;
const pow = std.math.pow;

pub const Triplet = struct {
    a: usize,
    b: usize,
    c: usize,

    const Self = @This();

    pub fn isValid(a: usize, b: usize, c: usize) bool {
        return pow(usize, a, 2) + pow(usize, b, 2) == pow(usize, c, 2);
    }

    pub fn init(a: usize, b: usize, c: usize) Triplet {
        std.debug.assert(Self.isValid(a, b, c));

        return Self{
            .a = a,
            .b = b,
            .c = c,
        };
    }
};

pub fn tripletsWithSum(allocator: mem.Allocator, n: usize) mem.Allocator.Error![]Triplet {
    var found: std.ArrayList(Triplet) = .empty;
    defer found.deinit(allocator);

    for (3..n / 3) |a| {
        // a + b + c = n
        // a^2 + b^2 = c^2
        //
        // c = b - a - n
        // c^2 = a^2 + b^2
        //
        // (a^2 + b^2) = (b - a - n)^2
        // a^2 + b^2 = b^2 - ba - bn - ba + a^2 + an - bn + an + n^2
        // 0 = -2ba -2bn + 2an + n^2
        // 2ba + 2bn = 2an - n^2
        // 2b(n - a) = n(n - 2a)
        // b = n(n - 2a)/2(n - a)

        const b = n * (n - 2 * a) / (2 * (n - a));
        if (b > a) {
            const c = n - a - b;

            if (Triplet.isValid(a, b, c))
                try found.append(allocator, Triplet.init(a, b, c));
        }
    }

    return found.toOwnedSlice(allocator);
}
