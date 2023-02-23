#!/bin/sh

PROG=$(basename "$0")
PROJECT='{{:project}}'
TEMPLATES='{{:templates}}'

stderr2() {
    echo "$@" 1>&2
}

stderr() {
    printf "%s\n" "$@" 1>&2
}

usage() {
    stderr "usage: $PROG <command> [args]"
    if [ "$#" -ne 0 ]; then
    stderr ""                                                   \
        "A tool for template-based project creation"            \
        ""                                                      \
        "commands:"                                             \
        "    init    Initialize a project in current directory" \
        "    new     Create directory and project"              \
        "    list    List available project templates"          \
        "    help    Show this or help for <command>"
    fi
}

usage_init() {
    stderr "usage: $PROG init <template>"   \
        ""                                  \
        "Initialize the current directory with <template>"
}

usage_new() {
    stderr "usage: $PROG new <project> <template>"  \
        ""                                          \
        "Initialize a new directory, <project>, with <template>"
}

usage_list() {
    stderr "usage: $PROG list"  \
        ""                      \
        "List known templates"
}

# usage: arg_check <expected> <actual>
arg_check() {
    if [ "$1" != "$2" ]; then
        stderr "error! missing argument"
        return 1
    fi
}

get_dir() {
    basename "$(pwd)"
}

# usage: fill_template <project-name> <file>
# replaces all instances of {{:project}} with project-name
fill_template() {
    sed -i "s|$PROJECT|$1|g" "$2"
}

list_templates() {
    echo "templates available:"
    for dir in "$TEMPLATES"/*/; do
        [ -d "$dir" ] || continue
        printf '  - %s\n' "$(basename "$dir")"
    done
}

# usage: create_project <path> <template>
create_project() (
    dir="$(realpath "$1")"
    proj="$(basename "$dir")"
    template="$2"
    stderr "initializing $dir as a '$template' project.."
    [ -d "$TEMPLATES"/"$template" ] || {
        stderr "error! unable to find '$template' template"
        return 1
    }

    cp -r "$TEMPLATES"/"$template"/* "$dir"

    files=$(find "$dir" -type f)

    stderr "replacing instances of {{:project}} with $proj.."
    for f in $files; do
        stderr ".. $f"
        fill_template "$proj" "$f"
    done
)

# do_* functions are defined with () and not {} in order to
# have some 'local'-like scoping.

# usage: do_init <template>
do_init() (
    create_project . "$1"
)

# usage: do_new <name> <template>
do_new() (
    arg_check 2 "$#" || return 1

    #dir="$(realpath "$1")"
    dir="$1"
    template="$2"
    mkdir -p "$dir" || {
        stderr "error! unable to create the directory $dir"
        return 1
    }
    create_project "$dir" "$template"
)

do_list() (
    list_templates
)

do_help() (
    case $1 in
    init)
        usage_init
        ;;
    new)
        usage_new
        ;;
    list)
        usage_list
        ;;
    *)
        usage long
        ;;
    esac
)

# usage: handle_command <cmd> [extras..]
handle_cmd() {
    cmd="$1"

    [ "$#" -gt 1 ] && shift

    case $cmd in
    init)
        do_init "$@"
        ;;
    new)
        do_new "$@"
        ;;
    list)
        do_list "$@"
        ;;
    -h|--help|help)
        do_help "$@"
        ;;
    *)
        usage
        ;;
    esac
}

main() {
    handle_cmd "$@"
}

main "$@"
