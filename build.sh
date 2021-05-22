#!/bin/bash

# Copyright (c) 2018 R. Diez - Licensed under the GNU AGPLv3

set -o errexit
set -o nounset
set -o pipefail


abort ()
{
  echo >&2 && echo "Error in script \"$0\": $*" >&2
  exit 1
}


replace_string_in_files ()
{
  local DIR="$1"
  local STRING_TO_REPLACE="$2"
  local REPLACEMENT_STRING="$3"

  find "$DIR" -type f -print0 | xargs -0 sed -i "s;$STRING_TO_REPLACE;$REPLACEMENT_STRING;g"
}


read_uptime_as_integer ()
{
  local PROC_UPTIME_CONTENTS
  PROC_UPTIME_CONTENTS="$(</proc/uptime)"

  local PROC_UPTIME_COMPONENTS
  IFS=$' \t' read -r -a PROC_UPTIME_COMPONENTS <<< "$PROC_UPTIME_CONTENTS"

  local UPTIME_AS_FLOATING_POINT=${PROC_UPTIME_COMPONENTS[0]}

  # The /proc/uptime format is not exactly documented, so I am not sure whether
  # there will always be a decimal part. Therefore, capture the integer part
  # of a value like "123" or "123.45".
  # I hope /proc/uptime never yields a value like ".12" or "12.", because
  # the following code does not cope with those.

  local REGEXP="^([0-9]+)(\\.[0-9]+)?\$"

  if ! [[ $UPTIME_AS_FLOATING_POINT =~ $REGEXP ]]; then
    abort "Error parsing this uptime value: $UPTIME_AS_FLOATING_POINT"
  fi

  UPTIME=${BASH_REMATCH[1]}
}


get_human_friendly_elapsed_time ()
{
  local -i SECONDS="$1"

  if (( SECONDS <= 59 )); then
    ELAPSED_TIME_STR="$SECONDS seconds"
    return
  fi

  local -i V="$SECONDS"

  ELAPSED_TIME_STR="$(( V % 60 )) seconds"

  V="$(( V / 60 ))"

  ELAPSED_TIME_STR="$(( V % 60 )) minutes, $ELAPSED_TIME_STR"

  V="$(( V / 60 ))"

  if (( V > 0 )); then
    ELAPSED_TIME_STR="$V hours, $ELAPSED_TIME_STR"
  fi

  printf -v ELAPSED_TIME_STR  "%s (%'d seconds)"  "$ELAPSED_TIME_STR"  "$SECONDS"
}


get_site_log_filename ()
{
  local TEMPLATE_NAME="$1"
  local SITE_CODE="$2"

  LOG_FILENAME="$SANDBOX_DIR/assembled/$TEMPLATE_NAME/$SITE_CODE/build.log"
}


#SBRANCH="$(date +%Y%m%d%H%M)"
SBRANCH="$(date +%y%m%d%H)$(head -1 $1|cut -c1-3)"  
#SBRANCH="21040718sta"
generate_site_config ()
{
  local RELBRANCH="$1"
  local TEMPLATE_NAME="$2"
  local SITE_CODE="$3"

  echo "Generating site $SITE_CODE..."

  local DIR="assembled/$TEMPLATE_NAME/$SITE_CODE"

  mkdir -p "assembled/$TEMPLATE_NAME"
  cp -r "templates/$TEMPLATE_NAME" "$DIR"

  replace_string_in_files "$DIR" SITECODE  "$SITE_CODE"
  replace_string_in_files "$DIR" RELBRANCH "$RELBRANCH"
  replace_string_in_files "$DIR" SBRANCH   "$SBRANCH"

  # Create the log file, or truncate it if it already exists.
  get_site_log_filename  "$TEMPLATE_NAME"  "$SITE_CODE"
  echo -n "" >"$LOG_FILENAME"
}


generate_all_site_configs ()
{
  echo "Generating sites for sbranch $SBRANCH ..."

  rm -rf assembled

  local -i  index
  for (( index=0; index < ${#ALL_SITE_RELBRANCHES[@]}; index += 1 )); do
    generate_site_config "${ALL_SITE_RELBRANCHES[$index]}" \
                         "${ALL_SITE_TEMPLATE_NAMES[$index]}" \
                         "${ALL_SITE_CODES[$index]}"
  done

  echo "Finished generating sites."
}


append_quoted_arg ()
{
  local APPEND_TO_VAR_NAME="$1"
  local APPEND_ARG_NAME="$2"
  local APPEND_PATH="$3"

  printf -v "$APPEND_TO_VAR_NAME"  "%s $APPEND_ARG_NAME=%q"  "${!APPEND_TO_VAR_NAME}"  "$APPEND_PATH"
}


build_images_for_site ()
{
  local RELBRANCH="$1"
  local TEMPLATE_NAME="$2"
  local SITE_CODE="$3"

  local -i target_index
  local TARGET

  local ARGS=""

  append_quoted_arg  ARGS  GLUON_SITEDIR   "$SANDBOX_DIR/assembled/$TEMPLATE_NAME/$SITE_CODE"
  append_quoted_arg  ARGS  GLUON_IMAGEDIR  "$SANDBOX_DIR/images/$TEMPLATE_NAME/$SITE_CODE"
  append_quoted_arg  ARGS  GLUON_MODULEDIR "$SANDBOX_DIR/gluon/output/modules"
  append_quoted_arg  ARGS  GLUON_PACKAGEDIR "$SANDBOX_DIR/gluon/output/packages"
  append_quoted_arg  ARGS  GLUON_SITE_VERSION $(date +%Y%m%d)
 # For the Gluon build system, BROKEN=1 means "use the experimental/unstable branch".
  append_quoted_arg  ARGS  BROKEN "1"

 # verbose logs
#  append_quoted_arg  ARGS  v "s"
#  append_quoted_arg  ARGS BUILD_LOG "1"

  # Setting GLUON_BRANCH enables the firmware autoupdater.
  append_quoted_arg  ARGS  GLUON_BRANCH  "$RELBRANCH"

  # Parameters for setting buildbot signatures
  local SIGN_ARGS=""
  SIGN_ARGS+=" $(cat $SANDBOX_DIR/buildkey/untrustworthy-buildbot-signkey.priv)"
  SIGN_ARGS+=" $SANDBOX_DIR/images/$TEMPLATE_NAME/$SITE_CODE/sysupgrade/$RELBRANCH.manifest"

  local MAKE_CMD
  local SIGN_CMD

  local PREPARED_FILENAME="$SANDBOX_DIR/.prepared"
  local PREPARED_CONTENTS

  if [ -f "PREPARED_FILENAME" ]; then
    PREPARED_CONTENTS=$(<"$PREPARED_FILENAME")
    rm -- "$PREPARED_FILENAME"
  else
    PREPARED_CONTENTS=""
  fi

  if [[ "$PREPARED_CONTENTS" != "$TEMPLATE_NAME" ]]; then

    # git reset --hard $2

    echo "Gluon make update..."

    printf -v MAKE_CMD "make update %s"  "$ARGS"
    echo "$MAKE_CMD"
    eval "$MAKE_CMD"

    for (( target_index=0; target_index < ${#TARGETS[@]}; target_index += 1 )); do

      TARGET="${TARGETS[target_index]}"

      if false; then
        echo "Cleaning the firmware for site code: $SITE_CODE, target: $TARGET ..."
        printf -v MAKE_CMD  "make clean GLUON_TARGET=%q  %s"  "$TARGET"  "$ARGS"
        echo "$MAKE_CMD"
        eval "$MAKE_CMD"
      fi

    done

    echo "Site prepare.sh ..."
    "$SANDBOX_DIR/assembled/$TEMPLATE_NAME/$SITE_CODE/prepare.sh"

  fi

  local MAKE_J_VAL
  MAKE_J_VAL="$(( $(getconf _NPROCESSORS_ONLN) * 2 ))"
# only 1 cpu core to use
#  MAKE_J_VAL=1
  for (( target_index=0; target_index < ${#TARGETS[@]}; target_index += 1 )); do

    TARGET="${TARGETS[target_index]}"

    echo "Building the firmware for site code: $SITE_CODE, target: $TARGET ..."

    printf -v MAKE_CMD "make GLUON_TARGET=%q"  "$TARGET"

    # For the Gluon build system, V=s means generate a full build log (show build commands, compiler warnings etc.).
    MAKE_CMD+=" V=s"

    MAKE_CMD+=" $ARGS"

    MAKE_CMD+=" -j $MAKE_J_VAL  --output-sync=recurse"

    echo "$MAKE_CMD"
    eval "$MAKE_CMD"

  done

  echo "$TEMPLATE_NAME" > "$PREPARED_FILENAME"

  echo "Making manifest..."

  printf -v MAKE_CMD "make manifest %s"  "$ARGS"
  echo "$MAKE_CMD"
  eval "$MAKE_CMD"
  
  printf -v SIGN_CMD "$SANDBOX_DIR/esign $SIGN_ARGS" 
  echo "$SIGN_CMD"
  eval "$SIGN_CMD"

  local SITE_IMAGE_DIR="$SANDBOX_DIR/images/$TEMPLATE_NAME/$SITE_CODE/site"

  echo "Copying build result to \"$SITE_IMAGE_DIR\" ..."
  # This directory may already exist from a previous run.
  mkdir --parents -- "$SITE_IMAGE_DIR"

  rsync --archive "$SANDBOX_DIR/assembled/$TEMPLATE_NAME/$SITE_CODE/" --exclude '*.old' --exclude '*.backup'  --exclude '*~'  --exclude '*.nonworking'   "$SITE_IMAGE_DIR"
  cp -- "$SANDBOX_DIR/build.sh" "$SITE_IMAGE_DIR/"
}


build_all_images ()
{
  local -a TARGETS=("$@")

  if (( ${#TARGETS[@]} == 0 )); then
    TARGETS+=( ar71xx-tiny )
    TARGETS+=( ar71xx-generic )
    TARGETS+=( ar71xx-nand )
    TARGETS+=( ar71xx-mikrotik )
    TARGETS+=( ath79-generic )
    TARGETS+=( brcm2708-bcm2708 )
    TARGETS+=( brcm2708-bcm2709 )
    TARGETS+=( brcm2708-bcm2710 )
    TARGETS+=( mvebu-cortexa9 )
    TARGETS+=( ipq40xx-generic )
    TARGETS+=( ipq806x-generic )
    TARGETS+=( lantiq-xrx200 )
    TARGETS+=( lantiq-xway )
    TARGETS+=( mpc85xx-generic )
    TARGETS+=( mpc85xx-p1020 )
    TARGETS+=( ramips-mt7620 )
    TARGETS+=( ramips-mt7621 )
    TARGETS+=( ramips-mt76x8 )
    TARGETS+=( ramips-rt305x )
    TARGETS+=( sunxi-cortexa7 )
    TARGETS+=( x86-generic )
    TARGETS+=( x86-geode )
    TARGETS+=( x86-64 )
    TARGETS+=( x86-legacy )
#    TARGETS+=( rockchip-armv8 )
   fi

  pushd "$GLUON_DIR" >/dev/null
  echo "Git fetching..."
  git fetch --all

  local -i index
  for (( index=0; index < ${#ALL_SITE_RELBRANCHES[@]}; index += 1 )); do

    get_site_log_filename  "${ALL_SITE_TEMPLATE_NAMES[$index]}"  "${ALL_SITE_CODES[$index]}"

    echo "Building the firmware for site code ${ALL_SITE_CODES[$index]} ..."
    echo "The site build log file is: $LOG_FILENAME"

    local UPTIME
    read_uptime_as_integer
    local SITE_UPTIME_BEGIN="$UPTIME"

    {
      build_images_for_site "${ALL_SITE_RELBRANCHES[$index]}" \
                            "${ALL_SITE_TEMPLATE_NAMES[$index]}" \
                            "${ALL_SITE_CODES[$index]}"
    } 2>&1 | tee --append -- "$LOG_FILENAME"

    # The whole build takes a long time. By recording the build time for each site,
    # it is easier to measure any impact on the the build performance after
    # making changes to the build system.
    read_uptime_as_integer
    local ELAPSED_TIME_STR
    get_human_friendly_elapsed_time "$(( UPTIME - SITE_UPTIME_BEGIN ))"
    echo "Finished building the firmware for site code ${ALL_SITE_CODES[$index]}. Elapsed time: $ELAPSED_TIME_STR."

    # We could compress the log file here, but it is not worth it.
    # It saves little space compared to the rest of the generated files,
    # and it makes it more inconvenient to open the log file.
    if false; then
      gzip --best -- "$LOG_FILENAME"
    fi

  done

  popd >/dev/null

  # rename output to images with timestamp
  mv "./images" "./images-$DATE_SUFFIX"

  # I do not think that we build any modules yet.
#  echo check for modules
#  if [ -d "./gluon/output/modules" ]; then
#    ARE_THERE_MODULES=true
#  else
#    ARE_THERE_MODULES=false
#  fi
#  if $ARE_THERE_MODULES; then
#    echo moving modules-dir $SANDBOX_DIR/gluon/output/modules
#    mv "$SANDBOX_DIR/gluon/output/modules" "$SANDBOX_DIR/images-$DATE_SUFFIX/."
#   fi
  
  echo check for packages wich are actual modules
  if [ -d "./gluon/output/packages" ]; then
    ARE_THERE_PACKAGES=true
  else
    ARE_THERE_PACKAGES=false
  fi
  if $ARE_THERE_PACKAGES; then
    echo moving packages-dir $SANDBOX_DIR/gluon/output/packages
    mv "$SANDBOX_DIR/gluon/output/packages" "$SANDBOX_DIR/images-$DATE_SUFFIX/."
   fi

  echo "Finished building images:"
  echo "- Images  dir: images-$DATE_SUFFIX"
  if $ARE_THERE_MODULES; then
    echo "- Modules dir: modules-$DATE_SUFFIX/modules"
   fi
  if $ARE_THERE_PACKAGES; then
    echo "- Packages dir: modules-$DATE_SUFFIX/packages"
   fi
}


declare -a ALL_SITE_RELBRANCHES=()
declare -a ALL_SITE_GIT_BRANCHES=()  # TODO: Not used at the moment.
declare -a ALL_SITE_TEMPLATE_NAMES=()
declare -a ALL_SITE_CODES=()

parse_sites_file ()
{
  local FILENAME="$1"

  local LINE
  local COMPONENTS

  while read -r LINE; do

    # We could allow comments in the file. Here we would remove them.

    if [ -z "$LINE" ] || [ "$(echo $LINE|cut -c1)" == "#" ] ; then
      continue
    fi

    IFS=$' \t'  read -r -a COMPONENTS <<< "$LINE"

    if (( ${#COMPONENTS[@]} != 4 )); then
      abort "Syntax error parsing this line: $LINE"
    fi

    ALL_SITE_RELBRANCHES+=( "${COMPONENTS[0]}" )
    ALL_SITE_GIT_BRANCHES+=( "${COMPONENTS[1]}" )
    ALL_SITE_TEMPLATE_NAMES+=( "${COMPONENTS[2]}" )
    ALL_SITE_CODES+=( "${COMPONENTS[3]}" )

  done < "$FILENAME"

  if (( ${#ALL_SITE_RELBRANCHES[@]} == 0 )); then
    abort "Could not read any sites from the sites file."
  fi
}


# ----------- Entry point -----------

if (( $# == 0 )); then
  echo "Usage: build.sh <sites file> [target1] [target2] [...]"
  exit 0
fi

if ! [ -f "$1" ]; then
  abort "File \"$1\" does not exist."
fi

parse_sites_file "$1"

SANDBOX_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

generate_all_site_configs

GLUON_DIR="$SANDBOX_DIR/gluon"

DATE_SUFFIX="$(date +%s)"

shift

build_all_images "$@"
