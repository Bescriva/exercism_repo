const std = @import("std");
const mem = std.mem;

fn isAnagram(word: []const u8, candidate: []const u8) bool {
    if (word.len != candidate.len)
        return (false);
    var counts = [_]i32{0} ** 26;
    
    for (word) |char|
        counts[std.ascii.toLower(char) - 'a'] += 1;
    for (candidate) |char| {
        const low = std.ascii.toLower(char);
        counts[low - 'a'] -= 1;
        if (counts[low - 'a'] < 0)
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

    for (candidates) |str|
        if (!std.ascii.eqlIgnoreCase(word, str) and isAnagram(word, str))
            try bufset.insert(str);
    return bufset;
}
