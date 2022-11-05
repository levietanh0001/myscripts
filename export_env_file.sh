#!/bin/bash
# . ./scripts/export_env_file.sh .env
# . /path/to/export_env_file.sh /path/to/.env
eval $(egrep "^[^#;]" $1 | xargs -d'\n' -n1 | sed 's/^/export /')