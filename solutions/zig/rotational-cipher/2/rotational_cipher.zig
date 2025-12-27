const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    const result = try allocator.alloc(u8, text.len);

    for (text, 0..) |char, i| {
        result[i] = switch (char) {
            'A'...'Z' => (char - 'A' + shiftKey) % 26 + 'A',
            'a'...'z' => (char - 'a' + shiftKey) % 26 + 'a',
            else => char
        };
    }

    return (result);
}
