const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return ((score >> @intFromEnum(allergen)) & 1 != 0);
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var allergens = EnumSet(Allergen).initEmpty();
    
    for (std.meta.tags(Allergen)) |allergen| {
        if ((score >> @intFromEnum(allergen)) & 1 != 0)
            allergens.insert(allergen);
    }
    return allergens;
}
