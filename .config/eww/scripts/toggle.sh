#!/usr/bin/env bash
# ~/.config/eww/scripts/toggle.sh
# usage: toggle.sh <window|bar> [open|close|toggle]
#   popups (animated): search status wifi volume
#   bar (alias):       top-bar + stupid-fucking-reverse-corners
#   anything else:     opened/closed as a plain eww window

POPUPS=" search status wifi volume "
BAR_WINDOWS=(top-bar stupid-fucking-reverse-corners)

name="$1"
action="${2:-toggle}"

# Read the close-animation length from the eww constant (e.g. "250ms")
dur="$(eww get reveal-duration)"
case "$dur" in
  *ms) delay=$(awk "BEGIN{print ${dur%ms}/1000}") ;;
  *s)  delay="${dur%s}" ;;
  *)   delay=0.25 ;;
esac

is_open() { eww active-windows | grep -q "^$1:"; }

# ─── Plain windows (no reveal animation) ─────────────────────────────
plain_open()  { is_open "$1" || eww open "$1"; }
plain_close() { is_open "$1" && eww close "$1"; }

# ─── Bar group ───────────────────────────────────────────────────────
bar_open()  { eww open-many "${BAR_WINDOWS[@]}"; }
bar_close() {
  # close open popups too, so they don't get stranded without a bar
  for p in $POPUPS; do "$0" "$p" close; done
  for w in "${BAR_WINDOWS[@]}"; do plain_close "$w"; done
}

# ─── Popups (animated) ───────────────────────────────────────────────
is_revealed() { [[ "$(eww get "reveal-$name")" == "true" ]]; }

open_popup() {
  local var="reveal-$name"

  # wifi and volume share a spot, so close the other one first
  case "$name" in
    wifi)   "$0" volume close & ;;
    volume) "$0" wifi close & ;;
  esac

  if ! is_open "$name"; then
    if [[ "$name" == "search" ]]; then
      eww open "$name"
      eww update "$var=true"    # revealed on map so the input takes focus
      return
    fi
    eww update "$var=false"     # make sure it starts collapsed
    eww open "$name"
    sleep 0.05                  # let the window map before revealing
  fi
  eww update "$var=true"

  [[ "$name" == "wifi" ]] && ~/.config/eww/scripts/wifi.sh &
}

close_popup() {
  is_open "$name" || return
  eww update "reveal-$name=false"
  sleep "$delay"
  # only close the window if it wasn't reopened during the animation
  is_revealed || eww close "$name"
}

# ─── Dispatch ────────────────────────────────────────────────────────
if [[ "$name" == "bar" ]]; then
  case "$action" in
    open)   bar_open ;;
    close)  bar_close ;;
    toggle) if is_open top-bar; then bar_close; else bar_open; fi ;;
  esac
elif [[ "$POPUPS" == *" $name "* ]]; then
  case "$action" in
    open)   open_popup ;;
    close)  close_popup ;;
    toggle) if is_open "$name" && is_revealed; then close_popup; else open_popup; fi ;;
  esac
else
  case "$action" in
    open)   plain_open "$name" ;;
    close)  plain_close "$name" ;;
    toggle) if is_open "$name"; then plain_close "$name"; else plain_open "$name"; fi ;;
  esac
fi
