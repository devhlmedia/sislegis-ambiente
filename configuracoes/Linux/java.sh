distro=`distro`
case $distro in
    CentOS|Fedora) export JAVA_HOME=/usr/java/jdk1.8.0_31;;
    Ubuntu) export JAVA_HOME=/usr/lib/jvm/java-8-oracle;;
    *) echo "Configure JAVA_HOME para a distribuição \"$distro\"!"
esac
unset distro
export PATH=$JAVA_HOME/bin:$PATH
