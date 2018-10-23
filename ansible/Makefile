REPO?=kubevirt
PROJECT?=kubevirt-ansible
VERSION?=master
ROLE?=cdi

fetch:
	rm -rf roles/$(ROLE)
	wget -qO- https://api.github.com/repos/$(REPO)/$(PROJECT)/tarball/$(VERSION) | tar xzv --wildcards "*/roles/$(ROLE)" --strip-components=1
