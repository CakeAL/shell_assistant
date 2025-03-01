use std::time::Duration;

use anyhow::Result;
use flutter_rust_bridge::DartFnFuture;
use reqwest::Client;
use semver::Version;

use super::entity::ReleaseInfo;

static GITHUB_RELEASE_API: &str =
    "https://api.github.com/repos/CakeAL/ustb-wifi-tools/releases/latest";

pub async fn check_update(
    cur_version: String,
    callback: impl Fn(Option<ReleaseInfo>) -> DartFnFuture<()>,
) {
    let cur_version = Version::parse(&cur_version).unwrap_or(Version::new(0, 0, 0));
    let lastest_release_info =
        get_latest_release_info(GITHUB_RELEASE_API)
            .await
            .unwrap_or(ReleaseInfo {
                tag_name: "v0.0.0".to_string(),
                body: "".to_string(),
            });
    let lastest_version = Version::parse(&lastest_release_info.tag_name.trim_start_matches('v'))
        .unwrap_or(Version::new(0, 0, 0));
    if lastest_version > cur_version {
        callback(Some(lastest_release_info)).await;
    } else {
        callback(None).await;
    }
}

pub(crate) async fn get_latest_release_info(url: &str) -> Result<ReleaseInfo> {
    let response = Client::builder().no_proxy().build()?
        .get(url)
        .timeout(Duration::from_secs(5))
        .header("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36")
        .send()
        .await
        .unwrap();
    let text = response.text().await?;
    let value: serde_json::Value = serde_json::from_str(&text)?;
    let tag_name = value
        .get("tag_name")
        .and_then(|v| v.as_str())
        .unwrap_or("v0.0.0");
    let body = value
        .get("body")
        .and_then(|v| v.as_str())
        .unwrap_or("No release note");
    Ok(ReleaseInfo {
        tag_name: tag_name.to_string(),
        body: body.to_string(),
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_get_latest_release_info() {
        let release_info = get_latest_release_info(
            "https://api.github.com/repos/CakeAL/ustb-wifi-tools/releases/latest",
        )
        .await;
        dbg!(release_info.unwrap());
    }
}
