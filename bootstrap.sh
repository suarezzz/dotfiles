#! /bin/sh

set -f

exclude_paths=(
  '.git'
  '.backup'
  '.cache'
)

exclude_files=(
  '.DS_Store'
  'README.md'
  '.gitignore'
  'bootstrap.sh'
)

# complete cmd
cmd='find -s .'
for i in ${exclude_paths[@]}
do
  cmd=$cmd" -path ./$i -prune -o"
done
for i in ${exclude_files[@]}
do
  cmd=$cmd" -not -name $i"
done
cmd=$cmd" -print"

files=$($cmd)
echo $cmd
for file in $files
do
  if [ -f $file ]
  then
    origin=~/$file
    target=$PWD/$file
    if [ -e $origin -o -h $origin ]
    then
      mkdir -p $(dirname $PWD/.cache/$file)
      mv -f $origin $PWD/.cache/$file
    fi
    mkdir -p $(dirname $origin)
    ln -s $target $origin
  fi
done
