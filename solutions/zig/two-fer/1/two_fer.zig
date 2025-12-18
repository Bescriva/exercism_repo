
pub fn twoFer(buffer: []u8, name: ?[]const u8) ![]u8 {
    return try @import("std").fmt.bufPrint(buffer, "One for {s}, one for me.", .{name orelse "you"});
}
