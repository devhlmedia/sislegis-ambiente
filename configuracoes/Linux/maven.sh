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
fi

# vim: set ts=4 sw=4 expandtab:
