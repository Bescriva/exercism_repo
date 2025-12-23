const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var count: usize = 0;
    var sum: usize = 0;

    for (s) |char| {
        if (count == 10) return false;
        sum += switch (char) {
            '-' => continue,
            '0'...'9' => (char - '0') * (10 - count),
            'X' => if (count == 9) 10 else return false,
            else => return false
        };
        count += 1;
    }

    return (count == 10 and sum % 11 == 0);
}
