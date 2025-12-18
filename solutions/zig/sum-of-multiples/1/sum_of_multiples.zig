const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    if (limit <= 0)
        return 0;

    var points = try std.DynamicBitSet.initEmpty(allocator, limit);
    defer points.deinit();

    for (factors) |val| {
        if (val <= 0)
            continue;
        var n: usize = 0;
        while (n < limit) : (n += val)
            points.set(n);
    }
    var sm: u64 = 0;
    var iter = points.iterator(.{});
    
    while (iter.next()) |i|
        sm += i;
    return sm;
}
