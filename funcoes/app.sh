# .SisLegis - Links
app_site() { browse http://github.com/pensandoodireito/sislegis-app; }
# .SisLegis - Links.fim

app() { cd "$APP_HOME"; }
app_baixar() { baixar-app; }
app_remover() { rm -rf "$APP_HOME"; }
app_remote_add_upstream() { (app && git remote add upstream http://github.com/pensandoodireito/sislegis-app); }
app_fetch_upstream() { (app && git fetch upstream); }
app_merge_upstream_master() { (app && git merge upstream/master); }
app_pull() { (app && git pull); }
app_clean() { (app && mvn clean); }
app_clean_package() { (app && mvn clean package -DskipTests=true "$@"); }
app_package() { (app && mvn package -DskipTests=true "$@"); }
app_deploy() {
    pushd . &> /dev/null
    app
    local package=target/sislegis.war
    if [ -f $package ]
    then
        echo -n "Copiando \"$APP_HOME/$package\" para \"$JBOSS_DEPLOYMENTS\" ... "
        cp $package "$JBOSS_DEPLOYMENTS"/ && ok || falha
    else
        echo "\"$package\" não encontrado em \"$APP_HOME\""
    fi
    popd &> /dev/null
}
app_undeploy() {
    pushd . &> /dev/null
    app
    local package=$JBOSS_DEPLOYMENTS/sislegis.war
    if [ -f "$package" ]
    then
        echo -n "Removendo \"$package\" ... "
        rm -f "$package" && ok || falha
    else
        echo "\"`basename \"$package\"`\" não está implantado em \"$JBOSS_DEPLOYMENTS!\""
    fi
    popd &> /dev/null
}
app_package_and_deploy() {
    app_package
    app_deploy
}
app_update_and_deploy() {
    app_fetch_upstream
    app_merge_upstream_master
    app_clean_package
    app_deploy
}
app_createdb() {
    cat <<EOF | psql -U postgres
create database sislegis;
create user sislegis with password 'sislegis';
grant all privileges on database "sislegis" to sislegis;
\q
EOF
}
app_dropdb() {
    cat <<EOF | psql -U postgres
drop database sislegis;
drop user sislegis
EOF
}
_app_db_backup() { echo -n "$APP_HOME/db.backup.gz"; }
app_dumpdb() {
    pg_dump -U postgres sislegis | gzip > `_app_db_backup`
}
app_restoredb() {
    if [ -f "$APP_HOME/db.backup.gz" ]
    then
        app_dropdb
        app_createdb
        cat `_app_db_backup` | gunzip | psql -U postgres sislegis
    else
        echo "O arquivo \"`_app_db_backup`\" não existe!"
    fi
}

# vim: set ts=4 sw=4 expandtab:
