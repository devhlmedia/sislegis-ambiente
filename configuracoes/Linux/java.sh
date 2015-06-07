distro=`distro`
case $distro in
    CentOS|Fedora) export JAVA_HOME=/usr/java/latest;;
    Ubuntu) export JAVA_HOME=/usr/lib/jvm/java-8-oracle;;
    *) echo "Configure JAVA_HOME para a distribuição \"$distro\"!"
esac
unset distro
export PATH=$JAVA_HOME/bin:$PATH

# vim set ts=4, sw=4, expandtab:
