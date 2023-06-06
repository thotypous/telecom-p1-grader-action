#!/bin/bash
cd /github/workspace
if [[ -e grader ]]; then echo "grader already exists" >&2; exit 1; fi
exec ./run-grader
