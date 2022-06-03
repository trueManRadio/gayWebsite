# truemanradio

Dungeon master's gay website with radio

## Notes

To get best performance, please compile app with these arguments:
```bash
# Force Skia + CanvasKit rendering.
flutter build web --dart-define=FLUTTER_WEB_USE_SKIA=true --release --web-renderer canvaskit
```

### Some numbers

Testing device: Snapdragon 625, Chrome 101.0.4951.61, Android 12.1

* HTML renderer: 15-20FPS, very huge input lag
* CanvasKit renderer: 30-35FPS, input lag is very low
