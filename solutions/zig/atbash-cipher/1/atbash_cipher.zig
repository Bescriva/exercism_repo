const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var i: usize = 0;
    var encoded = std.ArrayList(u8){};
    defer encoded.deinit(allocator);
    
    for (s) |char| {
        if (char == ' ' or char == ',' or char == '.')
            continue;
        if (i % 5 == 0 and i != 0)
            try encoded.append(allocator, ' ');
        const encoded_char = if (char >= 'a' and char <= 'z')
                'z' - (char - 'a')
            else if (char >= 'A' and char <= 'Z')
                'z' - (char - 'A')
            else char;

        try encoded.append(allocator, encoded_char);
        i += 1;
    }

    return encoded.toOwnedSlice(allocator);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var decoded = std.ArrayList(u8){};
    defer decoded.deinit(allocator);

    for (s) |char| {
        if (char == ' ')
            continue;
        const decoded_char = if (char >= 'a' and char <= 'z') 'z' - (char - 'a') else char;

        try decoded.append(allocator, decoded_char);        
    }

    return decoded.toOwnedSlice(allocator);
}
