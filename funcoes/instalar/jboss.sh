POSTGRESQL_JDBC_DRIVER=postgresql-9.3-1102.jdbc41.jar

_wildfly_conf() {
   case `distro` in
      Fedora|CentOS) echo -n /etc/default/wildfly.conf;;
      Ubuntu) echo -n /etc/default/wildfly;;
   esac
}

_baixa_driver_jdbc_postgres() {
   local driver_url="http://jdbc.postgresql.org/download/$POSTGRESQL_JDBC_DRIVER"
   echo "Baixando o driver JDBC do PostgreSQL de $driver_url"
   cd "$INSTALADORES_DIR" && wget -c $driver_url
   cd - &> /dev/null
}

_instala_driver_jdbc_postgres() {
   local driver_dir="$JBOSS_HOME"/modules/system/layers/base/org/postgresql/main
   echo "Instalando o driver JDBC do PostgreSQL como módulo"
   mkdir -p "$driver_dir"
   cat > "$driver_dir"/module.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<module xmlns="urn:jboss:module:1.0" name="org.postgresql">
    <resources>
        <resource-root path="$POSTGRESQL_JDBC_DRIVER"/>
    </resources>
    <dependencies>
        <module name="javax.api"/>
        <module name="javax.transaction.api"/>
    </dependencies>
</module>
EOF
   local driver_file="$INSTALADORES_DIR"/$POSTGRESQL_JDBC_DRIVER
   [ -f "$driver_file" ] || _baixa_driver_jdbc_postgres
   cp "$driver_file" "$driver_dir"/
}

_instala_keycloak() {
   local keycloak_url=http://nbtelecom.dl.sourceforge.net/project/keycloak/1.2.0.Final/keycloak-overlay-1.2.0.Final.tar.gz
   local keycloak=${keycloak_url##*/}

   echo "Baixando o instalador do keycloak ($keycloak)"
   wget -c $keycloak_url -O "$INSTALADORES_DIR/$keycloak"
   echo "Extraindo o instalador do keycloak"
   tar xvfz "$INSTALADORES_DIR/$keycloak" -C "$JBOSS_HOME" &> /dev/null
}

instala_jboss() {
   local file2patch
   local init_d_script
   local patch_file
   instala_aplicacao

   if [ "`uname`" = "Linux" ]
   then
      echo "Criando o arquivo `_wildfly_conf` ..."
      cat <<EOF | sudo tee `_wildfly_conf` &> /dev/null
JAVA_HOME="$JAVA_HOME"
JBOSS_USER=$USER
JBOSS_HOME="$JBOSS_HOME"
JBOSS_MODE=standalone
JBOSS_PARAMS='-b 0.0.0.0 -bmanagement=0.0.0.0 -Dkeycloak.import="$JBOSS_HOME/sislegis-realm.json"'
EOF

      file2patch=etc/init.d/jboss
      echo "Criando o arquivo /$file2patch"
      case `distro` in
         Fedora|CentOS)
            init_d_script=$JBOSS_HOME/bin/init.d/wildfly-init-redhat.sh
            patch_file="$FUNCOES_DIR"/instalar/patches/ROOT/${file2patch}.redhat
            ;;
         Ubuntu)
            init_d_script=$JBOSS_HOME/bin/init.d/wildfly-init-debian.sh
            patch_file="$FUNCOES_DIR"/instalar/patches/ROOT/${file2patch}.debian
            ;;
      esac
      sudo cp $init_d_script /$file2patch
      sudo patch /$file2patch < "$patch_file" > /dev/null
   fi

   file2patch=standalone/configuration/standalone.xml
   echo "Aplicando patch no arquivo $JBOSS_HOME/$file2patch"
   cp "$JBOSS_HOME"/$file2patch "$JBOSS_HOME"/$file2patch.original
   patch $JBOSS_HOME/$file2patch < "$FUNCOES_DIR"/instalar/patches/JBOSS_HOME/$file2patch > /dev/null

   _instala_driver_jdbc_postgres

   echo "Configurando variáveis no arquivo $JBOSS_HOME/$file2patch"
   sed_i "
       s,SISLEGIS_APP_FRONTEND_HOME,$APP_FRONTEND_HOME,g
       s,SISLEGIS_APP_HOST,$APP_HOST,g
   " "$JBOSS_HOME/$file2patch"

   _instala_keycloak

   echo "Configurando o usuário/senha (sislegis/@dmin123) para acesso a interface administrativa"
   echo 'sislegis=fcdd56cdc33753b6a3647932ed4289c8' | tee -a $JBOSS_CONFIGURATION/mgmt-users.properties &> /dev/null
   echo 'sislegis=' | tee -a $JBOSS_CONFIGURATION/mgmt-groups.properties &> /dev/null

   if [ "`uname`" = "Linux" ]
   then
      echo "Configurando a inicialização automática no boot"
      case `distro` in
          Fedora|CentOS) sudo chkconfig jboss on;;
          Ubuntu) sudo update-rc.d jboss defaults;;
      esac
   fi

   case `uname` in
      Darwin|Linux)
         echo "Configurando o arquivo /etc/hosts"
         if ! grep -q "$APP_IP.*$APP_HOST" /etc/hosts
         then
            echo -e "$APP_IP\t$APP_HOST" | sudo tee -a /etc/hosts &> /dev/null
         fi
         ;;
   esac

   if [ "$APP_AMBIENTE" = "homologacao" ]
   then
      echo "Redirecionando requisições a porta 80 para 8080 ..."
      sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
      sudo iptables -t nat -I OUTPUT -p tcp -o lo --dport 80 -j REDIRECT --to-ports 8080
      sudo service iptables save
   fi
   echo "Gerando \"$JBOSS_HOME/sislegis-realm.json\" ..."
   sed "s,APP_HOST,$APP_HOST,g" "$CONFIGURACOES_DIR/keycloak/sislegis-realm.json.$APP_AMBIENTE" > "$JBOSS_HOME"/sislegis-realm.json
}

remove_jboss() {
   if [ "`uname`" = "Linux" ]
   then
      local jboss_files="/etc/init.d/jboss `_wildfly_conf`"
      for f in $jboss_files
      do
         if [ -f "$f" ]
         then
            echo "Removendo o arquivo \"$f\""
            sudo rm -f $f
         fi
      done
   fi
   remove_aplicacao
}

# vim: set ts=3 sw=3 expandtab:
