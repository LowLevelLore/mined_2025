#!/usr/bin/env bash

echo -n "Commit Msg: "
read commitMsg
git checkout -b origin/server
git add .
git commit -m "$commitMsg"
git push origin HEAD:server
