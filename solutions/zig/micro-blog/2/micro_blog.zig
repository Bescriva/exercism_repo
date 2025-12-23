
pub fn truncate(phrase: []const u8) []const u8 {
    var view = @import("std").unicode.Utf8View.init(phrase) catch unreachable;
    var iter = view.iterator();

    return iter.peek(5);
}
