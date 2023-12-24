#!/bin/sh

# if running bash
if [ -n "$BASH_VERSION" ]
then
    # include .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
	# shellcheck disable=SC1091
	. "${HOME}/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ]
then
    PATH="${HOME}/bin:${PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ]
then
    PATH="${HOME}/.local/bin:${PATH}"
fi

if [ -d "${HOME}/git/devops" ]
 then
    PATH="${HOME}/git/devops/bin:${PATH}"
fi

