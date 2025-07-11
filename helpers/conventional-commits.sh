#! /bin/bash

YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET_COLOR="\033[0m"

echo -e "❗ ${YELLOW}Conventional Commits Guide${RESET_COLOR}

${RESET_COLOR}• ${BLUE}feat${RESET_COLOR}: adds a new feature
${RESET_COLOR}• ${BLUE}fix${RESET_COLOR}: fixes a bug
${RESET_COLOR}• ${BLUE}refactor${RESET_COLOR}: rewrite/restructure some code without changing any behaviour
${RESET_COLOR}• ${BLUE}perf${RESET_COLOR}: code change that improves performance
${RESET_COLOR}• ${BLUE}style${RESET_COLOR}: changes that do not affect the meaning of the code (white-space, formatting, etc)
${RESET_COLOR}• ${BLUE}test${RESET_COLOR}: add missing tests or correcting existing tests
${RESET_COLOR}• ${BLUE}docs${RESET_COLOR}: changes related to documentation only
${RESET_COLOR}• ${BLUE}build${RESET_COLOR}: changes that affect build system or external dependencies
${RESET_COLOR}• ${BLUE}ci${RESET_COLOR}: changes related to CI configuration files and scripts
${RESET_COLOR}• ${BLUE}chore${RESET_COLOR}: miscellaneous commits e.g. modifying .gitignore
${RESET_COLOR}• ${BLUE}revert${RESET_COLOR}: changes that revert a previous commit"
