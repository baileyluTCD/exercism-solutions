const std = @import("std");

pub fn isBalanced(allocator: std.mem.Allocator, s: []const u8) !bool {
    var stack: std.ArrayList(u8) = .empty;
    defer stack.deinit(allocator);

    for (s) |c| switch (c) {
        '(' => try stack.append(allocator, ')'),
        '{', '[' => |opening| try stack.append(allocator, opening + 2),
        ']', '}', ')' => |closing| if (stack.pop() != closing) return false,
        else => {},
    };

    return stack.items.len == 0;
}
