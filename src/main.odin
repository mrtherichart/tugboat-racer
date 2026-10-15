package game

import rl "vendor:raylib"
import "base:runtime"
import "core:math"

main :: proc() {
    context = runtime.default_context()
    rl.InitWindow(960, 540, "Tugboat Racer v0.1")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)

    x: f32 = 0
    z: f32 = 0
    heading: f32 = 0
    speed: f32 = 0
    heat: f32 = 0
    engine_failure: f32 = 0

    camera := rl.Camera3D{
        position = {10, 12, 16},
        target = {0, 0, 0},
        up = {0, 1, 0},
        fovy = 45,
        projection = .PERSPECTIVE,
    }

    hull_model := rl.LoadModelFromMesh(rl.GenMeshCube(1.8, 0.6, 4.0))
    cabin_model := rl.LoadModelFromMesh(rl.GenMeshCube(1.1, 0.9, 1.35))
    defer rl.UnloadModel(cabin_model)
    defer rl.UnloadModel(hull_model)

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()
        if dt > 0.05 { dt = 0.05 }

        throttle: f32 = 0
        rudder: f32 = 0
        overdrive := false

        if rl.IsKeyDown(.UP) || rl.IsKeyDown(.W) { throttle = 1 }
        if rl.IsKeyDown(.DOWN) || rl.IsKeyDown(.S) { throttle = -0.4 }
        if rl.IsKeyDown(.LEFT) || rl.IsKeyDown(.A) { rudder -= 1 }
        if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) { rudder += 1 }
        if rl.IsKeyDown(.SPACE) { overdrive = true }

        width := rl.GetScreenWidth()
        height := rl.GetScreenHeight()
        for i in 0..<rl.GetTouchPointCount() {
            p := rl.GetTouchPosition(i)
            if p.y > f32(height) * 0.55 && p.x < f32(width) * 0.25 {
                rudder -= 1
            } else if p.y > f32(height) * 0.55 && p.x < f32(width) * 0.5 {
                rudder += 1
            } else if p.x > f32(width) * 0.75 && p.y < f32(height) * 0.65 {
                throttle = 1
                overdrive = true
            } else if p.x > f32(width) * 0.5 && p.y > f32(height) * 0.55 {
                throttle = 1
            }
        }

        if rl.IsKeyPressed(.R) {
            x, z, heading, speed, heat, engine_failure = 0, 0, 0, 0, 0, 0
        }

        if engine_failure > 0 {
            engine_failure -= dt
            throttle = 0
            overdrive = false
        }
        if overdrive && throttle > 0 && engine_failure <= 0 {
            heat += 32 * dt
        } else {
            heat -= 19 * dt
        }
        if heat < 0 { heat = 0 }
        if heat >= 100 {
            heat = 100
            engine_failure = 2.5
            overdrive = false
        }

        max_speed: f32 = 6
        if overdrive && engine_failure <= 0 { max_speed = 9.2 }
        speed += (throttle * max_speed - speed) * dt * 1.2
        heading += rudder * (0.2 + math.abs(speed) * 0.08) * dt
        x += math.sin(heading) * speed * dt
        z += math.cos(heading) * speed * dt

        camera.target = {x, 0, z}
        camera.position = {x + 11, 11, z + 16}

        rl.BeginDrawing()
        rl.ClearBackground(rl.Color{r=172, g=210, b=223, a=255})
        rl.BeginMode3D(camera)
            rl.DrawPlane({x, -0.21, z}, {160, 160}, rl.Color{r=67, g=144, b=165, a=255})
            rl.DrawCube({-8, 0.1, 0}, 3, 0.6, 150, rl.Color{r=100, g=137, b=75, a=255})
            rl.DrawCube({8, 0.1, 0}, 3, 0.6, 150, rl.Color{r=100, g=137, b=75, a=255})
            yaw := heading * 57.29578
            rl.DrawModelEx(hull_model, {x, 0.18, z}, {0, 1, 0}, yaw, {1, 1, 1}, rl.DARKGREEN)
            rl.DrawModelEx(cabin_model, {
                x - math.sin(heading) * 0.65, 0.95,
                z - math.cos(heading) * 0.65,
            }, {0, 1, 0}, yaw, {1, 1, 1}, rl.BEIGE)
            rl.DrawCylinder({x - math.sin(heading), 1.65, z - math.cos(heading)},
                0.17, 0.17, 0.7, 8, rl.DARKGRAY)
        rl.EndMode3D()

        rl.DrawText("TUGBOAT RACER   0.1", 20, 16, 26, rl.WHITE)
        rl.DrawText("ARROWS / WASD: drive    SPACE: overdrive    R: reset", 20, 48, 16, rl.WHITE)
        rl.DrawText("ENGINE HEAT", 20, 78, 18, rl.WHITE)
        rl.DrawRectangle(20, 105, 204, 22, rl.DARKGRAY)
        heat_color := rl.ORANGE
        if heat > 75 { heat_color = rl.RED }
        rl.DrawRectangle(22, 107, i32(heat * 2), 18, heat_color)
        if engine_failure > 0 { rl.DrawText("ENGINE STALLED", 20, 136, 23, rl.RED) }

        btn_y := height - 76
        btn_w := width / 4
        for i in 0..<4 {
            color := rl.DARKBLUE
            if i == 3 { color = rl.MAROON }
            rl.DrawRectangle(i * btn_w + 4, btn_y, btn_w - 8, 65, color)
        }
        rl.DrawText("LEFT", 18, btn_y + 20, 22, rl.WHITE)
        rl.DrawText("RIGHT", btn_w + 18, btn_y + 20, 22, rl.WHITE)
        rl.DrawText("THROTTLE", btn_w * 2 + 10, btn_y + 20, 18, rl.WHITE)
        rl.DrawText("BOOST", btn_w * 3 + 14, btn_y + 20, 22, rl.WHITE)
        rl.EndDrawing()
    }
}
