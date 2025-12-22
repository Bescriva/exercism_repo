const std = @import("std");
const assert = std.debug.assert;
const bufPrint = std.fmt.bufPrint;

fn numToString(n: u32, capitalized: bool) []const u8 {
    return switch (n) {
        0 => if (capitalized) "No" else "no",
        1 => if (capitalized) "One" else "one",
        2 => if (capitalized) "Two" else "two",
        3 => if (capitalized) "Three" else "three",
        4 => if (capitalized) "Four" else "four",
        5 => if (capitalized) "Five" else "five",
        6 => if (capitalized) "Six" else "six",
        7 => if (capitalized) "Seven" else "seven",
        8 => if (capitalized) "Eight" else "eight",
        9 => if (capitalized) "Nine" else "nine",
        10 => if (capitalized) "Ten" else "ten",
        else => "unreachable",
    };
}

fn printLine(buffer: []u8, comptime fmt: []const u8, args: anytype) !usize {
    const line = try bufPrint(buffer, fmt, args);
    return line.len;
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    assert(start_bottles <= 10 and take_down <= start_bottles);

    var i = take_down;
    var bottles = start_bottles;
    var len: usize = 0;

    while (i > 0) : (i -= 1) {
    inline for (0..2) |_|
        len += try printLine(buffer[len..], "{s} green {s} hanging on the wall,\n", 
            .{numToString(bottles, true),  if (bottles == 1) "bottle" else "bottles"});
        len += try printLine(buffer[len..], "And if one green bottle should accidentally fall,\n", .{});
        len += try printLine(buffer[len..], "There'll be {s} green {s} hanging on the wall.", .{numToString(bottles - 1, false), if (bottles == 2) "bottle" else "bottles"});

        bottles -= 1;

        if (i != 1)
            len += try printLine(buffer[len..], "\n\n", .{});
    }
    return buffer[0..len];
}
