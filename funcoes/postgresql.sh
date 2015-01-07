#!/bin/bash

_postgresql_instalar_Linux_Fedora() {
    sudo yum -y install postgresql-server postgresql-contrib
    sudo postgresql-setup initdb
    sudo sed -i 's/^\(local.*\)peer/\1trust/g;s/^\(host.*\)ident/\1trust/g' /var/lib/pgsql/data/pg_hba.conf
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
}

_postgresql_remover_Linux_Fedora() {
    sudo systemctl stop postgresql
    sudo yum -y erase postgresql-server postgresql-contrib
    sudo userdel -rf postgres
}

# TODO
_postgresql_instalar_Linux_Ubuntu() {
    :
}

# TODO
_postgresql_instalar_Darwin() {
    :
}

postgresql_instalar() {
    case `uname` in
        Linux) _postgresql_instalar_`uname`_`distro` ;;
        *) _postgresql_instalar_`uname` ;;
    esac
}

# vim: ts=4 sw=4 expandtab:
