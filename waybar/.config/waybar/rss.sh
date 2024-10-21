#!/usr/bin/env bash

unread_rss=$(newsboat -x print-unread)

if [[ $? -eq 0 ]]; then
    unread_rss=$( echo "$unread_rss" | cut -d' ' -f 1 | xargs )
    echo "$unread_rss"
    echo "$unread_rss" > "$HOME/.local/share/rss_unread_cache"
else
    cat "$HOME/.local/share/rss_unread_cache" | xargs
fi
