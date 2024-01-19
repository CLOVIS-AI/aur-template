#!/usr/bin/env bash

set -e  # fail fast

. ${os_toolkit_import:?}

os_info "Welcome to the OpenSavvy Automated AUR management script."

if [[ $# -ne 1 ]]; then
	os_warning --error "Please pass the name of the package you want to update, for example: ./sync.sh 'yay'"
fi

package=${1:?}
os_info "This script will synchronize the package $package."

if [[ -d packages/$package ]]; then
	os_info "The package has already been added to this repository. Updating it…"

	git subtree pull --prefix packages/$package https://aur.archlinux.org/$package.git master -m "upgrade: $package"
else
	os_info "The package is not yet a part of this repository, adding it…"
	rm -f "packages/$package"  # just in case, if a file exists with that name

	git subtree add --prefix packages/$package https://aur.archlinux.org/$package.git master -m "upgrade: Add $package"
fi
