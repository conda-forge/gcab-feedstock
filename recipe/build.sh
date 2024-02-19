#!/bin/bash

set -euo pipefail

mkdir -p build
cd build

# need gtkdoc-scan for doc buildin
rm ../docs/reference/meson.build
touch ../docs/reference/meson.build 

export PKG_CONFIG=$BUILD_PREFIX/bin/pkg-config
if [[ "${build_platform}" != "${target_platform}" ]]; then
  # Generation of introspection isn't currently working in cross-compilation mode.
  export MESON_ARGS="${MESON_ARGS:-} -Dintrospection=false"
fi
meson ${MESON_ARGS:-} --buildtype=release --prefix="$PREFIX" --backend=ninja -Dlibdir=lib -Dintrospection=true -Dvapi=true ..
ninja
ninja install

