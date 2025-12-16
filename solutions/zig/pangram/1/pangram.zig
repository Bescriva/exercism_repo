pub fn isPangram(str: []const u8) bool {
    const std = @import("std");
    var bol: [26]bool = [_]bool{false} ** 26;

    for (str) |char| {
        if (!std.ascii.isAlphabetic(char)) continue;
        bol[std.ascii.toLower(char) - 'a'] = true;
    }
    for (bol) |b| {
        if (!b)
            return false;
    }
    return true;
}
