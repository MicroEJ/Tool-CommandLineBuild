#!/usr/bin/env bash
# Copyright 2020-2021 MicroEJ Corp. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be found with this software.

# exit if a command fail
set -o errexit
set -o pipefail
# exit when use an undeclared variable
set -o nounset
# trace command useful for debugging
# set -o xtrace

function print_usage_and_exit
{
echo -e "USAGE: \n\t$0 <PROJECT_DIRECTORY> [<BUILD_MODE>] [<PROPERTIES_FILE>]"
echo -e "\nARGS:"
echo -e "\t<PROJECT_DIRECTORY>   The absolute path of the directory to be built."
echo -e "\t<BUILD_MODE>          One of 'release', 'fetchRelease', 'snapshot' or 'personal'. Optional, defaults to 'personal'."
echo -e "\t<PROPERTIES_FILE>     An optional properties file with build specific module options (build type options are prefixed with 'easyant.inject.')"
echo -e "\n\tThe following variables must be set:"
echo -e "\t- MICROEJ_BUILD_JDK_HOME (${MICROEJ_BUILD_JDK_HOME:-})"
exit -1
}


if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]
then
  print_usage_and_exit
fi

PROJECT_DIRECTORY=`realpath $1`

BUILD_MODE=${2:-}

if [ "${3:-}" == "" ]
then
  PROPERTIES_FILE_OPTION=
else
  PROPERTIES_FILE_OPTION="-propertyfile `realpath $3`"
fi

if [ "${MICROEJ_BUILD_JDK_HOME:-}" == "" ]
then
    if [ "${JAVA_HOME:-}" == "" ]
    then
        echo -e "ERROR:\n\tUnknown environment variable MICROEJ_BUILD_JDK_HOME\n"
        print_usage_and_exit
    else
        echo -e "Set MICROEJ_BUILD_JDK_HOME to JAVA_HOME=${JAVA_HOME}"
        MICROEJ_BUILD_JDK_HOME=${JAVA_HOME}
    fi
fi

if [ "${BUILD_MODE}" == "release" ]
then
  PUBLISH_LEVEL=release
  FETCH_LEVEL=release
  PERSONAL_BUILD=false
elif [ "${BUILD_MODE}" == "fetchRelease" ]
then
  PUBLISH_LEVEL=snapshot
  FETCH_LEVEL=release
  PERSONAL_BUILD=false
elif [ "${BUILD_MODE}" == "snapshot" ]
then
  PUBLISH_LEVEL=snapshot
  FETCH_LEVEL=snapshot
  PERSONAL_BUILD=false
elif [ "${BUILD_MODE}" == "personal" ]
then
  PUBLISH_LEVEL=snapshot
  FETCH_LEVEL=snapshot
  PERSONAL_BUILD=true
elif [ "${BUILD_MODE}" == "" ]
then
  PUBLISH_LEVEL=snapshot
  FETCH_LEVEL=snapshot
  PERSONAL_BUILD=true
else
  echo -e "ERROR:\n\tWrong option value for BUILD_MODE=${BUILD_MODE}"
  print_usage_and_exit
fi

SCRIPT_DIR=$(cd $(dirname "$0") && pwd)
BUILD_KIT_HOME="${SCRIPT_DIR}/buildKit"
ANT_HOME="${BUILD_KIT_HOME}/ant"
"${MICROEJ_BUILD_JDK_HOME}/bin/java" -classpath "${ANT_HOME}/lib/ant-launcher.jar" org.apache.tools.ant.launch.Launcher -lib "${ANT_HOME}/lib" -buildfile "${SCRIPT_DIR}/easyant/build-module.ant" -Dbuild.compiler=org.eclipse.jdt.core.JDTCompilerAdapter -Dartifacts.publish.level="${PUBLISH_LEVEL}" -Dartifacts.fetch.level="${FETCH_LEVEL}" -DpersonalBuild="${PERSONAL_BUILD}" -Duser.ivysettings.file="${SCRIPT_DIR}/ivy/ivysettings.xml" -Deasyant.module.dir="${PROJECT_DIRECTORY}" -Dmicroej.buildtypes.repository.dir="${BUILD_KIT_HOME}/microej-build-repository" ${PROPERTIES_FILE_OPTION}
