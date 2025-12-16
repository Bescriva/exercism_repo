pub fn isIsogram(str: []const u8) bool {
    const std = @import("std");
    var b: [26]bool = [_]bool{false} ** 26;
    for (str) |char| {
        if (!std.ascii.isAlphabetic(char)) continue;
        const i = std.ascii.toLower(char) - 'a';
        if (b[i]) {
            return false;
        } else {
            b[i] = true;
        }
    }
    return true;
}
