const std = @import("std");

// How it works:
// Read user input
// -> Read time down to millisecond
// -> calculate number of pi
// -> check for repeating patterns in user input
// -> change patterns
// -> shift letters using ASCII table

pub fn read_milliseconds() i64 {
    var now: i64 = 0;
    now = std.time.milliTimestamp();
    now &= 2047;
    if (now > 1000) {
        if (now > 2000) {
            now = now - 2000;
        } else {
            now = now - 1000;
        }
    }
    return now;
}

pub fn calc_num_of_pi(password: []u8, milliseconds: i64) i64 {
    var num: i64 = 0;
    for (password) |byte| {
        num += byte;
    }
    num = num + milliseconds;
    return num;
}

pub fn correct_password(old_password: u8) u8 {
    return old_password;
}

pub fn main() !void {
    std.debug.print("Current time: {d}\n", .{read_milliseconds()});
    var password = [_]u8{ 'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd' };
    std.debug.print("Current password: {d}\n", .{calc_num_of_pi(&password, read_milliseconds())});
}
