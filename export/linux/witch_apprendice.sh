#!/bin/sh
echo -ne '\033c\033]0;gams-\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/witch_apprendice.x86_64" "$@"
