#!/bin/bash

install_on_arch() {
  sudo pacman -S ansible --noconfirm
}

install_on_fedora() {
  sudo dnf install ansible
}

OS="$(uname -s)"
case "${OS}" in
Linux*)
  if [ -f /etc/arch-release ]; then
    install_on_arch
  elif [ -f /etc/redhat-release ]; then
    install_on_fedora
  else
    echo "Unsupported Linux distribution"
    exit 1
  fi
  ;;
*)
  echo "Unsupported operating system: ${OS}"
  exit 1
  ;;
esac

ansible-playbook -K ~/.playbooks/user-env.yml

echo "Ansible installation complete."
