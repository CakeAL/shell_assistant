use std::time::Duration;

use anyhow::Result;
use reqwest::Client;

#[derive(Debug)]
pub struct ReleaseInfo {
    pub tag_name: String,
    pub body: String,
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
