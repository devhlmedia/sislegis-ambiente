eclipse_instalar() { instalar eclipse "$@"; }
eclipse_remover() { remover eclipse "$@"; }
_saia_do_eclipse() {
    echo "antes de executar esta operação, encerre o eclipse!"
}
eclipse_em_execucao() {
    case $PLATAFORMA in
        Linux) ps -o ucmd | grep -q eclipse;;
        Darwin) ps -o comm | grep -q eclipse;;
        Cygwin) ps | grep -q eclipse;;
    esac
}
eclipse_salvar_workspace() {
    eclipse_em_execucao && { _saia_do_eclipse; return 1; }

    cd "$AMBIENTE_HOME"
    [ -d workspace ] && tar cvfz "$INSTALADORES_DIR"/workspace.tar.gz workspace/
    cd - &> /dev/null
}
eclipse_restaurar_workspace() {
    local workspace="$INSTALADORES_DIR"/workspace.tar.gz

    [ -f "$workspace" ] || return 0

    eclipse_em_execucao && { _saia_do_eclipse; return 1; }
    cd "$AMBIENTE_HOME"
    echo -n "Extraindo $workspace ... "
    extrai "$workspace" &> $OUT && ok || falha
    cd - &> /dev/null
}
eclipse_salvar() {
    [ -d "$ECLIPSE_HOME" ] || { echo "Diretório \"$ECLIPSE_HOME\" não encontrado!"; return 1; }

    eclipse_em_execucao && { _saia_do_eclipse; return 1; }
    cd "$ECLIPSE_HOME"/..
    tar cvfz "$INSTALADORES_DIR"/$ECLIPSE_CONFIGURADO "`basename \"$ECLIPSE_HOME\"`"/
    eclipse_salvar_workspace
}
eclipse_restaurar() {
    local eclipse="$INSTALADORES_DIR"/$ECLIPSE_CONFIGURADO

    [ -f "$eclipse" ] || { echo "Arquivo \"$eclipse\" não encontrado!"; return 1; }

    eclipse_em_execucao && { _saia_do_eclipse; return 1; }
    cd "$FERRAMENTAS_DIR"
    echo -n "Extraindo $eclipse ... "
    extrai "$eclipse" &> $OUT && ok || falha
    cd - &> /dev/null

    eclipse_restaurar_workspace
}

# vim: set ts=4 sw=4 expandtab:
