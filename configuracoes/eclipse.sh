ECLIPSE_DIR=eclipse
ECLIPSE_LINK=$ECLIPSE_DIR
case $PLATAFORMA in
    Linux) ECLIPSE_INSTALADOR=eclipse-jee-luna-SR2-linux-gtk-x86_64.tar.gz;;
    Darwin) ECLIPSE_INSTALADOR=eclipse-jee-luna-SR2-macosx-cocoa-x86_64.tar.gz;;
    Cygwin) ECLIPSE_INSTALADOR=eclipse-jee-luna-SR2-win32-x86_64.zip;;
esac
ECLIPSE_INSTALADOR_URL=http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/luna/SR2
ECLIPSE_CONFIGURADO=eclipse.$PLATAFORMA.tar.gz

export ECLIPSE_HOME=$FERRAMENTAS_DIR/$ECLIPSE_DIR.$PLATAFORMA
if ! [ "$PLATAFORMA" = "Cygwin" ]
then
    export PATH=$ECLIPSE_HOME:$PATH
fi

eclipse() {
    local eclipse_bin=eclipse
    [ "$PLATAFORMA" = "Cygwin" ] && eclipse_bin="eclipse.exe"
    "$ECLIPSE_HOME"/$eclipse_bin &> /dev/null &
}

# vim set ts=4, sw=4, expandtab:
