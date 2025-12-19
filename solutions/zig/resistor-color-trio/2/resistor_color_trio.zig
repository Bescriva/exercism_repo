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

const Unit = struct {
    threshold: u128,
    divisor: f64,
    prefix: []const u8,
};

const units = [_]Unit{
    .{ .threshold = 1_000_000_000, .divisor = 1_000_000_000.0, .prefix = "giga" },
    .{ .threshold = 1_000_000, .divisor = 1_000_000.0, .prefix = "mega" },
    .{ .threshold = 1_000, .divisor = 1_000.0, .prefix = "kilo" },
    .{ .threshold = 0, .divisor = 1.0, .prefix = "" },
};

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    const base: u128 = @intFromEnum(colors[0]) * 10 + @intFromEnum(colors[1]);
    const exp = @intFromEnum(colors[2]);
    const ohms: u128 = base * std.math.pow(u128, 10, exp);

    var f_ohms: f64 = @floatFromInt(ohms);
    var prefix: []const u8 = "";

    for (units) |unit| {
        if (ohms >= unit.threshold) {
            f_ohms /= unit.divisor;
            prefix = unit.prefix;
            break;
        }
    }

    return std.fmt.allocPrint(allocator, "{d} {s}ohms", .{f_ohms, prefix});
}
