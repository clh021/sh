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

.PHONY: install
install: # Run installer using config files
	python -m archinstall --config config.json --creds creds.json --disk_layouts disk-layouts.json

.PHONY: dry-run
dry-run: # Dry run
	python -m archinstall --config config.json --creds creds.json --disk_layouts=disk-layouts.json --dry-run

.PHONY: clean
clean:
	rm -rfd .archinstall
