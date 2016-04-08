#!/bin/sh

: ${lbu:=/opt/LiveBootUtils}
. "$lbu/scripts/common.func"

: ${repo:=https://dl.google.com/linux/chrome/deb}
: ${package_name:=google-chrome-stable}
: ${packages_url:=$repo/dists/stable/main/binary-amd64/Packages.gz}

latest_url() {
  echo "$repo/$(curl -s "$packages_url" | gzip -dc | grep -e ^Package: -e ^Filename: | grep -FxA1 "Package: $package_name" | awk '/^Filename: /{print $2}')"
}
