CHROOT=""
RELEASE=$(lsb_release -s -c)

export PACKER_BUILD_NAME
export CHROOT

if [[ "$PACKER_BUILD_NAME" =~ "-i386" ]]; then
	CHROOT="/var/lib/${RELEASE}-i386"
fi

# Run a command in the chroot
do_chroot() {
	sudo chroot $CHROOT "$@"
}

# Run a command in the chroot if applicable
only_if_chroot() {
	if [ -n "$CHROOT" ]; then
		do_chroot "$@"
	fi
}

# Run a command in the system or the chroot
try_chroot() {
	if [ -z "$CHROOT" ]; then
		if [ "$1" = "sudo" ]; then
			shift
		fi
		sudo "$@"
	else
		do_chroot "$@"
	fi
}
