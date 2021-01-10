#compdef tabc

_get_windows () {
    xprop -root -notype _NET_CLIENT_LIST | cut -d' ' -f5- | sed 's/, /\n/g' | 
    _fill_completions 
}

_get_tabbed () {
    xprop -root -notype _NET_CLIENT_LIST | cut -d' ' -f5- | sed 's/, /\n/g' | 
    while read id; do 
        class=$(xprop -id $id -notype WM_CLASS | awk '{print $4}')
        [ "$class" = '"tabbed"' ] && 
            echo $id;
    done |
    _fill_completions

}

_get_tabbed_windows () {
    xprop -root -notype _NET_CLIENT_LIST | cut -d' ' -f5- | sed 's/, /\n/g' | 
    xargs tabc list |
    _fill_completions
}

_fill_completions () {
    while read id ;do
        id=${id//:/\\:}
        if which xprop &> /dev/null ;then
            name=$(xprop -id $id -notype WM_NAME 2> /dev/null) &&
                [[ "$name" = 'WM_NAME ='* ]] &&
                name="${${name#*\"}%\"*}" ||
                name=""
        else
            name="install xprop to see window titles here"
        fi
        completions+="$id:$name"
    done
}

_tabc () {
    local cmd
    if (( CURRENT > 2 )); then
        cmd=${words[2]}
        (( CURRENT-- ))
        shift words
        
        completions=()

        case "${cmd}" in 
            add)
                _arguments '1: :->window' '2: :->tabbed'
                case $state in
                    window)
                        _get_windows
                        ;;
                    tabbed)
                        _get_tabbed
                        ;;
                esac
                ;;
            create)
                _get_windows
                ;;
            remove)
                _get_tabbed_windows
                ;;
            remove-child)
                _get_tabbed
                ;;
            list)
                _get_tabbed
                ;;
        esac

	_describe 'tabc' completions

    else
        local -a subcommands
        subcommands=(
            "add:Add window to tabbed (an invalid <tabbed-id> has the same affect as create"
            "create:Adds tabbed to window"
	    "remove:Remove window from tabbed"
            "remove-child:Remove focused window from tabbed"
            "list:List all windows inside tabbed"
        )
        _describe -t commands 'tabc' subcommands
    fi
}



_tabc
