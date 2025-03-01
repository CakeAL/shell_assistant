pub struct SystemInfo {
    pub host_name: Option<String>,
    pub user_name: Option<String>,
    pub cpu_model: String,
    pub number_of_cpus: i32,
    pub system_name: Option<String>,
    pub kernel_version: Option<String>,
    pub os_version: Option<String>,
    pub total_memory: u64,
    pub total_swap: u64,
    pub sip_status: Option<String>,
    pub time_since_boot: Option<String>,
    pub disk_infos: Vec<DiskInfo>,
    pub battery_info: BatteryInfo,
}

pub struct DiskInfo {
    pub name: String,
    pub file_system: String,
    pub disk_type: String,
    pub mount_point: String,
    pub removable: bool,
    // pub written_bytes: u64,
    // pub read_bytes: u64,
    pub total_space: u64,
    pub available_space: u64,
}

#[derive(Debug, Default)]
pub struct BatteryInfo {
    pub current_capacity: u8,
    pub apple_raw_current_capacity: i32,
    pub design_capacity: i32,
    pub apple_raw_max_capacity: i32,
}

#[derive(Debug, Default)]
pub struct ReleaseInfo {
    pub tag_name: String,
    pub body: String,
}
