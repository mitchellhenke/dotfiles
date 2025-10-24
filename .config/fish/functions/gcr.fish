function gcr
  if set -q argv[1];
    set --function commit $argv[1]
  else
    set --function commit HEAD
  end

  git show --stat=120 --format="" "$commit" | \
             grep -E '^\s*\S+.*\|' | \
             fzf --ansi \
                 --disabled \
                 --bind 'j:down,k:up,q:abort' \
                 --preview="echo {} | sed 's/|.*//' | xargs -I% git show --color=always $commit -- %" \
                 --preview-window=right:60%
end
