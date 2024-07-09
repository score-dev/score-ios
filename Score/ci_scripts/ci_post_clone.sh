#!/bin/sh

#  ci_post_clone.sh
#  Score
#
#  Created by sole on 7/9/24.
#  

# Install CocoaPods using Homebrew.
brew install cocoapods

# Install dependencies you manage with CocoaPods.
pod install

# *.xconfig 파일이 생성될 폴더 경로
FOLDER_PATH="/Volumes/workspace/repository/Score/Resource"
# *.xconfig 파일 이름
CONFIG_FILENAME="Secrets.xcconfig"

# *.xconfig 파일의 전체 경로 계산
CONFIG_FILE_PATH="$FOLDER_PATH/$CONFIG_FILENAME"

# 만약 파일이 이미 존재하지 않으면 새로 생성
if [ ! -f "$CONFIG_FILE_PATH" ]; then
    echo "# $CONFIG_FILENAME file" > "$CONFIG_FILE_PATH"
fi


# 환경 변수에서 값을 가져와서 *.xconfig 파일에 추가하기
echo "SERVER_BASE_URL = $SERVER_BASE_URL" >> "$CONFIG_FILE_PATH"

echo "NAVER_CLIENT_ID = $NAVER_CLIENT_ID" >> "$CONFIG_FILE_PATH"
echo "NAVER_SECRET_KEY = $NAVER_SECRET_KEY" >> "$CONFIG_FILE_PATH"

echo "KAKAO_APP_ID = $KAKAO_APP_ID" >> "$CONFIG_FILE_PATH"

echo "GOOGLE_CLIENT_ID = $GOOGLE_CLIENT_ID" >> "$CONFIG_FILE_PATH"
echo "GOOGLE_REVERSED_CLIENT_ID = $GOOGLE_REVERSED_CLIENT_ID" >> "$CONFIG_FILE_PATH"
echo "GOOGLE_SERVER_CLIENT_ID = $GOOGLE_SERVER_CLIENT_ID" >> "$CONFIG_FILE_PATH"

