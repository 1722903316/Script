#!/bin/bash

# 定义要安装的Python版本
PYTHON_VERSION=3.10.4

# 检测Linux发行版
if [ -f /etc/os-release ]; then
    # 获取VERSION_ID和ID
    . /etc/os-release
    DISTRO=$ID
    VERSION=$VERSION_ID
else
    echo "无法确定Linux发行版"
    exit 1
fi

# 根据发行版安装依赖
case $DISTRO in
    "ubuntu" | "debian")
        sudo apt-get update
        sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
        ;;
    "centos" | "rhel" | "rocky")
        sudo yum groupinstall -y "Development Tools"
        sudo yum install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel
        ;;
    *)
        echo "不支持的Linux发行版"
        exit 1
        ;;
esac

# 下载Python源代码
cd /usr/src
sudo wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

# 解压源代码
sudo tar xzf Python-$PYTHON_VERSION.tgz

# 编译和安装Python
cd Python-$PYTHON_VERSION
sudo ./configure --enable-optimizations
sudo make altinstall

# 清理文件
sudo rm /usr/src/Python-$PYTHON_VERSION.tgz

# 显示Python版本
python3.10 --version

