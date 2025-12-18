/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    var i: usize = 0;
    var iter = @import("std").mem.reverseIterator(s);

    while (iter.next()) |char| {
        buffer[i] = char;
        i += 1;
    }

    return buffer[0..s.len];
}
