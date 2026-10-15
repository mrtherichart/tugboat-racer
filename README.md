# Tugboat Racer

A small native Android arcade game about Dutch **opduwers**, made in **Odin + raylib**.

## Development workflow

**ChatGPT's Linux VM is the main development environment.** Gameplay coding, Linux compilation, tests, graphics inspection and debugging happen there. After meaningful changes, the AI creates a **versioned source ZIP**, attaches it in ChatGPT, and checks that the archive is present in the ChatGPT Library.

**GitHub is only the Android build/distribution mirror.** The AI copies the same tested source files to this repository, and GitHub Actions compiles an Android APK with RayMob. There is **no GitHub Actions Linux build**. GitHub never replaces the ChatGPT VM or the source-ZIP workflow.

APK downloads: [GitHub Actions](https://github.com/mrtherichart/tugboat-racer/actions). After a successful run, select the Android artifact. Whenever possible the AI also returns the APK directly in the chat.

See [AI development workflow](docs/AI_WORKFLOW.md).

## First technical prototype (v0.1)

The current experimental project contains a simple 3D workboat, flat water, throttle/rudder controls and engine overdrive with overheating. It still requires compilation and device testing.

Linux: `bash scripts/build-linux.sh` (Odin installed).
Android: GitHub Actions runs `scripts/build-android.sh`.

Linux controls: arrows or WASD; Space for overdrive; R to reset. Android: experimental touch zones.

The creative brief remains [Tugboat Racer Game Design v0.3](https://chatgpt.com/) in this project's ChatGPT conversation; the game aims for lightweight arcade racing and Miel Monteur-style playful mechanical building.
