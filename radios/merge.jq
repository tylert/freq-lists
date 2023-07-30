# jq
map(to_entries)
| flatten
| group_by(.key)
| map({(.[0].key):map(.value)})
| add
| {
  Channels:.Channels|flatten|del(..|nulls),
  Contacts:.Contacts|flatten|del(..|nulls),
  GroupLists:.GroupLists|flatten|del(..|nulls),
  Zones:.Zones|flatten|del(..|nulls)
}
