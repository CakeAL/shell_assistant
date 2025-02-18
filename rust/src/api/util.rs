use std::{
    env, fs,
    io::{BufRead, BufReader, Write},
    path::{Path, PathBuf},
    process::{Command, Stdio},
    time::{SystemTime, UNIX_EPOCH},
};

use anyhow::{anyhow, Result};
use plist::Value;

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

pub(crate) fn get_app_icon(path: String) -> Result<PathBuf> {
    let app_path = PathBuf::from(&path);
    let app_name = Path::new(&path)
        .file_stem()
        .and_then(|name| name.to_str())
        .ok_or(anyhow!("No such app name"))?;
    let icon_plist_value = Value::from_file(app_path.join("Contents/Info.plist"))?;
    let icon_name = icon_plist_value
        .as_dictionary()
        .and_then(|dict| dict.get("CFBundleIconFile")?.as_string())
        .ok_or_else(|| anyhow!("No such CFBundleIconFile dict"))?
        .split('.')
        .next()
        .ok_or_else(|| anyhow!("No icon file name"))?;
    let icon_path = app_path.join(format!("Contents/Resources/{icon_name}.icns"));
    let home_dir = env::var("HOME")?;
    let copied_icon_path = PathBuf::from(home_dir).join(format!("Downloads/{app_name}.icns"));
    fs::copy(icon_path, &copied_icon_path)?;
    Ok(copied_icon_path)
}

pub(crate) fn iconutil_convert<P: AsRef<Path>>(path: P) -> Result<()> {
    let path = path.as_ref();
    let _ = Command::new("iconutil")
        .args(["--convert", "iconset"])
        .arg(path)
        .status()?;
    Ok(())
}

pub(crate) fn calculate_time_since_boot() -> Result<String> {
    let output = Command::new("sysctl").arg("kern.boottime").output()?;
    let result = String::from_utf8_lossy(&output.stdout).to_string();
    // 截取 boot 时间戳
    let sec = result
        .split("sec = ")
        .nth(1)
        .and_then(|s| s.split(',').next())
        .ok_or(anyhow!("Failed to parse kern.boottime"))?
        .trim()
        .parse::<u64>()?;
    // 获取当前 UNIX 时间戳
    let now = SystemTime::now().duration_since(UNIX_EPOCH)?.as_secs();

    // 计算 uptime（当前时间 - boottime）
    let uptime_seconds = now - sec;

    // 转换为 天, 小时, 分钟, 秒
    let days = uptime_seconds / 86400;
    let hours = (uptime_seconds % 86400) / 3600;
    let minutes = (uptime_seconds % 3600) / 60;
    let seconds = uptime_seconds % 60;

    // 格式化输出
    Ok(format!(
        "{} d, {} hr, {} min, {} sec",
        days, hours, minutes, seconds
    ))
}

pub(crate) fn execute_sudo_command(args: Vec<String>, password: String) -> Result<String, String> {
    let mut child = Command::new("sudo")
        .args(args)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .map_err(|e| e.to_string())?;

    if let Some(mut stdin) = child.stdin.take() {
        stdin
            .write_all(format!("{}\n", password).as_bytes())
            .map_err(|e| e.to_string())?;
    }

    let result = child.wait_with_output();
    match result {
        Ok(output) if output.status.success() => Ok("Success".to_string()),
        Ok(output) => Err(String::from_utf8_lossy(&output.stderr).to_string()),
        Err(e) => Err(e.to_string()),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_battery_info() {
        let battery_info = get_battery_info();
        dbg!(battery_info);
    }

    #[test]
    fn test_get_app_icon() {
        let path = "/Applications/Visual Studio Code.app";
        let res = get_app_icon(path.to_string());
        iconutil_convert(&res.unwrap()).unwrap();
    }

    #[test]
    fn test_calculate_time_since_boot() {
        let res = calculate_time_since_boot();
        println!("{}", res.unwrap());
    }
}
