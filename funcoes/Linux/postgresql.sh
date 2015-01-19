#!/bin/bash

_postgresql_instalar_Fedora() {
    sudo yum -y install postgresql-server postgresql-contrib
    sudo postgresql-setup initdb
    sudo sed -i 's/^\(local.*\)peer/\1trust/g;s/^\(host.*\)ident/\1trust/g' /var/lib/pgsql/data/pg_hba.conf
    if [ "$USER" = "vagrant" ]
    then
        sudo su postgres -c "printf \"\n\n# === CUSTOM VAGRANT SETTINGS === \n\" >> /var/lib/pgsql/data/postgresql.conf"
        sudo su postgres -c "echo \"listen_addresses = '*'\" >> /var/lib/pgsql/data/postgresql.conf"
        sudo su postgres -c "printf \"\n\n# === CUSTOM VAGRANT SETTINGS === \n\" >> /var/lib/pgsql/data/pg_hba.conf"
        sudo su postgres -c "printf \"host\tall\t\tall\t\t10.0.2.2/24\t\ttrust\n\" >> /var/lib/pgsql/data/pg_hba.conf"
    fi
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
}

# TODO
_postgresql_instalar_Ubuntu() {
    :
}

_postgresql_instalar_CentOS() {
    sudo yum -y install postgresql-server postgresql-contrib
    sudo service postgresql initdb
    sudo sed -i 's/^\(local.*\)ident/\1trust/g;s/^\(host.*\)ident/\1trust/g' /var/lib/pgsql/data/pg_hba.conf
    sudo service postgresql start
    sudo chkconfig postgresql on
}

postgresql_instalar() {
    _postgresql_instalar_`distro`
}

_postgresql_remover_Fedora() {
    sudo systemctl stop postgresql
    sudo yum -y erase postgresql-server postgresql-contrib
    sudo userdel -rf postgres
}

# TODO
_postgresql_remover_Ubuntu() {
    :
}

_postgresql_remover_CentOS() {
    sudo service postgresql stop
    sudo yum -y erase postgresql-server postgresql-contrib
    sudo userdel -rf postgres
}

postgresql_remover() {
    _postgresql_remover_`distro`
}

postgresql_pgadmin() { 
    pgadmin3 &> /dev/null
}

# vim: ts=4 sw=4 expandtab:
