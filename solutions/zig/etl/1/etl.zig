const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var new = std.AutoHashMap(u8, i5).init(allocator);
    var iter = legacy.iterator();

    while (iter.next()) |entry| {
        const l_key = entry.key_ptr.*;
        const l_val = entry.value_ptr.*;

        for (l_val) |char|
            try new.put(std.ascii.toLower(char), l_key);
    }
    return (new);
}
