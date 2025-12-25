const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var list = std.ArrayList(u64){};

    if (value <= 1) return list.toOwnedSlice(allocator);

    var n: u64 = value;
    var i: u64 = 2;

    while (i * i <= n) : (i += 1)
        while (n % i == 0) : (n /= i)
            try list.append(allocator, i);
    if (n > 1)
        try list.append(allocator, n);

    return list.toOwnedSlice(allocator);
}
