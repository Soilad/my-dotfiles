#!/bin/bash

BARS="${1:-10}"

cava -p <(cat <<EOF
[general]
bars = ${BARS}
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 99
EOF
) | while IFS= read -r line; do
    # cava's ascii output is semicolon-separated values per frame, e.g. "12;45;7;99;"
    # strip trailing semicolon, split on ';', build a JSON array
    line="${line%;}"
    IFS=';' read -ra values <<< "$line"

    json="["
    for i in "${!values[@]}"; do
        json+="${values[$i]}"
        if [ "$i" -lt $((${#values[@]} - 1)) ]; then
            json+=","
        fi
    done
    json+="]"

    echo "$json"
done
