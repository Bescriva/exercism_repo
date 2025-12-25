const std = @import("std");
const mem = std.mem;

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
};

const codons = std.StaticStringMap(Protein).initComptime(.{
    .{"AUG", .methionine},
    .{"UUU", .phenylalanine},
    .{"UUC", .phenylalanine},
    .{"UUA", .leucine},
    .{"UUG", .leucine},
    .{"UCU", .serine},
    .{"UCC", .serine},
    .{"UCA", .serine},
    .{"UCG", .serine},
    .{"UAU", .tyrosine},
    .{"UAC", .tyrosine},
    .{"UGU", .cysteine},
    .{"UGC", .cysteine},
    .{"UGG", .tryptophan},
});

fn getProtein(codon: [3]u8) !?Protein {
    if (std.mem.eql(u8, &codon, "UAA") or 
        std.mem.eql(u8, &codon, "UAG") or 
        std.mem.eql(u8, &codon, "UGA")) {
        return null;
    }

    return codons.get(&codon) orelse TranslationError.InvalidCodon;
}

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    var rna = std.ArrayList(Protein){};
    errdefer rna.deinit(allocator);
    var i: usize = 0;
    var codon: [3]u8 = undefined;
    
    for (strand) |n| {
        codon[i] = n;
        if (i == 2) {
            const protein: Protein = try getProtein(codon) orelse return rna.toOwnedSlice(allocator);
            try rna.append(allocator, protein);
            i = 0;
        } else i+= 1;
    }
    if (i != 0) return TranslationError.InvalidCodon;

    return rna.toOwnedSlice(allocator);
}
