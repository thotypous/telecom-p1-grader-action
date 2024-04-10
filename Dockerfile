FROM archlinux
RUN pacman -Syyu --noconfirm
RUN pacman-db-upgrade
RUN pacman -S --noconfirm base-devel git cmake rtaudio gtest mingw-w64-gcc python-matplotlib
COPY entrypoint.sh /entrypoint.sh
COPY TC-mingw.cmake /mingw-install/
RUN cd /tmp && \
    git clone https://github.com/thestk/rtaudio.git && \
    cd rtaudio && \
    git checkout -b stable 6.0.1 && \
    mkdir build && cd build && \
    PKG_CONFIG_LIBDIR=/mingw-install/lib/pkgconfig cmake -DCMAKE_INSTALL_PREFIX=/mingw-install -DCMAKE_TOOLCHAIN_FILE=/mingw-install/TC-mingw.cmake .. && \
    make install && \
    rm -rf /tmp/rtaudio
ENTRYPOINT ["/entrypoint.sh"]
