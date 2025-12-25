pub fn clean(phrase: []const u8) ?[10]u8 {
    var buffer: [11]u8 = undefined;
    var count: usize = 0;

    for (phrase) |char| {
        if (count == 11) return null;
        if (char >= '0' and char <= '9') {
            buffer[count] = char;
            count += 1;
        }
    }

    if ((count == 11 and buffer[0] != '1') or count < 10)
        return null;

    const offset: usize = if (count == 11) 1 else 0;

    if (buffer[offset] < '2' or buffer[offset + 3] < '2')
        return null;

    return buffer[offset..][0..10].*;
}
