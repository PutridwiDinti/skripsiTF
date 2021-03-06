# hanya membuat automasi penginstalan dari tutorial install openCV di ubuntu 16.04 LTS
# referensi dapat dilihat di http://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/

# Created by m.ec2.a.najib@gmail.com
# Update dan upgrade OS ubuntu
DEBIAN_FRONTEND=noninteractive apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y autoremove

# Build tools:
DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential cmake pkg-config nano wget git

# INSTALL THE DEPENDENCIES
# OpenCV merupakan library untuk memproses, dan mengenali gambar (Image processing & computer vision). 
# Sehingga OpenCV perlu untuk me-load beberapa format gambar seperti JPEG, PNG, TIFF, etc.
# oleh karena itu perlu untuk menginstall beberapa library untuk me-load format gambar ini, 
# OpenCV perlu image I/O librari lainya yang memfasilitasi proses loading dan decoding.

# Image I/O
DEBIAN_FRONTEND=noninteractive apt-get install -y libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev

# Untuk memproses stream video dan access frame dari kamera, 
# perlu menambahkan beberapa library dibawah
# Video I/O:
DEBIAN_FRONTEND=noninteractive apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# GUI 
DEBIAN_FRONTEND=noninteractive apt-get install -y libgtk-3-dev

# library untuk mengoptimasi beberapa fungsionalitas didalam OpenCV, seperti perkalian matriks:
DEBIAN_FRONTEND=noninteractive apt-get install -y libatlas-base-dev gfortran

# Parallelism and linear algebra libraries:
DEBIAN_FRONTEND=noninteractive apt-get install -y libtbb-dev libeigen3-dev

# Python dev:
DEBIAN_FRONTEND=noninteractive apt-get install -y python-dev python3-dev python-tk python-numpy python3-tk python3-numpy \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# matplotlib digunakan untuk membuat 2D plots dari array 
DEBIAN_FRONTEND=noninteractivesudo apt-get build-dep -y python-matplotlib
DEBIAN_FRONTEND=noninteractivesudo apt-get install -y python-matplotlib

# Mendapatkan library openCV dari Github dengan vers 3.1.0
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd opencv/
mkdir build
cd build/
cmake -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DINSTALL_PYTHON_EXAMPLES=ON \
    -DOPENCV_EXTRA_MODULES_PATH= ../../opencv_contrib/modules \
    -DBUILD_EXAMPLES=ON ..
make -j2
#ubah menjadi -j4 untuk 4 core processor
#make -j4
make install
ldconfig
ln /dev/null /dev/raw1394

cd ~/.jupyter
rm jupyter_notebook_config.py
cp /installOpen/jupyter_notebook_config.py .
# Thanks.. ^^