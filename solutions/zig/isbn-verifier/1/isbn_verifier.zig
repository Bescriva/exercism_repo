const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var count: usize = 0;
    var sum: usize = 0;

    for (s) |char| {
        if (char == '-')
            continue;
        if (count < 9) {
            if (!std.ascii.isDigit(char))
                return false;
            sum += (char - '0') * (10 - count);
        } else if (count == 9) {
            if (std.ascii.isDigit(char)) {
                sum += (char - '0');
            } else if (char == 'X') {
                sum += 10;
            } else
                return false;
        } else
            return false;
        count += 1;
    }

    return (count == 10 and sum % 11 == 0);
}
