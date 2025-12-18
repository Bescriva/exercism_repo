const std = @import("std");

pub fn score(s: []const u8) u32 {
    var scr: u32 = 0;
    for (s) |char| {
        if (!std.ascii.isAlphabetic(char))
            continue;
        const upper = std.ascii.toUpper(char);
        scr += switch (upper) {
            'Q', 'Z' => 10,
            'J', 'X' => 8,
            'K' => 5,
            'F', 'H', 'V', 'W', 'Y' => 4,
            'B', 'C', 'M', 'P' => 3,
            'D', 'G' => 2,
            else => 1,
        };
    }
    return scr;
}
