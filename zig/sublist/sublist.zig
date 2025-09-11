const std = @import("std");
const mem = std.mem;

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

fn areEqual(a: []const i32, b: []const i32) bool {
    if (a.len != b.len) return false;

    return for (a, b) |x, y| {
        if (x != y) break false;
    } else true;
}

fn contains(a: []const i32, b: []const i32) bool {
    if (a.len < b.len) return false;
    if (b.len == 0) return true;

    var it = mem.window(i32, a, b.len, 1);

    return while (it.next()) |window| {
        if (areEqual(window, b)) break true;
    } else false;
}

pub fn compare(a: []const i32, b: []const i32) Relation {
    if (areEqual(a, b)) return Relation.equal;
    if (contains(a, b)) return Relation.superlist;
    if (contains(b, a)) return Relation.sublist;

    return Relation.unequal;
}
