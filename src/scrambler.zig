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

fn correct_password(old_password: []u8) []u8 {
    // Check for invalid characters
    for (old_password) |i| {
        if (i == 32) {
            std.debug.print("ERROR: Password contains invalid character!\n", .{});
            break;
        }
    }

    for (old_password, 0..old_password.len) |_, i| {
        if (i != 0 and i != old_password.len - 1) {
            if (97 <= old_password[i - 1] and old_password[i - 1] <= 122) {
                if (97 <= old_password[i] and old_password[i] <= 122) {
                    if (97 <= old_password[i + 1] and old_password[i + 1] <= 122) {
                        old_password[i] = old_password[i] - 32;
                    }
                }
            }
        }
    }

    return old_password;
}

pub fn main() !void {
    std.debug.print("Current time: {d}\n", .{read_milliseconds()});
    var password = [_]u8{ 'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd' };
    std.debug.print("Test: {s}\n", .{correct_password(&password)});
    std.debug.print("Current password: {d}\n", .{calc_num_of_pi(&password)});
}
