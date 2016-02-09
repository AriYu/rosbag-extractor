# rosbag-extractor
you need MATLAB 2015higer and robotics tool box

## How to use

MATLABのターミナルで

```
rosbag_extractor('path_to_bag_directory')
```

`rosbag`があるディレクトリに`rosbagファイルネーム+.mat`として保存される

## TODO

保存するトピックを`yaml`とか`json`とかで指定出来るようにする
