# JenkinsサーバーでのSSHキーの設定手順

## 1. Jenkinsサーバーに秘密鍵・公開鍵を作成

次のコマンドを実行して、秘密鍵と公開鍵を生成します。

```bash
ssh-keygen -t rsa -b 4096 -C "jenkins@your-domain" -N "" -f ~/.ssh/jenkins_rsa
```

- **パスフレーズ**は指定しないでください。
- 鍵はデフォルトの**OpenSSH形式**で生成されます。

## 2. 接続先サーバに公開鍵を追加

生成された公開鍵（`~/.ssh/jenkins_rsa.pub`）の内容を接続先サーバの`/root/.ssh/authorized_keys`ファイルに追加します。

```bash
cat ~/.ssh/jenkins_rsa.pub | ssh root@linux-server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

## 3. Jenkinsにクレデンシャルを追加

Jenkinsの管理画面で、以下の手順でSSH秘密鍵をクレデンシャルとして追加します。

1. **管理画面** -> **Manage Credentials** -> **Globalドメイン** -> **新しい認証情報を追加**。
2. 種類（Kind）: `SSH Username with private key`
3. **Username**: `root`
4. **Private Key**: `Enter directly`を選択し、生成した秘密鍵（`~/.ssh/jenkins_rsa`）の内容を貼り付けます。

これで、Jenkinsから接続先サーバにSSHでアクセスするための設定が完了します。