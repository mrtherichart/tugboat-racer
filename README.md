# Tugboat Racer

A lightweight Android 3D arcade racer about old Dutch opduwers, developed through ChatGPT.

## Current prototype — v0.1

One crude 3D workboat, a canal, throttle, steering and risky overdrive. This is a **toolchain/handling prototype**, not the finished game.

**Linux controls:** arrows (or WASD), Space to overdrive, R to restart.
**Android controls:** touchscreen zones labelled LEFT, RIGHT, THROTTLE and BOOST.

The same `src/` Odin source is compiled for Linux and Android. Linux uses Odin's bundled raylib; Android temporarily assembles the app with RayMob.

## Download builds

Open [Actions](https://github.com/mrtherichart/tugboat-racer/actions). A successful workflow has `tugboat-linux` and `tugboat-android-debug` downloads under **Artifacts**. Android delivers a debug-signed APK.

Build verification and real-device startup are separate milestones. Android is experimental until the first APK has launched on a phone.

## Workflow

ChatGPT edits source and inspects CI results. GitHub stores source and runs builds. The user only needs an APK for Android-specific testing. Toolchain versions are pinned in CI.

The creative design is in this project's conversation (`tugboat_racer_game_design_v03.md`): playful boat building and painting, varied early-twentieth-century engines, Dutch canals, lightweight arcade physics and risky engine overdrive.
