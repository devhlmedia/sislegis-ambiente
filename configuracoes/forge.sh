FORGE_LINK=forge
FORGE_PACKAGE=forge-distribution
FORGE_VER=2.12.2.Final
FORGE_DIR=$FORGE_PACKAGE-$FORGE_VER
FORGE_INSTALADOR=$FORGE_DIR-offline.zip
FORGE_INSTALADOR_URL=https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/jboss/$FORGE_LINK/$FORGE_PACKAGE/$FORGE_VER

export FORGE_HOME=$FERRAMENTAS_DIR/forge
export PATH=$FORGE_HOME/bin:$PATH
