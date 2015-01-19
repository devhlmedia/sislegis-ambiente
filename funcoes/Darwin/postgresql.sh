#!/bin/bash
# Autor: Paulo Jerônimo (pj@paulojeronimo, @paulojeronimo)
#
# Funções específicas para trabalho com o PostgreSQL no OS X
# Requer a instalação do Homebrew (http://brew.sh/)

POSTGRES_LOG=/usr/local/var/postgres/server.log

postgresql_instalar() {
    brew install postgresql
    initdb /usr/local/var/postgres
    postgresql_start
    sleep 2
    createuser -s postgres
}

postgresql_remover() {
    postgresql_stop
    rm -rf /usr/local/var/postgres
}

postgresql_start() {
    pg_ctl -D /usr/local/var/postgres -l $POSTGRES_LOG start
}

postgresql_showlog() {
    tail -f $POSTGRES_LOG
}

postgresql_stop() { 
    pg_ctl -D /usr/local/var/postgres stop -s -m fast
}

postgresql_pgadmin_instalar() {
    brew install Caskroom/cask/pgadmin3
}

postgresql_pgadmin() {
    open -a pgadmin3
}

# vim: set ts=4 sw=4 expandtab:
