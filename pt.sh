#!/bin/sh

PROG=$(basename $0)
PROJECT='{{:project}}'

stderr() {
  echo "$@" 1>&2
}

stderr2() {
  printf "%s\n" "$@" 1>&2
}

usage() {
    stderr2 "usage: $PROG <command> [args]"
    if [ "$#" -ne 0 ]; then
        stderr2 ""                                                 \
        "A tool for template-based project creation"               \
        ""                                                         \
        "commands:"                                                \
        "    init    Initialize a project in current directory"    \
        "    new     Create directory and project"                 \
        "    list    List available project templates"             \
        "    help    Show this or help for <command>"
    fi
}

get_dir() {
    basename $(pwd)
}

# usage: fill_template <project-name> <file>
# replaces all instances of {{:project}} with project-name
fill_template() {
  sed s/"$PROJECT"/"$1"/g "$2"
}

do_init() {
    local dir="$(get_dir)"
}

do_new() {
    stderr2 "IMPLEMENT do_new"
}

do_list() {
    stderr2 "IMPLEMENT do_list"
}

do_help() {
    case $1 in
    init)
        ;;
    new)
        ;;
    list)
        ;;
    *)
        usage long ;;
    esac
}

# usage: handle_command <cmd> [extras..]
handle_cmd() {
    local cmd="$1"
    [ "$#" -gt 1 ] && shift

    case $cmd in
    init)
        do_init "$@" ;;
    new)
        do_new "$@" ;;
    list)
        do_list "$@" ;;
    -h|--help|help)
        do_help "$@" ;;
    *)
        usage;
    esac
}

main() {
    handle_cmd "$@"
}

main "$@"
