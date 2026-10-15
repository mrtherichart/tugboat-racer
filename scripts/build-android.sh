#!/usr/bin/env bash
set -euo pipefail
: "${ANDROID_HOME:?ANDROID_HOME missing}"
: "${ANDROID_NDK_HOME:?ANDROID_NDK_HOME missing}"
git clone --recursive https://github.com/Bigfoot71/raymob.git raymob
git -C raymob checkout --detach 6ff85822872391f399c80771981d8ce25e0a4cfd
git -C raymob submodule update --init --recursive
: > raymob/app/src/main/cpp/main.c
sed -i 's/^app.name=.*/app.name=Tugboat Racer/' raymob/gradle.properties
sed -i 's/^app.application_id=.*/app.application_id=art.mrtherich.tugboatracer/' raymob/gradle.properties
echo 'target_link_libraries(${APP_LIB_NAME} ${CMAKE_SOURCE_DIR}/odin.a)' >> raymob/app/src/main/cpp/CMakeLists.txt
ODIN_ANDROID_NDK="$ANDROID_NDK_HOME" odin build src -out:raymob/app/src/main/cpp/odin.o -target:linux_arm64 -subtarget:android -build-mode:object
"$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar" rcs raymob/app/src/main/cpp/odin.a raymob/app/src/main/cpp/odin.o
(cd raymob && chmod +x gradlew && ./gradlew --no-daemon :app:assembleDebug)
find raymob/app/build/outputs/apk -name '*.apk' -print
