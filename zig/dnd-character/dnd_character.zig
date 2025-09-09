const std = @import("std");

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

inline fn rollDice() i8 {
    return std.Random.intRangeAtMost(
        std.crypto.random,
        i8,
        1,
        6,
    );
}

pub fn ability() i8 {
    var rolls = std.mem.zeroes([4]i8);
    var lowest_idx: usize = 0;
    var lowest_val: i8 = std.math.maxInt(i8);

    for (0..rolls.len) |idx| {
        const roll = rollDice();

        rolls[idx] = roll;

        if (roll < lowest_val) {
            lowest_idx = idx;
            lowest_val = roll;
        }
    }

    var sum: i8 = 0;
    for (rolls, 0..) |roll, idx| {
        if (idx != lowest_idx) sum += roll;
    }

    return sum;
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();

        return Character{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
        };
    }
};
