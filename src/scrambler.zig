const std = @import("std");

// How it works:
// Read user input
// -> Read time down to millisecond
// -> calculate number of pi
// -> check for repeating patterns in user input
// -> change patterns
// -> shift letters using ASCII table

fn read_milliseconds() i64 {
    var now: i64 = 0;
    // Get timestamp as byte and throw away trash bits
    now = std.time.milliTimestamp();
    now &= 2047;
    // Normalize milliseconds
    if (now > 1000) {
        if (now > 2000) {
            now = now - 2000;
        } else {
            now = now - 1000;
        }
    }
    return now;
}

fn calc_num_of_pi(password: []u8) i64 {
    // TODO: build better algorithm to calc number of pi
    var num: i64 = 0;
    for (password) |byte| {
        num += byte;
    }
    num = num + read_milliseconds();
    return num;
}

fn check_for_lowercase(letter: u8) bool {
    if (97 <= letter and letter <= 122) {
        return true;
    }

    return false;
}

fn check_for_uppercase(letter: u8) bool {
    if (65 <= letter and letter <= 90) {
        return true;
    }

    return false;
}

fn correct_password(password: []u8) []u8 {
    // TODO: Make sure invalid characters END the method
    for (password) |i| {
        if (i == 32) {
            std.debug.print("ERROR: Password contains invalid character!\n", .{});
            break;
        }
    }

    for (password, 0..password.len) |_, i| {
        if (i != 0 and i != password.len - 1) {
            if (check_for_lowercase(password[i - 1]) and check_for_lowercase(password[i]) and check_for_lowercase(password[i + 1])) {
                password[i] = password[i] - 32;
            }
            if (check_for_uppercase(password[i - 1]) and check_for_uppercase(password[i]) and check_for_uppercase(password[i + 1])) {
                std.debug.print("Oops, only uppercase!\n", .{});
            }
        }
    }

    return password;
}

pub fn main() !void {
    std.debug.print("Current time: {d}\n", .{read_milliseconds()});
    var password = [_]u8{ 'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd' };
    std.debug.print("Test: {s}\n", .{correct_password(&password)});
    std.debug.print("Current password: {d}\n", .{calc_num_of_pi(&password)});
}
