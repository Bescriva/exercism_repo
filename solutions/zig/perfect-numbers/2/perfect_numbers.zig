const std = @import("std");
const assert = std.debug.assert;

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub fn classify(n: u64) Classification {
    assert(n > 0);
    if (n == 1) return .deficient;
    var sum: u64 = 1;

    for (2..std.math.sqrt(n) + 1) |i| {
        if (n % i == 0) {
            sum += i;
            if (i != n / i)
                sum += n / i;
        }
    }

    return if (n < sum) .abundant
        else if (n == sum) .perfect
        else .deficient;
}
