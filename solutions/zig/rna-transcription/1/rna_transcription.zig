const std = @import("std");
const mem = std.mem;

const dict = std.StaticStringMap(u8).initComptime(.{
    .{ "G", 'C' },
    .{ "C", 'G' },
    .{ "T", 'A' },
    .{ "A", 'U' },
});

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var list = try std.ArrayList(u8).initCapacity(allocator, dna.len);
    errdefer list.deinit(allocator);

    for (dna) |n| {
        const rna_char = dict.get(&[_]u8{n}) orelse unreachable;
        try list.append(allocator, rna_char);
    }
    return list.toOwnedSlice(allocator);
}
