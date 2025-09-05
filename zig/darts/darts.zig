const std = @import("std");
const math = std.math;

pub const Coordinate = struct {
    dart_x: f32,
    dart_y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{
            .dart_x = x_coord,
            .dart_y = y_coord,
        };
    }

    inline fn distToCenter(self: Coordinate) f32 {
        return @sqrt(math.pow(f32, self.dart_x, 2) + math.pow(f32, self.dart_y, 2));
    }

    pub fn score(self: Coordinate) usize {
        const dist = self.distToCenter();

        if (dist <= 1) return 10;
        if (dist <= 5) return 5;
        if (dist <= 10) return 1;

        return 0;
    }
};
