#!/bin/bash
sshfs -o idmap=user -o transform_symlinks earth:/ ~/earth

