
const std = @import("std");

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    var rolls: [4]i8 = undefined;

    inline for (0..4) |i|
        rolls[i] = std.crypto.random.intRangeAtMost(i8, 1, 6);
    std.mem.sort(i8, &rolls, {}, std.sort.desc(i8));

    return (rolls[0] + rolls[1] + rolls[2]);
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution_score = ability();

        return Character{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution_score,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution_score),
        };
    }
};
