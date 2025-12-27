const std = @import("std");
const mem = std.mem;
const allocPrint = std.fmt.allocPrint;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    if (words.len == 0) return &.{};

    var i: usize = 0;
    const result = try allocator.alloc([]u8, words.len);
    errdefer {
        for (result[0..i]) |str|
            allocator.free(str);
        allocator.free(result);
    }

    while (i < words.len - 1) : (i += 1)
        result[i] = try allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{words[i], words[i + 1]});
    result[i] = try allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
    
    return result;
}
