const std = @import("std");
const assert = std.debug.assert;

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub fn classify(n: u64) Classification {
    assert(n > 0);
    var sum: u64 = 0;

    for (1..n/2 + 1) |i| {
        if (n % i == 0)
            sum += i;
    }

    return if (n < sum) .abundant
        else if (n == sum) .perfect
        else .deficient;
}
