#!/bin/bash
TMPBG=/tmp/screen.png
LOCK=~/.config/i3/scripts/LockScreen/lock.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')
 
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "smartblur=2:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet


# i3lock -i -u -e -f -k $TMPBG
i3lock -i $TMPBG -u -e -f --pass-media-keys --pass-power-keys --composite -k --time-font=Work-Sans --timesize=30 --timecolor=ee6c4d --time-font=Work-Sans --datesize=20 --datecolor=ee6c4d --date-font=Work-Sans --timepos="960:700" --datepos="960:730"
rm $TMPBG


# -i show image that is being passed in

# -u no indicator
# -e will ignore empty password
# -f  will show failed attempts if any
# -k will show clock
# -pass-media-keys & --pass-power-keys will let the Media and Power keys to be effective during lock
# --composite to make the compositor to work

