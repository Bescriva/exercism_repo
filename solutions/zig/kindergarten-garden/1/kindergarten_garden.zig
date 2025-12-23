const stringToEnum = @import("std").meta.stringToEnum;

pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

const Student = enum {
    Alice,
    Bob,
    Charlie,
    David, 
    Eve,
    Fred,
    Ginny,
    Harriet,
    Ileana,
    Joseph,
    Kincaid,
    Larry,
};

fn charToPlant(char: u8) Plant {
    return switch (char) {
        'C' => Plant.clover,
        'G' => Plant.grass,
        'R' => Plant.radishes,
        'V' => Plant.violets,
        else => unreachable,
    };
}

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const index: usize = @intFromEnum(stringToEnum(Student, student).?);

    const student_plants: [4]Plant = .{
        charToPlant(diagram[index * 2]),
        charToPlant(diagram[index * 2 + 1]),
        charToPlant(diagram[index * 2 + (diagram.len / 2) + 1]),
        charToPlant(diagram[index * 2 + (diagram.len / 2) + 2]),
    };

    return student_plants;
}
