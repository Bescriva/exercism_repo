fn countLeadingOneBits(byte: u8) usize {
    var count: usize = 0;
    var mask: u8 = 0b1000_0000;

    while (mask != 0 and (byte & mask) != 0) : ({count += 1; mask >>= 1;})
        continue;

    return (count);
}

pub fn truncate(phrase: []const u8) []const u8 {
    var byte_count: usize = 0;
    var char_count: usize = 0;

    while (char_count < 5 and byte_count < phrase.len) {
        const leading_bits = countLeadingOneBits(phrase[byte_count]);

        char_count += if (leading_bits == 1) 0 else 1;
        byte_count += if (leading_bits == 0) 1 else leading_bits;
    }

    return (phrase[0..byte_count]);
}
