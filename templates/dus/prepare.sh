#!/bin/bash
cd packages/gluon
git remote add github https://github.com/freifunk-gluon/packages
git fetch github
git config core.mergeoptions --no-edit
git merge github/c-respondd
cd ../.. 
