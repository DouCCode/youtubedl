#!/bin/bash
youtuberegex='^https?:\/\/(www\.)?(youtube\.com|youtu\.be)\/.+$'
fileregex='^(/[^/ ]+)+\.txt$'
numregex='^[012]$'
linkconf=1
qualconf=1
formatconf=1

mainvid() {
  echo ""
  echo -e "\e[1;37;42mSUCCE: Downloading VIDEO from youtube.\e[0m"
  echo "choose a quality (1-3)"
  echo ""
  echo "0. LOW(480p)"
  echo "1. MID(720p)"
  echo "2. HIG(best)"
  while [ "$qualconf" -eq 1 ]; do
    read -p "> " quality
    if [[ $quality =~ $numregex ]]; then
      downloadvid
      qualconf=0
    else
      echo -e "\e[1;37;41mERROR: Invalid input. provide a number between 0 and 2.\e[0m"
      echo "Try agine."
      qualconf=1
    fi
  done
}

downloadvid() {
  if [[ $input -eq 0 ]] && [[ $quality -eq 0 ]]; then
    yt-dlp -f "best[height<=480]" $link

  elif [[ $input -eq 0 ]] && [[ $quality -eq 1 ]]; then
    yt-dlp -f "best[height<=720]" $link

  else
    yt-dlp -f best $link
  fi

  if [[ $input -eq 1 ]] && [[ $quality -eq 0 ]]; then
    yt-dlp -f "best[height<=480]" -a $link

  elif [[ $input -eq 1 ]] && [[ $quality -eq 1 ]]; then
    yt-dlp -f "best[height<=720]" -a $link

  else
    yt-dlp -f best -a $link
  fi
}

mainwav() {
  echo ""
  echo -e "\e[1;37;42mSUCCE: Downloading AUDIO from youtube.\e[0m"
  echo ""
  echo "choose a quality (1-3)"
  echo "0. LOW(128kbps)"
  echo "1. MID(192kbps)"
  echo "2. HIG(best)"
  while [ "$qualconf" -eq 1 ]; do
    read -p "> " quality
    if [[ $quality =~ $numregex ]]; then
      downloadwav
      qualconf=0
    else
      echo -e "\e[1;37;41mERROR: Invalid input. provide a number between 0 and 2.\e[0m"
      echo "Try agine."
      qualconf=1
    fi
  done
}

downloadwav() {
  if [[ $input -eq 0 ]] && [[ $quality -eq 0 ]]; then
    yt-dlp -f "bestaudio[abr<=128]" $link

  elif [[ $input -eq 0 ]] && [[ $quality -eq 1 ]]; then
    yt-dlp -f "bestaudio[abr<=192]" $link

  else
    yt-dlp -f "bestaudio" $link
  fi

  if [[ $input -eq 1 ]] && [[ $quality -eq 0 ]]; then
    yt-dlp -f "bestaudio[abr<=]" -a $link

  elif [[ $input -eq 1 ]] && [[ $quality -eq 1 ]]; then
    yt-dlp -f "bestaudio[abr<=720]" -a $link

  else
    yt-dlp -f "bestaudio" -a $link
  fi
}
# ping youtube to see if we can reach it
echo "checking Internet connection"
# ping -c 4 "https://www.youtube.com/" >/dev/zero 2>&1

# Check the exit status of ping
# if [ $? -eq 0 ]; then
#  echo -e "\e[1;37;42mSUCCE: Internet connection avilable.\e[0m"
# else
#   echo -e "\e[1;37;41mERROR: Internet connection is unavilable. Check you connection and try agine.\e[0m"
#   exit 1
# fi

# Ask the user for a URL or file address
echo "Give the link or the file address"

while [ "$linkconf" -eq 1 ]; do
  read -p "> " link
  # Check if the input matches the YouTube regex or the file regex
  if [[ $link =~ $youtuberegex ]]; then
    echo -e "\e[1;37;42mSUCCE: Valid URL input.\e[0m"
    linkconf=0
    input=0 # 0 means its a video
  elif [[ $link =~ $fileregex ]]; then
    echo -e "\e[1;37;42mSUCCE: Valid ADDRESS input.\e[0m"
    linkconf=0
    input=1 # 1 means its a file
  else
    echo -e "\e[1;37;41mERROR: Invalid input. provide a link or textfile.\e[0m"
    echo "Try agine."
    linkconf=1
  fi
done

echo ""
echo "What do you want to download? (0-1)"
echo ""
echo "0. Video"
echo "1. Audio"

while [[ $formatconf -eq 1 ]]; do
  read -p "> " format

  if [[ $format =~ ^[01]$ ]]; then
    echo -e "\e[1;37;42mSUCCE: Valid input.\e[0m"
    formatconf=0

    if [[ $format -eq 0 ]]; then
      mainvid
    else
      mainwav
    fi

  else

    echo -e "\e[1;37;41mERROR: Invalid input. provide a number between 0 and 1.\e[0m"
    formatconf=1
    echo "Try agine."
  fi

done
