#!/bin/bash
# Copyfuck © 2010 q
#
# This script installs, updates and runs LOIC on Linux.
#
# Supported distributions:
# * Ubuntu
# * Debian
# * Fedora
#
# Usage: bash ubuntu_loic.bash <install|update|run>
#

GIT_REPO=http://github.com/NewEraCracker/LOIC.git
GIT_BRANCH=master

DEB_MONO_PKG="monodevelop liblog4net-cil-dev"
FED_MONO_PKG="mono-basic mono-devel monodevelop mono-tools"

lower() {
tr '[A-Z]' '[a-z]'
}

what_distro() {
if which lsb_release ; then
echo lsb_release -si | lower
elif grep -qi ubuntu /etc/*release ; then
echo "ubuntu"
elif [[ -e /etc/fedora-release ]] ; then
echo "fedora"
else
# Assume Debian-based
echo "opensuse"
fi
}

DISTRO=$(what_distro)

ensure_git() {
if ! which git ; then
if [[ $DISTRO = 'ubuntu' || $DISTRO = 'opensuse' ]] ; then
sudo zypper install git
elif [[ $DISTRO = 'fedora' ]] ; then
sudo yum install git
fi
fi
}

is_loic() {
is_loic_git || { [[ -d LOIC ]] && cd LOIC && is_loic_git; }
}

is_loic_git() {
[[ -d .git ]] && grep -q LOIC .git/config
}

get_loic() {
ensure_git
if ! is_loic ; then
git clone $GIT_REPO -b $GIT_BRANCH
fi
}

compile_loic() {
get_loic
if ! is_loic ; then
echo "Error: You are not in a LOIC repository."
exit 1
fi
if [[ $DISTRO = 'ubuntu' || $DISTRO = 'opensuse' ]] ; then
sudo zypper install $DEB_MONO_PKGS
elif [[ $DISTRO = 'fedora' ]] ; then
sudo yum install $FED_MONO_PKS
fi
mdtool build
}

run_loic() {
is_loic
if [[ ! -e bin/Debug/LOIC.exe ]] ; then
compile_loic
fi
if ! which mono ; then
if [[ $DISTRO = 'ubuntu' || $DISTRO = 'opensuse' ]] ; then
sudo zypper install mono-runtime
elif [[ $DISTRO = 'fedora' ]] ; then
sudo yum install mono-runtime
fi
fi
mono bin/Debug/LOIC.exe
}

update_loic() {
ensure_git
if is_loic ; then
git pull --rebase
compile_loic
else
echo "Error: You are not in a LOIC repository."
fi
}

case $1 in
install)
compile_loic
;;
update)
update_loic
;;
run)
run_loic
;;
*)
echo "Usage: $0 <install|update|run>"
;;
esac
