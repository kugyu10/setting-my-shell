#!/bin/zsh
# 引数の画像ファイルをwebpに変換するsh

if [ $# -eq 0 ]; then
  echo "ファイル名の指定が必要です"
  exit 1
fi

for I;
do

  #同名ファイルを避ける処理
  oFileName=${I%.*}
  fileNum=0
  while [ -f ${oFileName}.webp ]
  do
    fileNum=`expr $fileNum + 1`
    oFileName="${I%.*}_${fileNum}"
  done

  ext=${I##*.}
  #gif 処理
  if [ "$ext" == "gif" ] || [ "$ext" == "GIF" ]; then
    gif2webp -quiet -q 100 -metadata icc -o ${oFileName}.webp $I
  fi

  #jpg/png 処理
  if [ "$ext" == "jpg" ] || [ "$ext" == "jpeg" ] || [ "$ext" == "png" ] || [ "$ext" == "JPG" ] || [ "$ext" == "JPEG" ] || [ "$ext" == "PNG" ]; then
    cwebp -quiet -q 75 -metadata icc -o ${oFileName}.webp $I
  fi

done

exit 0
