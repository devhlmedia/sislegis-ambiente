MAVEN_LINK=maven
MAVEN_VER=3.2.5
MAVEN_DIR=apache-maven-$MAVEN_VER
MAVEN_INSTALADOR=$MAVEN_DIR-bin.tar.gz
MAVEN_INSTALADOR_URL=http://linorg.usp.br/apache/maven/maven-3/$MAVEN_VER/binaries
export M2_HOME=$FERRAMENTAS_DIR/maven
export PATH=$M2_HOME/bin:$PATH
