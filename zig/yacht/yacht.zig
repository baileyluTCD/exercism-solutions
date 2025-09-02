const std = @import("std");
const mem = std.mem;

pub const Category = enum(u32) {
    ones = 1,
    twos = 2,
    threes = 3,
    fours = 4,
    fives = 5,
    sixes = 6,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    switch (category) {
        .ones, .twos, .threes, .fours, .fives, .sixes => |idx| {
            const num_to_look_for: u3 = @intCast(@intFromEnum(idx));
            var count_of_num: u32 = 0;

            for (dice) |die| {
                if (die == num_to_look_for) count_of_num += 1;
            }

            return count_of_num * num_to_look_for;
        },
        .full_house, .four_of_a_kind => |max_allowed| {
            const a: u32 = dice[0];
            var b: ?u32 = null;

            var a_count: u32 = 1;

            var current_score: u32 = a;

            for (dice[1..]) |die| {
                if (die == a) {
                    a_count += 1;
                } else if (b == null) {
                    b = die;
                } else if (die != b) {
                    return 0;
                }

                current_score += die;
            }

            if (max_allowed == .full_house) {
                return if (a_count == 2 or a_count == 3) current_score else 0;
            } else {
                if (a_count == 1) return (b orelse 0) * 4;
                return if (a_count >= 4) a * 4 else 0;
            }
        },
        .little_straight, .big_straight => |straight| {
            var sorted: [5]u3 = undefined;
            @memcpy(&sorted, &dice);
            mem.sort(u3, &sorted, {}, comptime std.sort.asc(u3));

            var last: u32 = sorted[0];
            if (straight == .little_straight and last != 1) return 0;
            if (straight == .big_straight and last != 2) return 0;

            for (sorted[1..]) |die| {
                if (die - last != 1) return 0;

                last = die;
            }

            return 30;
        },
        .choice => {
            var current_score: u32 = 0;

            for (dice) |die| current_score += die;

            return current_score;
        },
        .yacht => {
            const num_to_look_for: u32 = dice[0];

            for (dice[1..]) |die|
                if (die != num_to_look_for) return 0;

            return 50;
        },
    }
}
