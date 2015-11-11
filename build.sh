#!/bin/bash

# cd to script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## find the editor
export EDT='vi';

if [ `which editor` ]; then
    export EDT='editor';
elif [ -z "{$EDITOR+x}" ]; then
    export EDT="$EDITOR";
fi

echo '';
echo '--------------------------------------------------------------------------------';
echo 'This script create a minimal Mac OS X Application from a shell script.';
echo 'and copies the new "application" to your desktop.';
echo '';
echo 'You will be prompted to enter the code of your new shell script at the end.';
echo '(Press control-c to abort)';
echo '--------------------------------------------------------------------------------';
echo '';

read -p "What would you like the application to be called?: " prompt

new_app_path=`printf '%q' "~/Desktop/$prompt.app"`;
inner_path=`printf '%q' "$prompt"`;
inner_path="$new_app_path/Contents/MacOS/$inner_path";

eval "cp -r src/shell $new_app_path"
eval "cp -r src/blank.sh $inner_path"

export TTY=`tty`;
eval "$EDT $inner_path < $TTY > $TTY"

echo '--------------------------------------------------------------------------------';
echo 'All done, your new "Application" is ready to go!'.
echo 'Throw an icon on it via "Get Info" and drop it in your dock!';
echo '--------------------------------------------------------------------------------';
