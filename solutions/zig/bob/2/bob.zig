fn is_question(s: []const u8) bool {
    for (0..s.len) |i| {
        const char = s[s.len - 1 - i];

        if (char == ' ' or (char >= '\t' and char <= '\r')) {
            continue;            
        }
        else if (char == '?') {
            return (true);            
        }
        else
            return (false);
    }
    return (false);
}

fn is_yelling(s: []const u8) bool {
    var has_letter: bool = false;

    for (s) |char| {
        if (char >= 'a' and char <= 'z')
            return (false);
        if (!has_letter and char >= 'A' and char <= 'Z')
            has_letter = true;
    }
    return (has_letter);
}

fn is_nothing(s: []const u8) bool {
    if (s.len == 0)
        return (true);

    for (s) |char|
        if (char != ' ' and (char < '\t' or char > '\r'))
            return (false);
    return (true);
}

pub fn response(s: []const u8) []const u8 {
    return if (is_nothing(s)) "Fine. Be that way!"
            else if (is_question(s) and is_yelling(s)) "Calm down, I know what I'm doing!"
            else if (is_yelling(s)) "Whoa, chill out!"
            else if (is_question(s)) "Sure."
            else "Whatever.";
}
