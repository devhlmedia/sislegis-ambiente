ECLIPSE_DIR=eclipse
ECLIPSE_LINK=$ECLIPSE_DIR
case `uname` in
    Linux) ECLIPSE_INSTALADOR=eclipse-jee-luna-SR1-linux-gtk-x86_64.tar.gz;;
    Darwin) ECLIPSE_INSTALADOR=eclipse-jee-luna-SR1-macosx-cocoa-x86_64.tar.gz;;
esac
ECLIPSE_INSTALADOR_URL=http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/luna/SR1
ECLIPSE_CONFIGURADO=eclipse.tar.gz
export ECLIPSE_HOME=$FERRAMENTAS_DIR/$ECLIPSE_DIR
export PATH=$ECLIPSE_HOME:$PATH
