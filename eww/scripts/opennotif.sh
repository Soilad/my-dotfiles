class="$1"

workspace=$(hyprctl -j clients \
    | jq ".[] | select(.class==\"$class\") | .workspace.id" \
	| head -n 1)

echo "$workspace"
hyprctl dispatch workspace "$workspace"
