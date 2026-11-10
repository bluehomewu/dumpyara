# dumpyara

從 OTA 網址或本機檔案解出 Android 韌體，再發布到指定的 GitHub 帳號或組織。
支援 Linux、macOS，首次先執行：

```bash
bash setup.sh
```

## 使用

將範例中的來源換成 OTA 網址或檔案路徑：

```bash
bash dumpyara.sh "OTA來源" --repo=private
```

預設會建立公開 repo，私有資料請明確使用 `--repo=private`。
先將腳本的目標帳號或組織改成自己的，否則可能只解出檔案而沒有推送。

GitHub Token 放在 `.githubtoken`，Telegram Bot Token 放在 `.tgtoken`；
兩者都已排除於 Git。也支援把 GitHub Token 當第二個參數，
但不要將實際 Token 寫入文件或提交。

[支援格式](https://github.com/AndroidDumps/Firmware_extractor/blob/master/extractor.sh#L3)
由 Firmware_extractor 決定。AndroidDumps 成員原工作流程使用
`admin:org`、`public_repo` 權限，請依自己的發布目標確認所需權限。

上游：[發布頻道](https://t.me/android_dumps)、[需求群組](https://t.me/dumprequests)。
