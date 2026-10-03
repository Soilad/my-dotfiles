#!/bin/bash
out=$(playerctl metadata --format '{
    "artist": "{{artist}}",
    "title": "{{title}}",
    "position": {{position}},
    "length": {{mpris:length}},
    "artUrl": "{{xesam:url}}",
    "status": "{{status}}"
}' 2>/dev/null | jq -r '
  def default_for($key; $value):
    if $value == "" or $value == null then
      ({"artist":"Unknown Artist","title":"Unknown Title","artUrl":"","status":"Stopped"}[$key] // "Unknown")
    else $value end;
  
  def clean_title($title; $artist):
    $title | 
    sub("^" + $artist + "[[:space:]]*[-–—][[:space:]]*"; "") | 
    sub("[[:space:]]*[-–—][[:space:]]*" + $artist + "$"; "");
  
  with_entries(.value = default_for(.key; .value))
  | .artUrl = .artUrl[7:]
  | .title = clean_title(.title; .artist)')

# No player running -> report Stopped so the widgets can hide.
echo "${out:-{\"status\": \"Stopped\"\}}"
