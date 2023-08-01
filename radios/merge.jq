# jq
map(to_entries)
| flatten
| group_by(.key)
| map({(.[0].key):map(.value[])})
| add
