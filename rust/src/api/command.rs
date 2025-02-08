use std::{
 collections::HashMap, io::Write, process::{Command, Stdio}, sync::LazyLock
};

use crate::api::entity::{DiskInfo, SystemInfo};
use crate::api::util::get_battery_info;

#[flutter_rust_bridge::frb(sync)]
pub fn execute_bypass_signature(path: String, password: String) -> String {
    let mut child = Command::new("sudo")
        .arg("-S") // 从 stdin 读取密码
        .arg("xattr")
        .arg("-d")
        .arg("com.apple.quarantine")
        .arg(path)
        .stdin(Stdio::piped()) // 启用标准输入
        .stdout(Stdio::piped()) // 捕获输出
        .stderr(Stdio::piped()) // 捕获标准错误
        .spawn()
        .expect("Failed to spawn command");

    // 将密码写入 sudo 的标准输入
    if let Some(mut stdin) = child.stdin.take() {
        stdin
            .write_all(format!("{}\n", password).as_bytes())
            .expect("Failed to write to stdin");
    }

    // 等待命令完成
    let result = child.wait_with_output();
    match result {
        Ok(output) if output.status.success() => "Success".to_string(),
        Ok(output) => String::from_utf8_lossy(&output.stderr).to_string(),
        Err(e) => e.to_string(),
    }
}

static SCREENSHOT_SETTINGS: LazyLock<Vec<&str>> = LazyLock::new(|| {
    vec![
        "location",
        "name",
        "type",
        "disable-shadow",
        "include-date",
        "show-thumbnail",
    ]
});

#[flutter_rust_bridge::frb(sync)]
pub fn execute_write_screenshot_settings(command_map: HashMap<i32, String>) {
    // 遍历 commandMap，分步执行
    command_map.iter().for_each(|(&key, value)| {
        let _value = format!("\"{value}\"");
        let args = match key {
            0..=2 => vec![SCREENSHOT_SETTINGS[key as usize], &_value],
            3..=5 => vec![SCREENSHOT_SETTINGS[key as usize], "-bool", value],
            _ => return, // 如果没有匹配项，跳过当前循环
        };

        let _ = Command::new("defaults")
            .args(["write", "com.apple.screencapture"])
            .args(args)
            .output();
    });
    let _ = Command::new("killall").arg("SystemUIServer").output();
}

#[flutter_rust_bridge::frb(sync)]
pub fn execute_reset_screenshot_settings() {
    SCREENSHOT_SETTINGS.iter().for_each(|value| {
        let _ = Command::new("defaults")
            .args(["delete", "com.apple.screencapture", value])
            .output();
    });
    let _ = Command::new("killall").arg("SystemUIServer").output();
}

static DOCK_SETTINGS: LazyLock<Vec<&str>> = LazyLock::new(|| {
    vec![
        "scroll-to-open",
        "mouse-over-hilite-stack",
        "single-app",
        "size-immutable",
        "mineffect",
        "autohide-time-modifier",
        "autohide-delay",
    ]
});

#[flutter_rust_bridge::frb(sync)]
pub fn execute_write_dock_settings(
    switch_states: Vec<bool>,
    animation_time: Option<f64>,
    delay_time: Option<f64>,
) {
    let state = ("true", "false");
    #[allow(unused_assignments)]
    let mut str_time = String::new();
    for (i, setting) in DOCK_SETTINGS.iter().enumerate() {
        let args = match i {
            0..=3 => {
                vec![
                    *setting,
                    "-bool",
                    if switch_states[i] { state.0 } else { state.1 },
                ]
            }
            4 => {
                vec![
                    *setting,
                    "-string",
                    if switch_states[i] { "suck" } else { "genie" },
                ]
            }
            5 | 6 => {
                let time = if i == 5 { animation_time } else { delay_time };
                if let Some(t) = time {
                    str_time = (t / 1000.0).to_string();
                    vec![*setting, "-float", &str_time]
                } else {
                    continue;
                }
            }
            _ => continue, // Skip invalid indices
        };
        let _ = Command::new("defaults")
            .args(["write", "com.apple.dock"])
            .args(args)
            .output();
    }
    let _ = Command::new("killall").arg("Dock").output();
}

#[flutter_rust_bridge::frb(sync)]
pub fn execute_reset_dock_settings() {
    DOCK_SETTINGS.iter().for_each(|value| {
        let _ = Command::new("defaults")
            .args(["delete", "com.apple.dock", value])
            .output();
    });
    let _ = Command::new("killall").arg("Dock").output();
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_system_info() -> SystemInfo {
    use sysinfo::{Disks, System};
    let mut sys = System::new_all();
    sys.refresh_all();

    let cpu_model = sys
        .cpus()
        .first()
        .map(|cpu| cpu.brand())
        .unwrap_or("Unknown");

    let disks = Disks::new_with_refreshed_list().iter().map(|disk| {
        DiskInfo {
            name: disk.name().to_string_lossy().to_string(),
            file_system: disk.file_system().to_string_lossy().to_string(),
            disk_type: disk.kind().to_string(),
            mount_point: disk.mount_point().to_string_lossy().to_string(),
            removable: disk.is_removable(),
            total_space: disk.total_space(),
            available_space: disk.available_space(),
        }
    }).collect::<Vec<_>>();

    let user_name = match Command::new("whoami").output() {
        Ok(output) => Some(String::from_utf8_lossy(&output.stdout).trim().to_string()),
        Err(_) => None,
    };

    SystemInfo {
        host_name: System::host_name(),
        user_name,
        cpu_model: cpu_model.to_string(),
        number_of_cpus: sys.cpus().len() as i32,
        system_name: System::name(),
        kernel_version: System::kernel_version(),
        os_version: System::os_version(),
        total_memory: sys.total_memory(),
        total_swap: sys.total_swap(),
        disk_infos: disks,
        battery_info: get_battery_info().unwrap_or_default(),
    }
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_execute_bypass_signature() {
        let result = execute_bypass_signature("/Applications/Arc.app".to_string(), "".to_string());
        dbg!(result);
    }

    #[test]
    fn test_execute_write_screenshot_settings() {
        let command_map = HashMap::from([
            (0, "/Users/cakeal/Pictures".to_string()),
            (1, "123".to_string()),
            (2, "bmp".to_string()),
            (3, "true".to_string()),
            (4, "false".to_string()),
            (5, "false".to_string()),
        ]);
        execute_write_screenshot_settings(command_map);
    }

    #[test]
    fn test_get_system_info() {
        get_system_info();
    }
}
