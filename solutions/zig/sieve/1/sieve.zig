pub fn primes(buffer: []u32, limit: u12) []u32 {
    if (limit < 2) return &.{};

    var i: usize = 0;
    var is_composite = [_]bool{false} ** 4096;

    for (2..limit + 1) |n| {
        if (is_composite[n])
            continue;
        buffer[i] = @intCast(n);
        i += 1;
        
        var multiple = n * 2;
        
        while (multiple <= limit) : (multiple += n) {
            is_composite[multiple] = true;
        }
    }

    return buffer[0..i];
}
