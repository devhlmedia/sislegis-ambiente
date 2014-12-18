_wildfly_conf() {
   case `distro` in
      Fedora|CentOS) echo -n /etc/default/wildfly.conf;;
      Ubuntu) echo -n /etc/default/wildfly;;
   esac
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
JBOSS_PARAMS="-b 0.0.0.0 -bmanagement=0.0.0.0"
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
   echo "Configurando o arquivo $JBOSS_HOME/$file2patch"
   patch $JBOSS_HOME/$file2patch < "$FUNCOES_DIR"/instalar/patches/JBOSS_HOME/$file2patch > /dev/null

   echo "Configurando propriedades de sistema para o sislegis-app"
   sed_i "
       s,SISLEGIS_APP_HOME,$APP_HOME,g
   " "$JBOSS_HOME/$file2patch"

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
