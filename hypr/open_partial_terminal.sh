#!/usr/bin/env bash

selection=$(slurp)

# check return value
if (($? == 0)); then 
	pos_x=$(echo $selection | cut -d ' ' -f 1 | cut -d ',' -f 1)
	pos_y=$(echo $selection | cut -d ' ' -f 1 | cut -d ',' -f 2)
	size_x=$(echo $selection | cut -d ' ' -f 2 | cut -d 'x' -f 1)
	size_y=$(echo $selection | cut -d ' ' -f 2 | cut -d 'x' -f 2)

	hyprctl dispatch 'hl.dsp.exec_cmd("kitty", {float = true, size = {'${size_x}','${size_y}'},move = {'${pos_x}','${pos_y}'}})'
fi
