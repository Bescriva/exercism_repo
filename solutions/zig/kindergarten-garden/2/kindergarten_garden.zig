
pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

fn charToPlant(char: u8) Plant {
    return switch (char) {
        'C' => .clover,
        'G' => .grass,
        'R' => .radishes,
        'V' => .violets,
        else => unreachable,
    };
}

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const index: usize = (student[0] - 'A') * 2;
    const row = diagram.len / 2 + 1;

    return .{
        charToPlant(diagram[index]),
        charToPlant(diagram[index + 1]),
        charToPlant(diagram[index + row]),
        charToPlant(diagram[index + row + 1]),
    };
}
