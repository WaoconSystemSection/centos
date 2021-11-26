# DockerでCentOSを使ったLAMP環境構築

コマンド ビルドして起動 
```
$ docker-compose up -d
```
<br>

アクセス方法 *ポート番号はdocker-compose.ymlに設定されているポート番号
```
  http://localhost:ポート番号/
```
<br>

コンテナに入る コンテナ名は今回は「centos」
```
  docker-compose exec コンテナ名 bash
```
<br>

## ポートの追加方法
### 例:92番ポートを通す方法
<br>

centos7/copy/v_host.confに以下を追加

```
<VirtualHost *:92>
DocumentRoot /var/www/html/site92 #ポートを通すパスを指定
ServerName localhost92
</VirtualHost>
```
<br>

centos7/copy/httpd.confに以下を追加
の編集
```
Listen 92
```
<br>

centos7/docker-compose.ymlに以下を追加
```
ports:
- 8092:92
```

<br>

コマンド 再度ビルドして起動
```
$ docker-compose up --build -d
```