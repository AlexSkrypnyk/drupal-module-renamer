#!/usr/bin/env bash
#
# Rename a module.
#
# Usage example:
# module-renamer.sh . newname
#
# drupal-module-renamer.sh . "old_name" "old_prefix" "new_name" "new_prefix"

DIR="${1:?"Directory is required"}"

CURRENT_MACHINE_NAME="${2:?"Module current machine name is required"}"

CURRENT_PREFIX="${3:?"Module current prefix is required"}"

NEW_MACHINE_NAME="${4:?"Module new machine name is required"}"

NEW_PREFIX="${5:?"Module new prefix is required"}"

# ------------------------------------------------------------------------------

echo "==> Started module renaming in ${DIR}"

replace_string_content() {
  local needle="${1}"
  local replacement="${2}"
  local dir="${3}"
  local sed_opts

  sed_opts=(-i) && [ "$(uname)" == "Darwin" ] && sed_opts=(-i '')
  grep -rI \
    --exclude-dir=".git" \
    --exclude-dir=".idea" \
    --exclude-dir="vendor" \
    --exclude-dir="node_modules" \
    --exclude-dir=".data" \
    -l "${needle}" "${dir}" \
    | xargs sed "${sed_opts[@]}" "s@$needle@$replacement@g"
}

replace_string_filename() {
  local needle="${1}"
  local replacement="${2}"
  local dir="${3}"

  find "${dir}" -depth -name "*${needle}*" -execdir bash -c 'mv -i "${1}" "${1//'"$needle"'/'"$replacement"'}"' bash {} \;
}

replace_string_content "${CURRENT_PREFIX}" "${NEW_PREFIX}" "${DIR}"
replace_string_content "${CURRENT_MACHINE_NAME}" "${NEW_MACHINE_NAME}" "${DIR}"

replace_string_filename "${CURRENT_PREFIX}" "${NEW_PREFIX}" "${DIR}"
replace_string_filename "${CURRENT_MACHINE_NAME}" "${NEW_MACHINE_NAME}" "${DIR}"

echo "==> Finished module renaming"
