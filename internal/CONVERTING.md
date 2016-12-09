
## Convert mp4 to gif

```
ffmpeg -i existing_comment.mp4 -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 10 -layers Optimize -loop 0 - existing_comment.gif
```

```
ffmpeg -i add_new.mp4 -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 10 -layers Optimize -loop 0 - add_new.gif
```

```
ffmpeg -i comment_selection.mp4 -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 10 -layers Optimize -loop 0 - comment_selection.gif
```

```
ffmpeg -i convert_all.mp4 -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 10 -layers Optimize -loop 0 - convert_all.gif
```

## Crop the gif
Crop using: http://www.iloveimg.com/crop-image/crop-gif
