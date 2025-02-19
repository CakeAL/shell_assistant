use std::process::Command;

#[flutter_rust_bridge::frb(sync)]
pub fn read_nvram_value(function: u8) -> Option<u8> {
    let function = match function {
        0 => "BootPreference",
        1 => "StartupMute",
        _ => return None,
    };
    let output = Command::new("nvram")
        .arg(function)
        .output()
        .ok()?;
    let output = String::from_utf8(output.stdout).ok()?;
    let value = output.split('%').nth(1)?.trim();
    u8::from_str_radix(value, 16).ok()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_read_nvram_value() {
        let value = read_nvram_value(1);
        dbg!(value);
    }
}