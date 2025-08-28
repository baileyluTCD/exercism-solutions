const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        const Self = @This();

        fn initializeAround(self: *Self, node: *Node) void {
            std.debug.assert(self.len == 0);

            self.first = node;
            self.last = node;
            self.len = 1;
        }

        pub fn push(self: *Self, node: *Node) void {
            if (self.len == 0) return self.initializeAround(node);

            const old = self.last;

            old.?.next = node;
            self.last = node;
            node.prev = old;

            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.len == 0) return null;

            const last = self.last;
            self.last = self.last.?.prev;

            self.len -= 1;

            return last;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            if (self.len == 0) return self.initializeAround(node);

            const old = self.first;

            old.?.prev = node;
            self.first = node;
            node.next = old;

            self.len += 1;
        }

        pub fn shift(self: *Self) ?*Node {
            if (self.len == 0) return null;

            const first = self.first;
            self.first = self.first.?.next;

            self.len -= 1;

            return first;
        }

        pub fn delete(self: *Self, node: *Node) void {
            if (node == self.first) {
                self.first = node.next;

                if (node.next) |next| next.prev = null;

                self.len -= 1;
            } else if (node == self.last) {
                self.last = node.prev;

                if (node.prev) |prev| prev.next = null;

                self.len -= 1;
            } else {
                if (node.prev) |prev| prev.next = node.next;
                if (node.next) |next| next.prev = node.prev;

                if (node.next != null or node.prev != null) self.len -= 1;
            }
        }
    };
}
