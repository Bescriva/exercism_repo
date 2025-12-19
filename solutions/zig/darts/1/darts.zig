pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{.x = x_coord, .y = y_coord};
    }
    pub fn score(self: Coordinate) usize {
        const dist = @sqrt((self.x * self.x) + (self.y * self.y));
        return if (dist > 10) 0
            else if (dist > 5) 1
            else if (dist > 1) 5
            else 10;
    }
};
