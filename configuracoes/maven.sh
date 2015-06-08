MAVEN_LINK=maven
MAVEN_VER=3.3.3
MAVEN_DIR=apache-maven-$MAVEN_VER
MAVEN_INSTALADOR=$MAVEN_DIR-bin.tar.gz
MAVEN_INSTALADOR_URL=http://linorg.usp.br/apache/maven/maven-3/$MAVEN_VER/binaries

case $PLATAFORMA in
    Cygwin) export M2_HOME=`cygpath "$M2_HOME"`;;
    *) 
        export M2_HOME=$FERRAMENTAS_DIR/maven
        export PATH=$M2_HOME/bin:$PATH
        ;;
esac

# vim set ts=4, sw=4, expandtab:
