const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var list = std.ArrayList(u8){};
    defer list.deinit(allocator);

    var b: bool = true;
    for (words) |char| {
        if (b == true and std.ascii.isAlphabetic(char)) {
            try list.append(allocator, std.ascii.toUpper(char));
            b = false;
        }
        else if (char == ' ' or char == '-')
            b = true;
    }
    return list.toOwnedSlice(allocator);
}
