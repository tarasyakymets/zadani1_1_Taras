#!/bin/bash

ZOZ=""
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo '<meta http-equiv="Content-type" content="text/html;charset=UTF-8>" />'
echo "</head>"
echo "<body>"

process_list(){
  if [ "$ZOZ" = "y" ]; then
   echo "</ul>"
   ZOZ=""
  fi
  echo "<u>"
}

while IFS= read -r LINE; do
  LINE=$(echo "$LINE" | sed -E 's/<(https:\/\/[^>]+)>/<a href="\1">\1<\/a>/g')

  if [[ "$LINE" =~ ^\ +-\ .*$ ]]; then
   if [ "$ZOZ" = "y"; then
    process_list
    ZOZ="y"
   fi
   echo "$LINE" | sed -E 's/^\+- (.*)$/<li>\1<\/li>/'
else
  if[ "$ZOZ" = "y" ]; then
   echo "</ul>"
   ZOZ=""
  fi
  echo "$LINE"
 fi
done

if[ "$ZOZ" = "y" ]; then
 echo "</ul>"
fi

echo "</body>"
echo "</html>"
