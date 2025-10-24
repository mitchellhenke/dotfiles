function jqp
    printf '' | fzf --print-query \
        --preview "jq -C {q} '$argv[1]' 2>&1" \
        --preview-window=up:80%
end
