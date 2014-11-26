instala_jboss() {
   local file2patch
   instala_aplicacao

   echo "Criando o arquivo /etc/default/wildfly.conf ..."
   cat <<EOF | sudo tee /etc/default/wildfly.conf &> /dev/null
JAVA_HOME="$JAVA_HOME"
JBOSS_USER=$USER
JBOSS_HOME="$JBOSS_HOME"
JBOSS_MODE=standalone
JBOSS_PARAMS="-b 0.0.0.0 -bmanagement=0.0.0.0 -Dsislegis.app.home=$APP_HOME"
EOF

   file2patch=etc/init.d/jboss
   echo "Criando o arquivo /$file2patch"
   sudo cp $JBOSS_HOME/bin/init.d/wildfly-init-redhat.sh /$file2patch
   sudo patch /$file2patch < "$FUNCOES_DIR"/instalar/patches/ROOT/$file2patch > /dev/null

   file2patch=standalone/configuration/standalone.xml
   echo "Configurando o arquivo $JBOSS_HOME/$file2patch"
   patch $JBOSS_HOME/$file2patch < "$FUNCOES_DIR"/instalar/patches/JBOSS_HOME/$file2patch > /dev/null

   echo "Configurando o usuário/senha (sislegis/@dmin123) para acesso a interface administrativa"
   echo 'sislegis=fcdd56cdc33753b6a3647932ed4289c8' | tee -a $JBOSS_CONFIGURATION/mgmt-users.properties &> /dev/null
   echo 'sislegis=' | tee -a $JBOSS_CONFIGURATION/mgmt-groups.properties &> /dev/null

   echo "Configurando a inicialização automática no boot"
   sudo chkconfig jboss on
}

remove_jboss() {
   local jboss_files="\
/etc/init.d/jboss \
/etc/default/wildfly.conf \
"
   for f in $jboss_files
   do
      if [ -f "$f" ]
      then
         echo "Removendo o arquivo \"$f\""
         sudo rm -f $f
      fi
   done

   remove_aplicacao
}

# vim: set ts=3 sw=3 expandtab:
