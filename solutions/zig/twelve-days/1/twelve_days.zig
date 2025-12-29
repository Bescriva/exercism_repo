const std = @import("std");

const gifts = [12][]const u8{
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
};

const days = [12][]const u8{
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
};

fn printLine(buffer: []u8, comptime fmt: []const u8, args: anytype) !usize {
    const line = try std.fmt.bufPrint(buffer, fmt, args);
    return line.len;
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    var verse: u32 = start_verse - 1;
    var len: usize = 0;
    
    while (verse < end_verse) : (verse += 1) {
        len += try printLine(buffer[len..], "On the {s} day of Christmas my true love gave to me: ", .{days[verse]});
        
        var gift = verse;
        
        while (gift > 0) : (gift -= 1)
            len += try printLine(buffer[len..], "{s}, ", .{gifts[gift]});
            
        if (verse != 0)
            len += try printLine(buffer[len..], "and ", .{});
        if (verse != end_verse - 1) {
            len += try printLine(buffer[len..], "{s}.\n", .{gifts[gift]});
        } else
            len += try printLine(buffer[len..], "{s}.", .{gifts[gift]});
    }
    return buffer[0..len];
}