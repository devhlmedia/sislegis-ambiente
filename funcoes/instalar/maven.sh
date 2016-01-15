instala_maven() {
    local settings_dir="$HOME"/.m2
    instala_aplicacao

     mkdir -p "$settings_dir"

    if [ "$USA_PROXY" ]
    then
        cat >> "$settings_dir"/settings.xml <<EOF
  <proxies>
    <proxy>
      <id>MJ</id>
      <active>false</active>
      <protocol>http</protocol>
      <username>$HTTP_PROXY_USERNAME</username>
      <password>$HTTP_PROXY_PASSWORD</password>
      <host>$HTTP_PROXY_HOST</host>
      <port>$HTTP_PROXY_PORT</port>
    </proxy>
  </proxies>
<<<<<<< HEAD
  <profiles>
      <profile>
            <id>sislegis</id>
            <properties>
               <keycloak.server>localhost</keycloak.server>
            </properties>
        <activation>
                                <activeByDefault>true</activeByDefault>
                                <jdk>1.7</jdk>
                        </activation>

                </profile>
        </profiles>
    <activeProfiles>
       <activeProfile>sislegis</activeProfile>
    </activeProfiles>

</settings>
EOF
    fi
}

remove_maven() {
    remove_aplicacao
}

# vim: set ts=4 sw=4 expandtab:
