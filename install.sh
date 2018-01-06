#! /bin/sh

SH=$(echo $SHELL | sed -e "s/\/bin\///g")

echo "default sh: ${SH}"
SHRC=~/.${SH}rc
MYSPACE_LABAL="for my space"

PREFERENCE=~/.preference
mkdir -p $PREFERENCE

cd $(dirname $0)
WD=$(pwd)

mkdir -p ~/.vim/.backup ~/.vim/.swp ~/.vim/.undo

for file in preference/.*; do
  if [ -f $file ]; then
    if [ "$file" = */.shrc ] && [ -f $SHRC ] ;then
      has_myspace=$(cat $SHRC | grep "$MYSPACE_LABAL")
      if [ ! "$has_myspace" ] ;then
        echo "# $MYSPACE_LABAL: start" >> $SHRC
        cat $file >> $SHRC
        echo "# $MYSPACE_LABAL: end" >> $SHRC
      fi
    else
      origin_file=~/$(basename $file)
      mv -f $origin_file $PREFERENCE
      ln -s ${WD}/${file} $origin_file
    fi
  fi
done
