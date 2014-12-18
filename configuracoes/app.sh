export APP_HOME=$PROJETOS_DIR/app

case `uname` in
  Linux)
    distro=`echo $(lsb_release -i | awk -F: '{print $2}')`
    case $distro in
      Fedora|CentOS|Ubuntu)
        :
        ;;
      *)
        echo "Aviso: a configuração de ambiente para \"$distro\" não é suportada!"
        ;;
    esac
    ;;
  Darwin)
    :
    ;;
  CYGWIN)
    echo "Aviso: a configuração de ambiente para o CYGWIN não é suportada!"
    ;;
esac

# vim: set ts=2 sw=2 expandtab:
