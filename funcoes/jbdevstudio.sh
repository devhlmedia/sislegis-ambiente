jbdevstudio() {
    case `uname` in
        Darwin) open $JBDEVSTUDIO_HOME/jbdevstudio.app;;
    esac
}
jbdevstudio_instalar() { instalar jbdevstudio "$@"; }
jbdevstudio_remover() { remover jbdevstudio "$@"; }
_saia_do_jbdevstudio() {
    echo "antes de executar esta operação, encerre o jbdevstudio!"
}
jbdevstudio_em_execucao() {
    case `uname` in
        Linux) ps -o ucmd | grep -q jbdevstudio;;
        Darwin) ps -ef | grep -w jbdevstudio | grep -qv grep;;
    esac
}
jbdevstudio_salvar_workspace() {
    jbdevstudio_em_execucao && { _saia_do_jbdevstudio; return 1; }

    cd "$AMBIENTE_HOME"
    [ -d workspace ] && tar cvfz "$INSTALADORES_DIR"/workspace.tar.gz workspace/
    cd - &> /dev/null
}
jbdevstudio_restaurar_workspace() {
    local workspace="$INSTALADORES_DIR"/workspace.tar.gz

    [ -f "$workspace" ] || return

    jbdevstudio_em_execucao && { _saia_do_jbdevstudio; return 1; }
    cd "$AMBIENTE_HOME"
    echo -n "Extraindo $workspace ... "
    extrai "$workspace" &> $OUT && ok || falha
    cd - &> /dev/null
}
jbdevstudio_salvar() {
    [ -d "$JBDEVSTUDIO_HOME" ] || return

    jbdevstudio_em_execucao && { _saia_do_jbdevstudio; return 1; }
    cd "$JBDEVSTUDIO_HOME"/..
    tar cvfz "$INSTALADORES_DIR"/$JBDEVSTUDIO_CONFIGURADO "`basename $JBDEVSTUDIO_HOME`"/
    jbdevstudio_salvar_workspace
}
jbdevstudio_restaurar() {
    local jbdevstudio="$INSTALADORES_DIR"/$JBDEVSTUDIO_CONFIGURADO

    [ -f "$jbdevstudio" ] || return

    jbdevstudio_em_execucao && { _saia_do_jbdevstudio; return 1; }
    cd "$FERRAMENTAS_DIR"
    echo -n "Extraindo $jbdevstudio ... "
    extrai $jbdevstudio &> $OUT && ok || falha
    cd - &> /dev/null

    jbdevstudio_restaurar_workspace
}

# vim: set ts=4 sw=4 expandtab:
