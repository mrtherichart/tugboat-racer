# Tugboat Racer — AI workflow contract

This is a ChatGPT-driven Android game. The user directs development **from this ordinary chat on an Android phone**.

## Priority and custody of source

1. **Main workspace: ChatGPT's Linux VM.** Unpack the newest source ZIP from this chat or its Library, edit it locally, compile and test Linux there. Use the VM's shell, screenshots, automated tests and temporary tools as with previous Odin projects.
2. **Archive: versioned source ZIP in ChatGPT.** After meaningful code changes, bundle the complete buildable source (including build scripts and assets). Name files `tugboat-racer-source-vX.Y.Z.zip`, attach them to the chat, then **verify they appear in the user's Library**. Avoid duplicate Library uploads.
3. **Second copy: GitHub.** Mirror the **same tested ZIP contents** into `mrtherichart/tugboat-racer`. This is a build staging area and convenient backup. Avoid implementing game features primarily in GitHub or treating CI as the Linux development machine.
4. **Android APK: GitHub Actions only.** The single Actions job uses the Android NDK, Odin and RayMob. It builds from the mirrored source and uploads an APK artifact. Inspect build logs and fix Android-specific errors. The Linux build remains in the ChatGPT VM.
5. **Distribute back here.** Prefer downloading the finished APK artifact and attaching the APK in the chat. If that's unavailable, link to the exact successful GitHub Actions run/artifact so the user can download it on Android.
6. **Real-device validation.** The user installs APKs on their phone and reports launch issues, touch/UX problems and performance. AI tests everything practical on Linux first.

## Build notes

- Shared Odin game source is in `src/`.
- Linux build: `bash scripts/build-linux.sh` in the ChatGPT VM.
- Android build: `bash scripts/build-android.sh` in GitHub Actions, with NDK/SDK configured there.
- GitHub Actions contains **no Linux job or Linux job dependency**.
- Existing toolchain scripts are a technical prototype; Android linking has not been validated. Treat a green CI build and successful on-phone launch as separate evidence.
- Never tell the user an APK or test succeeded until the artifact or result has been verified.
- ChatGPT's VM is temporary: a versioned ZIP is required to preserve tested state.
