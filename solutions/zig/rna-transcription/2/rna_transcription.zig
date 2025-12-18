const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) ![]const u8 {
    const rna = try allocator.alloc(u8, dna.len);
    errdefer allocator.free(rna);

    for (dna, rna) |d, *r| {
        r.* = switch (d) {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => unreachable,
        };
    }

    return rna;
}
