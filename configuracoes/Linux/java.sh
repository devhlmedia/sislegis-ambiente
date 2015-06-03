distro=`distro`
case $distro in
    CentOS|Fedora) 
        # Alternativa 1) OpenJDK
        export JAVA_HOME=/usr/lib/jvm/java

        # Alternativa 2) Oracle JDK
        #export JAVA_HOME=/usr/java/latest
        ;;
    Ubuntu) export JAVA_HOME=/usr/lib/jvm/java-8-oracle;;
    *) echo "Configure JAVA_HOME para a distribuição \"$distro\"!"
esac
unset distro
export PATH=$JAVA_HOME/bin:$PATH
