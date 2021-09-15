#!/usr/bin/env bash
root=../../../docs/release/2.1.0
########### Make HTML
## Build html docs
sphinx-build -P -b html -d ../../doctrees/ -a . $root
rm -rf $root/_sources/
rm -rf ../../doctrees/
rm -rf $root/_static/bootstrap-2.3.2
rm -rf $root/_static/bootswatch-2.3.2
rm $root/.buildinfo
rm $root/objects.inv
