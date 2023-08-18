#! /bin/bash

CAPTURE_PATTERN="()"

# echo $CAPTURE_PATTERN

cat | sed -E "s/$CAPTURE_PATTERN/\1/"
