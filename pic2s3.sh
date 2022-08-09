#!/bin/zsh
# 画像をwebpにしてS3にアップする

I=$1
ext=${I##*.}
oFileName=${I%.*}

#webpなら即アップ
if [ "$ext" == "webp" ] || [ $"ext" == "WEBP" ]; then
  #S3にアップ処理
  aws s3 cp ${oFileName}.webp "s3://kugyu10-post/" --quiet --acl public-read
  echo "https://kugyu10-post.s3.ap-northeast-1.amazonaws.com/"${oFileName}.webp
  exit 0
fi

#webpでないならwebpに変換してからアップする
  #同名ファイルを避ける処理
  fileNum=0
  while [ -f ${oFileName}.webp ]
  do
    fileNum=`expr $fileNum + 1`
    oFileName="${I%.*}_${fileNum}"
  done
  echo "18 $oFileName"
  #gif 処理
  if [ "$ext" == "gif" ] || [ "$ext" == "GIF" ]; then
    gif2webp -quiet -q 100 -metadata icc -o ${oFileName}.webp $I
  fi

  #jpg/png 処理
  if [ "$ext" == "jpg" ] || [ "$ext" == "jpeg" ] || [ "$ext" == "png" ] || [ "$ext" == "JPG" ] || [ "$ext" == "JPEG" ] || [ "$ext" == "PNG" ]; then
    cwebp -quiet -q 75 -metadata icc -o ${oFileName}.webp $I
  fi
fi

  #S3にアップ処理
  aws s3 cp ${oFileName}.webp "s3://kugyu10-post/" --quiet --acl public-read
  echo "https://kugyu10-post.s3.ap-northeast-1.amazonaws.com/"${oFileName}.webp
exit 0
