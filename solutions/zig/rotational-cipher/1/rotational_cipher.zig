const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    const result = try allocator.alloc(u8, text.len);

    for (text, 0..) |char, i| {
        if (char >= 'a' and char <= 'z') {
            result[i] = (char - 'a' + shiftKey) % 26 + 'a';
        } else if (char >= 'A' and char <= 'Z') {
            result[i] = (char - 'A' + shiftKey) % 26 + 'A';
        } else
            result[i] = char;
    }

    return (result);
}
