instala_eclipse() {
  if [ -f "$INSTALADORES_DIR"/$ECLIPSE_CONFIGURADO ]
  then
    eclipse_restaurar
  else
    instala_aplicacao
  fi
}

remove_eclipse() {
  remove_aplicacao
}

# vim: set ts=2 sw=2 expandtab:
