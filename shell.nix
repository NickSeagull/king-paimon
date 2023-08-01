# This file defines a development environment that will autoinstall all required
# dependencies for developing eLLMental Kotlin properly. To use it:
#
# - Install Nix by following https://nixos.org/download.html
# - Install direnv (https://direnv.net) either with Nix, brew, or your favorite way
#
# Put the following content to ~/.config/nixpkgs/config.nix.
#
# { allowUnfree = true; }
#
# Add the following to your .zshrc:
#
# eval "$(direnv hook zsh)"
#
# Run `direnv allow` in this directory to automatically get into the development shell
# whenever you `cd` into this directory.
#
# To start programming run
#
# idea .
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    dhall
    dhall-json
  ];
}