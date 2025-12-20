const std = @import("std");
const mem = std.mem;

fn isAnagram(counts: [26]i32, candidate: []const u8) bool {
    var counts_tmp = counts;

    for (candidate) |char| {
        const low = std.ascii.toLower(char);
        counts_tmp[low - 'a'] -= 1;
        if (counts_tmp[low - 'a'] < 0)
            return false;
    }

    return true;
}

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var bufset = std.BufSet.init(allocator);
    errdefer bufset.deinit();

    var counts = [_]i32{0} ** 26;
    for (word) |char|
        counts[std.ascii.toLower(char) - 'a'] += 1;

    for (candidates) |str|
        if (word.len == str.len and !std.ascii.eqlIgnoreCase(word, str) and isAnagram(counts, str))
            try bufset.insert(str);
    return bufset;
}
