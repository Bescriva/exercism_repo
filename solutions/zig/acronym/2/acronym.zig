const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var list = std.ArrayList(u8){};
    defer list.deinit(allocator);

    var it = mem.tokenizeAny(u8, words, " -_");
    while (it.next()) |word| {
        if (word.len > 0)
            try list.append(allocator, std.ascii.toUpper(word[0]));
    }
    return list.toOwnedSlice(allocator);
}
