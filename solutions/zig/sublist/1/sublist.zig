const std = @import("std");

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (std.mem.eql(i32, list_one, list_two))
        return .equal;
    if (std.mem.indexOf(i32, list_one, list_two) != null)
        return .superlist;
    if (std.mem.indexOf(i32, list_two, list_one) != null)
        return .sublist;
    return .unequal;
}
