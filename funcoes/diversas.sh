# .Funções diversas
# localiza e mostra um trecho de código delimitado por uma marca dentro em algum script
mostrar_marca() {
    local marca=$1

    find "$AMBIENTE_HOME/" -type f -path '*/funcoes/*' | \
    while read f
    do
        $VERBOSO && echo -n "Buscando em \"$f\" ... "
        if grep -q "#.* \.$marca" "$f"
        then
            $VERBOSO && echo "Localizado!" || echo "Em \"$f\":"
            sed -n "/#.* \.$marca/,/#.* \.$marca\.fim/p" "$f"
        else
            $VERBOSO && echo " não encontrado!"
        fi
    done
}
# .Funções diversas.fim

# vim: set ts=4 sw=4 expandtab:
