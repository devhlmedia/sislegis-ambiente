instala_maven() {
  instala_aplicacao

  if [ "$USA_PROXY" ]
  then
    cat > $HOME/.m2/settings.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <proxies>
    <proxy>
      <id>MJ</id>
      <active>true</active>
      <protocol>http</protocol>
      <username>$HTTP_PROXY_USERNAME</username>
      <password>$HTTP_PROXY_PASSWORD</password>
      <host>$HTTP_PROXY_HOST</host>
      <port>$HTTP_PROXY_PORT</port>
    </proxy>
  </proxies>
</settings>
EOF
  fi
}

remove_maven() {
  remove_aplicacao
}

# vim: set ts=2 sw=2 expandtab:
