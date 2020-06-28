#!/bin/sh
set -eu

PKG=nss_wrapper-1.1.11
BUILD_DIR=/tmp
BUILD_PKGS='gcc make cmake'
curl --silent --show-error "https://ftp.samba.org/pub/cwrap/$PKG.tar.gz" \
    | tar -C "$BUILD_DIR/" -xz
mkdir "$BUILD_DIR/$PKG/build"
cd "$BUILD_DIR/$PKG/build"
pacman --noconfirm -Syu $BUILD_PKGS
chown postgres .
runuser -u postgres -- sh -c 'cmake .. && make'
make install
pacman --noconfirm -Rs $BUILD_PKGS
rm -rf "$BUILD_DIR/$PKG/"
