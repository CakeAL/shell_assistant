use std::{
    collections::HashMap,
    io::Write,
    process::{Command, Stdio},
};

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

#[flutter_rust_bridge::frb(sync)]
pub fn execute_write_screenshot_settings(command_map: HashMap<i32, String>) {
    // 遍历 commandMap，分步执行
    command_map.iter().for_each(|(&key, value)| {
        let _value = format!("\"{value}\"");
        let args = match key {
            0 => vec!["location", &_value],
            1 => vec!["name", &_value],
            2 => vec!["type", value],
            3 => vec!["disable-shadow", "-bool", value],
            4 => vec!["include-date", "-bool", value],
            5 => vec!["show-thumbnail", "-bool", value],
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
    vec![
        "location",
        "name",
        "type",
        "disable-shadow",
        "include-date",
        "show-thumbnail",
    ]
    .iter()
    .for_each(|value| {
        let _ = Command::new("defaults")
            .args(["delete", "com.apple.screencapture", value])
            .output();
    });
    let _ = Command::new("killall").arg("SystemUIServer").output();
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
}
