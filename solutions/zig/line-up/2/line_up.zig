
const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const mod100 = number % 100;
    const ordinal: []const u8 =
        if (mod100 >= 11 and mod100 <= 13)
            "th"
        else switch (number % 10) {
            1 => "st",
            2 => "nd",
            3 => "rd",
            else => "th",
        };

    return std.fmt.allocPrint(allocator, "{s}, you are the {d}{s} customer we serve today. Thank you!", .{name, number, ordinal});
}
