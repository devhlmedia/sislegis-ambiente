export APP_HOME=$PROJETOS_DIR/app
APP_AMBIENTE=${APP_AMBIENTE:-desenvolvimento}

case `uname` in
  Linux)
    case `distro` in
      # Fedora e Ubuntu são utilizados apenas em ambiente de desenvolvimento.
      #   Por esse motivo, os valores default (acima configurados) não precisam ser alterados
      Fedora|Ubuntu)
        APP_HOST=${APP_HOST:-sislegis.local}
        APP_IP=${APP_IP:-127.0.0.1}
        ;;
      # CentOS é utilizado em ambientes de desenvolvimento, homologação e produção.
      #   Obs: este projeto não é utilizado para configurar o ambiente de produção
      #   Para esse ambiente é utilizado o projeto sislegis-ambiente-producao
      CentOS)
        case "$APP_AMBIENTE" in
          desenvolvimento)
            APP_HOST=${APP_HOST:-sislegis.local}
            APP_IP=${APP_IP:-127.0.0.1}
            ;;
          homologacao)
            # Ajusta as configurações default para o ambiente de homologação
            APP_HOST=${APP_HOST:-homologacao-sislegis.pensandoodireito.mj.gov.br}
            APP_IP=${APP_IP:-172.17.6.80}
        esac
        ;;
    esac
    ;;
  # Para outros sistemas operacionais (Darwin, Cygwin), os valores default são suficientes
  *)
    APP_HOST=${APP_HOST:-sislegis.local}
    APP_IP=${APP_IP:-127.0.0.1}
    ;;    
esac

# vim: set ts=2 sw=2 expandtab:
