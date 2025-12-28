const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    const reverse = (number & 0b0001_0000 != 0);
    var list = std.ArrayList(Signal){};
    defer list.deinit(allocator);

    if (number & 0b0000_0001 != 0)
        try if (reverse) list.insert(allocator, 0, .wink) else list.append(allocator, .wink);
    if (number & 0b0000_0010 != 0)
        try if (reverse) list.insert(allocator, 0, .double_blink) else list.append(allocator, .double_blink);
    if (number & 0b0000_0100 != 0)
        try if (reverse) list.insert(allocator, 0, .close_your_eyes) else list.append(allocator, .close_your_eyes);
    if (number & 0b0000_1000 != 0)
        try if (reverse) list.insert(allocator, 0, .jump) else list.append(allocator, .jump);
    return list.toOwnedSlice(allocator);
}
