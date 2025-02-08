use std::{
    io::{BufRead, BufReader},
    process::{Command, Stdio},
};

use super::entity::BatteryInfo;

pub(crate) fn get_battery_info() -> Option<BatteryInfo> {
    let output = Command::new("ioreg")
        .args(["-rn", "AppleSmartBattery"])
        .stdout(Stdio::piped())
        .spawn()
        .ok()?
        .stdout?;

    let reader = BufReader::new(output);

    let mut battery_info = BatteryInfo {
        current_capacity: 0,
        apple_raw_current_capacity: 0,
        design_capacity: 0,
        apple_raw_max_capacity: 0,
    };

    for line in reader.lines().map_while(Result::ok) {
        let parts: Vec<&str> = line.split('=').map(|s| s.trim()).collect();
        if parts.len() != 2 {
            continue;
        }

        match parts[0] {
            "\"CurrentCapacity\"" => {
                if let Ok(value) = parts[1].parse::<u8>() {
                    battery_info.current_capacity = value;
                }
            }
            "\"AppleRawCurrentCapacity\"" => {
                if let Ok(value) = parts[1].parse::<i32>() {
                    battery_info.apple_raw_current_capacity = value;
                }
            }
            "\"DesignCapacity\"" => {
                if let Ok(value) = parts[1].parse::<i32>() {
                    battery_info.design_capacity = value;
                }
            }
            "\"AppleRawMaxCapacity\"" => {
                if let Ok(value) = parts[1].parse::<i32>() {
                    battery_info.apple_raw_max_capacity = value;
                }
            }
            _ => {}
        }
    }

    Some(battery_info)
}
