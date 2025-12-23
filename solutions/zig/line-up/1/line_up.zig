
const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const ordinal: []const u8 = switch (number % 10) {
        1 => if (number % 100 == 11) "th" else "st",
        2 => if (number % 100 == 12) "th" else "nd",
        3 => if (number % 100 == 13) "th" else "rd",
        else => "th"
    };

    return std.fmt.allocPrint(allocator, "{s}, you are the {d}{s} customer we serve today. Thank you!", .{name, number, ordinal});
}
