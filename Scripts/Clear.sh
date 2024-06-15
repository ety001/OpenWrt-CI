#!/bin/bash

# 获取所有运行中容器的镜像ID
running_images=$(docker ps --format '{{.Image}}' | sort | uniq)

# 获取所有镜像的ID
all_images=$(docker images -q)

# 从所有镜像中移除正在使用的镜像
images_to_remove=$(comm -23 <(echo "$all_images" | sort) <(echo "$running_images" | sort))

# 删除剩余的镜像
if [ -n "$images_to_remove" ]; then
  echo "$images_to_remove" | xargs -r docker rmi
else
  echo "No images to remove."
fi
