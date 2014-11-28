MAVEN_INSTALA_VIA_PACOTE=false
if $MAVEN_INSTALA_VIA_PACOTE
then
   MAVEN_INSTALADOR=maven

   # TODO A determinação de usar o yum ou o apt-get deve ser feita pelo instalar.
   # dessa forma, o código a seguir deverá sumir.
   case `distro` in
     CentOS|Fedora) MAVEN_INSTALA_OPCS+=' --usa-yum';;
     Ubuntu) MAVEN_INSTALA_OPCS+=' --usa-apt-get';;
   esac

   # TODO Esse código deverá ser o que funcionará após o ajuste do instalar:
   # MAVEN_INSTALA_OPCS+=' --instala-via-pacote'
else
   MAVEN_LINK=maven
   MAVEN_VER=3.2.3
   MAVEN_DIR=apache-maven-$MAVEN_VER
   MAVEN_INSTALADOR=$MAVEN_DIR-bin.tar.gz
   MAVEN_INSTALADOR_URL=http://linorg.usp.br/apache/maven/maven-3/$MAVEN_VER/binaries
   export M2_HOME=$FERRAMENTAS_DIR/maven
   export PATH=$M2_HOME/bin:$PATH
fi

# vim: set ts=2 sw=2 expandtab:
