_tabc() {

    COMPREPLY=()

    local commands=("add" "remove" "remove-child" "list")

    local cur=${COMP_WORDS[COMP_CWORD]}

    COMPREPLY=( `compgen -W "${commands[*]}" -- $cur` )

}

complete -F _tabc tabc
