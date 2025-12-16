pub fn isPangram(str: []const u8) bool {
    const std = @import("std");
    var b = std.bit_set.StaticBitSet(26).initEmpty();

    for (str) |char| {
        if (!std.ascii.isAlphabetic(char)) continue;
        b.set(std.ascii.toLower(char) - 'a');
    }

    return b.count() == 26;
}
