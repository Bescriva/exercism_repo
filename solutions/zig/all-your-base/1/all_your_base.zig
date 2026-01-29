const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

fn convertToOutputBase(allocator: mem.Allocator, output_base: u32, number: u32) ![]u32 {
    if (number == 0)
        return allocator.dupe(u32, &.{0});
    var arr = std.ArrayList(u32){};
    var num: u32 = number;

    defer arr.deinit(allocator);

    while (num > 0) {
        const rem = num % output_base;
        try arr.append(allocator, rem);
        num /= output_base;
    }

    std.mem.reverse(u32, arr.items);
    return try arr.toOwnedSlice(allocator);
}

fn convertToBase10(digits: []const u32, input_base: u32) u32 {
    var num: u32 = 0;

    for (digits) |digit|
        num = num * input_base + digit; 
    return num;
}

pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2)
        return ConversionError.InvalidInputBase;
    if (output_base < 2)
        return ConversionError.InvalidOutputBase;
    for (digits) |digit|
        if (digit >= input_base) return ConversionError.InvalidDigit;
    if (input_base == output_base)
        return try allocator.dupe(u32, digits);
    return convertToOutputBase(allocator, output_base, convertToBase10(digits, input_base));
}
