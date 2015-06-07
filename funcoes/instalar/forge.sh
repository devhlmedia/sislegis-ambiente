instala_forge() {
    instala_aplicacao

    if [ "$FORGE_VER" = "2.14.0.Final" ]
    then
        echo "Aplicando patch no script de execução do forge"
        patch "$FORGE_HOME"/bin/forge < "$FUNCOES_DIR"/instalar/patches/FORGE_HOME/bin/forge
    fi

    echo "Instalando addons"
    forge_instalar_addons
}

remove_forge() {
    remove_aplicacao
}

# vim: set ts=4 sw=4 expandtab:
