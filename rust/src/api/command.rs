use std::{
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
}
