.DEFAULT_GOAL := dry-run

.PHONY: install-latest-archinstall
archinstall:
	pacman -Sy --noconfirm python-pip
	pip install -U archinstall

.PHONY: archinstall-git
archinstall-git: clean # Install latest version of archinstall
	pacman -Sy --noconfirm git glibc python-pip
	pacman -Rs --noconfirm archinstall; pip uninstall --yes archinstall
	git clone https://github.com/archlinux/archinstall .archinstall
	cd .archinstall && python setup.py install

.PHONY: install-virtualbox
install-virtualbox: # Run installer using virtualbox config files
	python -m archinstall --config virtualbox/user_configuration.json --creds virtualbox/user_credentials.json

.PHONY: install-kde
install-kde:
	python -m archinstall --config kde/user_configuration.json --creds kde/user_credentials.json

.PHONY: all
all:
	echo "coming soon"

.PHONY: test
test: # Dry run to generate a configuration
	python -m archinstall --dry-run

.PHONY: clean
clean:
	rm -rfd .archinstall
