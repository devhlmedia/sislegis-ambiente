export APP_HOME=$PROJETOS_DIR/app

case `uname` in
  Linux)
    case `distro` in
      Fedora|Ubuntu)
        APP_HOST=sislegis.local
        APP_IP=127.0.0.1
        ;;
      CentOS)
        APP_HOST=homologacao-sislegis.pensandoodireito.mj.gov.br
        APP_IP=172.17.6.80
        ;;
    esac
    ;;
  Darwin)
    APP_HOST=sislegis.local
    APP_IP=127.0.0.1
    ;;
esac

# vim: set ts=2 sw=2 expandtab:
