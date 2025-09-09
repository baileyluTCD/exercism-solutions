const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

pub fn response(s: []const u8) []const u8 {
    const phrase = mem.trim(u8, s, &ascii.whitespace);
    if (phrase.len == 0) return "Fine. Be that way!";

    const is_question = phrase[phrase.len - 1] == '?';

    var is_caps = false;
    for (phrase[1..]) |c| if (ascii.isAlphabetic(c)) {
        is_caps = true;
        if (ascii.isLower(c)) {
            is_caps = false;
            break;
        }
    };

    return if (is_caps and is_question)
        "Calm down, I know what I'm doing!"
    else if (is_caps)
        "Whoa, chill out!"
    else if (is_question)
        "Sure."
    else
        "Whatever.";
}
