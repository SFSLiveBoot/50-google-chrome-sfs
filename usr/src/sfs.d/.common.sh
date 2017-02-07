#!/bin/sh

: ${lbu:=/opt/LiveBootUtils}
. "$lbu/scripts/common.func"

: ${repo:=https://dl.google.com/linux/chrome/deb}
: ${package_name:=google-chrome-stable}
: ${packages_url:=$repo/dists/stable/main/binary-amd64/Packages.gz}


extract_deb_field() {
  local url="$1" package="$2" field="$3"
  curl -s "$url" | gzip -dc | grep -e ^Package: -e "^$field:" | grep -FxA1 "Package: $package" | awk "/^$field: /{print \$2}"
}

latest_url() {
  echo "$repo/$(extract_deb_field "$packages_url" "$package_name" "Filename")"
}

latest_version() {
  extract_deb_field "$packages_url" "$package_name" "Version"
}

current_version() {
  "$DESTDIR/opt/google/chrome/chrome" --version | grep -Eo '[1-9][0-9.]+'
}
