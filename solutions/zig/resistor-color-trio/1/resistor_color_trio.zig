const std = @import("std");
const mem = std.mem;

pub const ColorBand = enum(usize) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    const base: u128 = @intFromEnum(colors[0]) * 10 + @intFromEnum(colors[1]);
    const exp = @intFromEnum(colors[2]);
    const ohms: u128 = base * std.math.pow(u128, 10, exp);
    const unit: []const u8 = if (ohms >= 1_000_000_000) "giga"
        else if (ohms >= 1_000_000) "mega"
        else if (ohms >= 1_000) "kilo"
        else "";
    var f_ohms: f64 = @floatFromInt(ohms);
    if (f_ohms >= 1_000_000_000) {
        f_ohms /= 1_000_000_000;
    } else if (ohms >= 1_000_000) {
        f_ohms /= 1_000_000;
    } else if (ohms >= 1_000) {
        f_ohms /= 1_000;
    }

    return std.fmt.allocPrint(allocator, "{d} {s}ohms", .{f_ohms, unit});
}
