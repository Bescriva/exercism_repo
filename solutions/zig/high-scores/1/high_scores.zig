pub const HighScores = struct {
    scores: []const i32,

    pub fn init(scores: []const i32) HighScores {
        return HighScores {
            .scores = scores
        };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        if (self.scores.len <= 0)
            return null;
        return (self.scores[self.scores.len - 1]);
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        if (self.scores.len <= 0)
            return null;
        return (@import("std").mem.max(i32, self.scores));
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        var top: [3]i32 = .{0, 0, 0};
        var count: usize = 0;
        
        for (self.scores) |score| {
            if (score > top[0]) {
                top[2] = top[1];
                top[1] = top[0];
                top[0] = score;
            } else if (score > top[1]) {
                top[2] = top[1];
                top[1] = score;
            } else if (score > top[2]) {
                top[2] = score;
            }
            if (count < 3)
                count += 1;
        }
        return top[0..count];
    }
};
