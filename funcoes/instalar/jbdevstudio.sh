instala_jbdevstudio() {
  if [ -f "$INSTALADORES_DIR"/$JBDEVSTUDIO_CONFIGURADO ]
  then
    echo "Execute o comando jbdevstudio_restaurar ..."
  else
    echo "Instalando o JBoss Developer Studio através do java ..."
    java -jar "$INSTALADORES_DIR/${!APP_INSTALADOR}" "$CONFIGURACOES_DIR/`uname`/jbdevstudio/InstallConfigRecord.xml"
  fi
}

remove_jbdevstudio() {
  remove_aplicacao
}

# vim: set ts=2 sw=2 expandtab:
