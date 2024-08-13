#!/usr/bin/env bash
##===----------------------------------------------------------------------===##
##
## This source file is part of the PixelKit open source project
##
## Copyright (c) 2024 Kevin Herro
## Licensed under MIT
##
## See LICENSE.txt for license information
##
## SPDX-License-Identifier: MIT
##
##===----------------------------------------------------------------------===##

# Quickly format all .swift files in specified directories.

# List of directories to format
directories=(
  "Sources"
  "Tests"
)

# Configuration file
config=".swiftformat"

# Format each directory
for dir in "${directories[@]}"; do
  swiftformat "$dir"
done
