instala_eclipse() {
    if [ -f "$INSTALADORES_DIR"/$ECLIPSE_CONFIGURADO ]
    then
        eclipse_restaurar
    else
        instala_aplicacao

        echo "Movendo $ECLIPSE_DIR para $ECLIPSE_DIR.$PLATAFORMA"
        mv "$ECLIPSE_DIR" "$ECLIPSE_DIR.$PLATAFORMA"

        if [ "$PLATAFORMA" = "Cygwin" ]
        then
            echo "Marcando as dlls como executáveis em $ECLIPSE_HOME"
            find "$ECLIPSE_HOME" -type f -name "*.dll" -exec chmod +x {} \;
        fi
     fi
}

remove_eclipse() {
    echo "Removendo $ECLIPSE_DIR.$PLATAFORMA"
    rm -rf "$ECLIPSE_DIR.$PLATAFORMA"

    remove_aplicacao
}

# vim: set ts=4 sw=4 expandtab:
