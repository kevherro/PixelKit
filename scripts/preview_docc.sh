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

# Preview documentation for the specified target.

swift package --disable-sandbox preview-documentation --target $1
